Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39D298358
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 20:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418494AbgJYTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 15:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732057AbgJYTRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 15:17:11 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC1622260;
        Sun, 25 Oct 2020 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603653431;
        bh=2vUyCRMxJX2pxLnOxASbAhuopJdZm9nVaG50ILhnBrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vzt1O+eR4ITDOnR6HYR0VXgjlEvUYBYbD/2L0AT0IvlDvAfTFtSDurpuLJcZy+0ZG
         7gYfwflnSci8k0BJ8AzNu8iL8EiH/rhrDJ+SbadtBIl2PZHS9+dxkjSk8zYZTZit7Z
         E7LLTQtyhZx0Af+dKf04YcJzpadBniSn0+kquUQk=
Date:   Sun, 25 Oct 2020 12:17:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame
 size of 13472 bytes in function 'ltv350qv_power'
Message-Id: <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
In-Reply-To: <202010260230.VivTG0Gb-lkp@intel.com>
References: <202010260230.VivTG0Gb-lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 02:15:37 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d76913908102044f14381df865bb74df17a538cb
> commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
> date:   3 months ago
> config: arm64-randconfig-r005-20201026 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1c8371692dfe8245bc6690ff1262dcced4649d21)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame size of 13472 bytes in function 'ltv350qv_power' [-Wframe-larger-than=]

That's a lot of stack.

>    static int ltv350qv_power(struct ltv350qv *lcd, int power)
>               ^
>    1 warning generated.
> 
> vim +/ltv350qv_power +192 drivers/video/backlight/ltv350qv.c

Odd - the code looks pretty normal.  It is possible that your compiler
is (crazily) inlining ltv350qv_write_reg()?
