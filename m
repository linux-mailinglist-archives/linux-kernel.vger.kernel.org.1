Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6244C2D9AF3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407685AbgLNP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:28:41 -0500
Received: from elvis.franken.de ([193.175.24.41]:40271 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732397AbgLNP2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:28:06 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kopkv-0006Cf-00; Mon, 14 Dec 2020 16:27:21 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A40ECC0375; Mon, 14 Dec 2020 16:19:25 +0100 (CET)
Date:   Mon, 14 Dec 2020 16:19:25 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v2] MIPS: Select ARCH_KEEP_MEMBLOCK if DEBUG_KERNEL to
 enable sysfs memblock debug
Message-ID: <20201214151925.GA9149@alpha.franken.de>
References: <1607343702-28318-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607343702-28318-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 08:21:42PM +0800, Tiezhu Yang wrote:
> In the current code, CONFIG_ARCH_KEEP_MEMBLOCK is not set for MIPS arch,
> memblock_discard() will discard memory and reserved arrays if they were
> allocated, select ARCH_KEEP_MEMBLOCK if DEBUG_KERNEL to give a chance to
> track "memory" and "reserved" memblocks after early boot, with this patch,
> we can see the following two sysfs interfaces under DEBUG_FS.
> 
> /sys/kernel/debug/memblock/memory
> /sys/kernel/debug/memblock/reserved
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v2:
>   - select ARCH_KEEP_MEMBLOCK only if DEBUG_KERNEL
> 
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
