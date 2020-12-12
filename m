Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5B12D883F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 17:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439611AbgLLQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 11:31:49 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:54790 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437948AbgLLQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:30:06 -0500
Received: from CMGW (unknown [10.9.0.13])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 6A0D1175B69
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 09:29:25 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id o7lskOWUzi1lMo7ltkKxdd; Sat, 12 Dec 2020 09:29:25 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=X5QiECbe c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10 a=zTNgK-yGK50A:10
 a=evQFzbml-YQA:10 a=-pK8loF9RYyTfJpHY_sA:9 a=CjuIK1q_8ugA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R4xNtxcWFmZHlvgfTqaT+jfjcH4B3S6JnKC1T5xk6pA=; b=iqvV9Anau02+SuVtCv0tTTsb2P
        Mm0jUOtSd80s8fuPWEVJOZhtLLgfDtAebRzQ/cO4qnAYdr3YAL7+dnFQnTcXmrG+tUfr+EXWjWDCW
        ywycj5ZP22zeFtHr0zPwkWrjUASYQkCFVRCfWPGyLDpAzRCoVRODbMDpZjdMHKCxLUsdJCaTXrMfK
        Po8BPr+1R7uKAed9syXKeuLwxoW3/ArHRU4x2BOO4YXsOi3v0Bjuhcqs5Hre9p3Xz43EzvzdddHG6
        BJ5P9NG431IU4Xjez5AR8pzruJfuTbBqko+cffISpeE0grVqvo5Gbe03Xp4skbUxSka4eFTIJ4Nk8
        cDw2EWMQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50178 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1ko7ls-002zTP-HT; Sat, 12 Dec 2020 16:29:24 +0000
Date:   Sat, 12 Dec 2020 08:29:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MIPS: mm: Clean up setup of protection map
Message-ID: <20201212160716.GA206510@roeck-us.net>
References: <20201113110952.68086-1-tsbogend@alpha.franken.de>
 <20201113110952.68086-4-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113110952.68086-4-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1ko7ls-002zTP-HT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:50178
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 37
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:09:52PM +0100, Thomas Bogendoerfer wrote:
> Protection map difference between RIXI and non RIXI cpus is _PAGE_NO_EXEC
> and _PAGE_NO_READ usage. Both already take care of cpu_has_rixi while
> setting up the page bits. So we just need one setup of protection map
> and can drop the now unused (and broken for RIXI) PAGE_* defines.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---

This patch results in:

drivers/video/fbdev/udlfb.c: In function 'dlfb_ops_mmap':
drivers/video/fbdev/udlfb.c:343:52: error: 'PAGE_SHARED' undeclared (first use in this function)
  343 |   if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
      |                                                    ^~~~~~~~~~~

when building mips:allmodconfig.

Guenter

---
bisect log:

# bad: [3cc2bd440f2171f093b3a8480a4b54d8c270ed38] Add linux-next specific files for 20201211
# good: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
git bisect start 'HEAD' 'v5.10-rc7'
# bad: [0a701401d4e29d9e73f0f3cc02179fc6c9191646] Merge remote-tracking branch 'crypto/master'
git bisect bad 0a701401d4e29d9e73f0f3cc02179fc6c9191646
# bad: [196d9132cc82feb410b6386491de9ac5661b0b76] Merge remote-tracking branch 'printk/for-next'
git bisect bad 196d9132cc82feb410b6386491de9ac5661b0b76
# good: [5bc192c72197553fe3b934830482caf931347c9c] Merge remote-tracking branch 'arm-soc/for-next'
git bisect good 5bc192c72197553fe3b934830482caf931347c9c
# bad: [24aa026d842ebfa5ff9cefe92bb3d6cc6a558206] Merge remote-tracking branch 'risc-v/for-next'
git bisect bad 24aa026d842ebfa5ff9cefe92bb3d6cc6a558206
# good: [44e8eb23644eaf38dbfaf4a68d08b13c190f58c2] Merge remote-tracking branch 'm68knommu/for-next'
git bisect good 44e8eb23644eaf38dbfaf4a68d08b13c190f58c2
# good: [ff57698a9610fcf7d9c4469bf68c881eff22e2f8] powerpc: Fix update form addressing in inline assembly
git bisect good ff57698a9610fcf7d9c4469bf68c881eff22e2f8
# bad: [a7ab7f9e2de7e39cafa041fcba425935b2c188bf] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect bad a7ab7f9e2de7e39cafa041fcba425935b2c188bf
# good: [724d554a117a0552c2c982f0b5cd1d685274d678] MIPS: vdso: Use vma page protection for remapping
git bisect good 724d554a117a0552c2c982f0b5cd1d685274d678
# bad: [27f45b5690f7cfe916c83aaa7263ac3da7e251ee] Merge remote-tracking branch 'mips/mips-next'
git bisect bad 27f45b5690f7cfe916c83aaa7263ac3da7e251ee
# bad: [79109a515ac3f1009632f4a4c81597e9438a2d65] MIPS: configs: drop unused BACKLIGHT_GENERIC option
git bisect bad 79109a515ac3f1009632f4a4c81597e9438a2d65
# bad: [74a2810b7c1fcd60c87a8c47f95660628e00e97c] MIPS: KASLR: Correct valid bits in apply_r_mips_26_rel()
git bisect bad 74a2810b7c1fcd60c87a8c47f95660628e00e97c
# bad: [0df162e1377a585ced8adb932f7d6e4164e91ccf] MIPS: mm: Clean up setup of protection map
git bisect bad 0df162e1377a585ced8adb932f7d6e4164e91ccf
# good: [ed2adb74217a4054a92e0a0746e31ec6f5e466c8] MIPS: mm: shorten lines by using macro
git bisect good ed2adb74217a4054a92e0a0746e31ec6f5e466c8
# first bad commit: [0df162e1377a585ced8adb932f7d6e4164e91ccf] MIPS: mm: Clean up setup of protection map
