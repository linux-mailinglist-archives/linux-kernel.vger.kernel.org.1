Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC74D2D33B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgLHUXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgLHUXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:23:46 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6CDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:22:51 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CrBSS2CGSz1rx8j;
        Tue,  8 Dec 2020 21:22:48 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CrBSS165fz1qryr;
        Tue,  8 Dec 2020 21:22:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id wAxyBkqaZCjP; Tue,  8 Dec 2020 21:22:47 +0100 (CET)
X-Auth-Info: XN9GgVFTCsqN4NMFudgvER1EBciES0UKNg5Oyi5bDEAyg/56E9p6gDiGwvW3RN7U
Received: from igel.home (ppp-46-244-165-151.dynamic.mnet-online.de [46.244.165.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  8 Dec 2020 21:22:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id C6DE12C32D8; Tue,  8 Dec 2020 21:22:46 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fixed kernel test robot warning
References: <1607455638-4436-1-git-send-email-jrdr.linux@gmail.com>
        <875z5ccc0h.fsf@igel.home>
        <CAFqt6zbp56nOfnLvuieMMtpEi7TXuB67bGS_Y=offyiROc=etg@mail.gmail.com>
X-Yow:  My DIGITAL WATCH has an automatic SNOOZE FEATURE!!
Date:   Tue, 08 Dec 2020 21:22:46 +0100
In-Reply-To: <CAFqt6zbp56nOfnLvuieMMtpEi7TXuB67bGS_Y=offyiROc=etg@mail.gmail.com>
        (Souptick Joarder's message of "Wed, 9 Dec 2020 01:28:44 +0530")
Message-ID: <871rg0cajt.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 09 2020, Souptick Joarder wrote:

> On Wed, Dec 9, 2020 at 1:21 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>> On Dez 09 2020, Souptick Joarder wrote:
>>
>> > Kernel test robot throws below warning -
>> >
>> >    arch/riscv/kernel/asm-offsets.c:14:6: warning: no previous prototype
>> > for 'asm_offsets' [-Wmissing-prototypes]
>> >       14 | void asm_offsets(void)
>> >          |      ^~~~~~~~~~~
>> >
>> > This patch should fixed it.
>>
>> Or rename it to main, like most other asm-offsets files.
>
> Few asm-offsets files named it as foo(). Does a rename to main() will
> work straight forward ?

Calling it main will suppress the warning, but other than that it is
completely irrelevant how you call it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
