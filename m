Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAB2D964C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392611AbgLNK3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgLNK3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:29:32 -0500
Date:   Mon, 14 Dec 2020 10:28:48 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: arch/arm64/kernel/entry-common.c:68:25: warning: no previous
 prototype for 'el1_sync_handler'
Message-ID: <20201214102847.GA2475@gaia>
References: <202012141530.KRuZaGFd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202012141530.KRuZaGFd-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 03:12:34PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2c85ebc57b3e1817b6ce1a6b703928e113a90442
> commit: ed3768db588291ddb5dc794daed12cc751373566 arm64: entry: convert el1_sync to C
> date:   1 year, 2 months ago
> config: arm64-randconfig-r021-20201214 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed3768db588291ddb5dc794daed12cc751373566
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ed3768db588291ddb5dc794daed12cc751373566
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/arm64/kernel/entry-common.c:68:25: warning: no previous prototype for 'el1_sync_handler' [-Wmissing-prototypes]
>       68 | asmlinkage void notrace el1_sync_handler(struct pt_regs *regs)

Do we actually need to fix these? It's asmlinkage and called from
assembly, it wouldn't understand a prototype anyway.

-- 
Catalin
