Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAEA2960F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900862AbgJVOd1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Oct 2020 10:33:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:3208 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895569AbgJVOd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:33:26 -0400
IronPort-SDR: TzjT8fROFA3W2p8m0iGdORzk9TaYhqphglVqwUsq/qjjUWYMnNzNSSXu71dN7Ox58JyKiMpaBH
 CIdmzBI4/m4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="229164641"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="229164641"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 07:33:24 -0700
IronPort-SDR: Wu54JjlAJLbKWrCAohe9SksMDqGvJNdFb5ASWsOM7EF8dkonHRapr9I2bWAg0M2IRcLKmJBRxq
 Ijv29X+aR1hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="348782304"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 22 Oct 2020 07:33:23 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Oct 2020 07:33:23 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 22 Oct 2020 22:33:20 +0800
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Thu, 22 Oct 2020 15:33:18 +0100
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: RE: sound/soc/intel/catpt/dsp.c:359:9: sparse: sparse: restricted
 pci_power_t degrades to integer
Thread-Topic: sound/soc/intel/catpt/dsp.c:359:9: sparse: sparse: restricted
 pci_power_t degrades to integer
Thread-Index: AQHWqES26/og2uO7GUKO2Swbv5aIfqmjk9yAgAAEtQCAABa4gA==
Date:   Thu, 22 Oct 2020 14:33:18 +0000
Message-ID: <3816407d96874a8599a589845943e885@intel.com>
References: <20201022135229.GB4077@smile.fi.intel.com>
 <20201022140920.GA501158@bjorn-Precision-5520>
In-Reply-To: <20201022140920.GA501158@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-22 4:09 PM, Bjorn Helgaas wrote:
> On Thu, Oct 22, 2020 at 04:52:29PM +0300, Andy Shevchenko wrote:
>> +Cc: Bjorn
>>
>> On Thu, Oct 22, 2020 at 03:25:49PM +0800, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   f804b3159482eedbb4250b1e9248c308fb63b805
>>> commit: 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1 ASoC: Intel: Select catpt and deprecate haswell
>>> date:   3 weeks ago
>>> config: i386-randconfig-s002-20201022 (attached as .config)
>>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>> reproduce:
>>>          # apt-get install sparse
>>>          # sparse version: v0.6.3-dirty
>>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1
>>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>          git fetch --no-tags linus master
>>>          git checkout 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1
>>>          # save the attached .config to linux build tree
>>>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>>
>>> "sparse warnings: (new ones prefixed by >>)"
>>>>> sound/soc/intel/catpt/dsp.c:359:9: sparse: sparse: restricted pci_power_t degrades to integer
>>>     sound/soc/intel/catpt/dsp.c:372:9: sparse: sparse: restricted pci_power_t degrades to integer
>>>     sound/soc/intel/catpt/dsp.c:423:9: sparse: sparse: restricted pci_power_t degrades to integer
>>>     sound/soc/intel/catpt/dsp.c:447:9: sparse: sparse: restricted pci_power_t degrades to integer
>>
>> I dunno who and why created that specific bitwise type. I met not the first
>> time the same Sparse complain.
> 
> Thanks for the cc.  Yeah, I hate that too.  It's one of the few
> remaining warnings in drivers/pci/.  It's my goal to eradicate it for
> v5.11.
> 

I've ignored that warning when upstreaming catpt ASoC driver as I
believe code is more readable when constants are not prepended with
explicit cast in this very case.

Should the warning be ignored (leave code as is) -or- do you want me to
prepend all PCI_Dx usages with explicit cast regardless of my initial
intentions?

Regards,
Czarek

