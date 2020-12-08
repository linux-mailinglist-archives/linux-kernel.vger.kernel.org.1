Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4852D3435
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgLHUco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:32:44 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45554 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgLHUco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:32:44 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Cr9m00D2Mz1qs04;
        Tue,  8 Dec 2020 20:51:11 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Cr9lz6C8Sz1qryt;
        Tue,  8 Dec 2020 20:51:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id CZyAJDmzMGCZ; Tue,  8 Dec 2020 20:51:11 +0100 (CET)
X-Auth-Info: j94MMSxkK5Fd8e1KRm6cOObRgssA27kGQmdMpYtrOr8WMT7p4/X68rXZIOuyRuAN
Received: from igel.home (ppp-46-244-165-151.dynamic.mnet-online.de [46.244.165.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  8 Dec 2020 20:51:11 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 7FFB02C32D5; Tue,  8 Dec 2020 20:51:10 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fixed kernel test robot warning
References: <1607455638-4436-1-git-send-email-jrdr.linux@gmail.com>
X-Yow:  Once, there was NO fun...  This was before MENU planning,
 FASHION statements or NAUTILUS equipment...
 Then, in 1985..  FUN was completely encoded in this tiny MICROCHIP..
 It contain 14,768 vaguely amusing SIT-COM pilots!!
 We had to wait FOUR BILLION years but we finally got JERRY LEWIS,
 MTV and a large selection of cream-filled snack cakes!
Date:   Tue, 08 Dec 2020 20:51:10 +0100
In-Reply-To: <1607455638-4436-1-git-send-email-jrdr.linux@gmail.com> (Souptick
        Joarder's message of "Wed, 9 Dec 2020 00:57:18 +0530")
Message-ID: <875z5ccc0h.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 09 2020, Souptick Joarder wrote:

> Kernel test robot throws below warning -
>
>    arch/riscv/kernel/asm-offsets.c:14:6: warning: no previous prototype
> for 'asm_offsets' [-Wmissing-prototypes]
>       14 | void asm_offsets(void)
>          |      ^~~~~~~~~~~
>
> This patch should fixed it.

Or rename it to main, like most other asm-offsets files.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
