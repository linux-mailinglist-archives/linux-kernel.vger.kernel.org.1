Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFDE2D9733
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 12:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407536AbgLNLOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 06:14:14 -0500
Received: from foss.arm.com ([217.140.110.172]:46054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407224AbgLNLN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 06:13:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28CC30E;
        Mon, 14 Dec 2020 03:12:36 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.27.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AEAB3F66B;
        Mon, 14 Dec 2020 03:12:35 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:12:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: arch/arm64/kernel/entry-common.c:68:25: warning: no previous
 prototype for 'el1_sync_handler'
Message-ID: <20201214111216.GA41558@C02TD0UTHF1T.local>
References: <202012141530.KRuZaGFd-lkp@intel.com>
 <20201214102847.GA2475@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214102847.GA2475@gaia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:28:48AM +0000, Catalin Marinas wrote:
> On Mon, Dec 14, 2020 at 03:12:34PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   2c85ebc57b3e1817b6ce1a6b703928e113a90442
> > commit: ed3768db588291ddb5dc794daed12cc751373566 arm64: entry: convert el1_sync to C
> > date:   1 year, 2 months ago
> > config: arm64-randconfig-r021-20201214 (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed3768db588291ddb5dc794daed12cc751373566
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout ed3768db588291ddb5dc794daed12cc751373566
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> arch/arm64/kernel/entry-common.c:68:25: warning: no previous prototype for 'el1_sync_handler' [-Wmissing-prototypes]
> >       68 | asmlinkage void notrace el1_sync_handler(struct pt_regs *regs)
> 
> Do we actually need to fix these? It's asmlinkage and called from
> assembly, it wouldn't understand a prototype anyway.

Given we do this for a few other asmlinkage functions in this area, I'll
spin a patch to add the few missing entry-common.c prototypes to
asm/exception.h for consistency.

It's not strictly necessary, but it's vastly less effort than fighting
the testing systems. ;)

Thanks,
Mark.
