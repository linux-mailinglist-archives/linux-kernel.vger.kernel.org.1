Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA02960B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900674AbgJVOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507948AbgJVOJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:09:23 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E594D2225F;
        Thu, 22 Oct 2020 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603375762;
        bh=qYpoGjmLjHs8B87IlV7CrnIiTeCXwexAWSBZI6pKcKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Io6DQhzWlVadsaFt5i3DHrpQut5RSeMfIqXLLnMND5pGqMrVEeMc1aFtv2Tu2agEx
         pzefDnymo17MQXisCbU4gaGZHrmk+EZaV/HTOqZDTDWL4ov8OTICa7iLmAoThQR2Kn
         Vu27D42OArSNFVm4jn5tDDmQoPibiturgysfBCZI=
Date:   Thu, 22 Oct 2020 09:09:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: sound/soc/intel/catpt/dsp.c:359:9: sparse: sparse: restricted
 pci_power_t degrades to integer
Message-ID: <20201022140920.GA501158@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022135229.GB4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 04:52:29PM +0300, Andy Shevchenko wrote:
> +Cc: Bjorn
> 
> On Thu, Oct 22, 2020 at 03:25:49PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f804b3159482eedbb4250b1e9248c308fb63b805
> > commit: 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1 ASoC: Intel: Select catpt and deprecate haswell
> > date:   3 weeks ago
> > config: i386-randconfig-s002-20201022 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.3-dirty
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 6cbfa11d2694b8a1e46d6834fb9705d5589e3ef1
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > "sparse warnings: (new ones prefixed by >>)"
> > >> sound/soc/intel/catpt/dsp.c:359:9: sparse: sparse: restricted pci_power_t degrades to integer
> >    sound/soc/intel/catpt/dsp.c:372:9: sparse: sparse: restricted pci_power_t degrades to integer
> >    sound/soc/intel/catpt/dsp.c:423:9: sparse: sparse: restricted pci_power_t degrades to integer
> >    sound/soc/intel/catpt/dsp.c:447:9: sparse: sparse: restricted pci_power_t degrades to integer
> 
> I dunno who and why created that specific bitwise type. I met not the first
> time the same Sparse complain.

Thanks for the cc.  Yeah, I hate that too.  It's one of the few
remaining warnings in drivers/pci/.  It's my goal to eradicate it for
v5.11.
