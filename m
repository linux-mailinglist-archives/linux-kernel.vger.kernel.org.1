Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BF296066
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368055AbgJVNv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:51:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:52546 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900428AbgJVNv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:51:29 -0400
IronPort-SDR: pK4U8yA4NYe4vB7LLrRWi7vfGtMuXx52CFrwI1oeVGGUu2756tdn3DQXUW/ONQgtP1MyEv1529
 glAZKUWkyUSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="154480916"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="154480916"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 06:51:28 -0700
IronPort-SDR: 6LRQod91vgGyvr0sS5yqmwG7ITaPIqeOSQTZqH+iFI/bmpS2QdtL+xSvZRs1+geJa4o9ckjzj9
 GDCPyN97H9vw==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="524286105"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 06:51:26 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kVb13-00DJzC-6g; Thu, 22 Oct 2020 16:52:29 +0300
Date:   Thu, 22 Oct 2020 16:52:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: sound/soc/intel/catpt/dsp.c:359:9: sparse: sparse: restricted
 pci_power_t degrades to integer
Message-ID: <20201022135229.GB4077@smile.fi.intel.com>
References: <202010221544.Gf4tzvvx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010221544.Gf4tzvvx-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Bjorn

On Thu, Oct 22, 2020 at 03:25:49PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f804b3159482eedbb4250b1e9248c308fb63b805
> commit: 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1 ASoC: Intel: Select catpt and deprecate haswell
> date:   3 weeks ago
> config: i386-randconfig-s002-20201022 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
> >> sound/soc/intel/catpt/dsp.c:359:9: sparse: sparse: restricted pci_power_t degrades to integer
>    sound/soc/intel/catpt/dsp.c:372:9: sparse: sparse: restricted pci_power_t degrades to integer
>    sound/soc/intel/catpt/dsp.c:423:9: sparse: sparse: restricted pci_power_t degrades to integer
>    sound/soc/intel/catpt/dsp.c:447:9: sparse: sparse: restricted pci_power_t degrades to integer

I dunno who and why created that specific bitwise type. I met not the first
time the same Sparse complain.

In some places I have fixed that by forcing the lvalue type, i.e.

	(__force int)PCI_D3hot

or so.

Also there are two other approaches
- leave as is (ignore this warning)
- create a helper that will convert PCI power type to an integer, like

	switch (pci_pwr) {
	default:
		return -EINVAL;
	case PCI_D3hot:
		return 3;
	...
	}

But I consider the second one is a bit silly. Dunno if PCI core has this already.

-- 
With Best Regards,
Andy Shevchenko


