Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F802E23D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgLXCz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgLXCzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:55:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE93C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:54:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t22so531140pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=6CruMwj3es7dN6q83DfEO/iKaOGfekskSHiLh5zWSNc=;
        b=GAeVIaMZiPs8NRaZ3wq491yVrDkq3ECS5AMBUZ365/RMef6sA+O73T4MQ2eCWsvAYh
         huLXuanMXOYUu6uesUcP2PRQQHs72NtJKGFswpeStxs4zfudYQqLlZt/6LmrQm0RKtVU
         2buLGf1k7x99bgDxkB5NJ5p90RjgbGtNbDiYp+QBitZLSmN+RLplzEgnQkB4ds2zdxUd
         OgjuZPHPHfgUuyFbCj5FZPrSEtejucShCNZHSYuhhfus38Npq94XMrQu8ytETXo/s2/D
         euKBc0HFYswXYUOj0SnubTXRtq5OLDsJJ61Gdkl5omkOv0/6bg8qtr165cs5ZmKmnWLv
         /MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=6CruMwj3es7dN6q83DfEO/iKaOGfekskSHiLh5zWSNc=;
        b=fr0obCx0EJGYgtOePHnH2c1cEgu/Ut0w9ktcv5xiEF4/ukDVRmboO3nMF3K66MWzCL
         z1W8Twbh2A4Af9uaSNU2GWdSw8E9h8NimlBNOgbk+a67n9XeowYyqMQvNWgZXRxFvkFl
         +rGQjZ9APCIWuUqzbtxhC1qyZK6tL18OeAYILsHaOWF0eGSmqJ4Oc++qBV3iMjNc4z5S
         G7eC++KKv3Zb85h1RcgvXIOj4RIcTT+XNRGIwp4nlhctxsnKtSBZKovbZ+zEKY1R69n/
         LL73hpddCyITLpOeO1IkSxFT+IJkL7T2H12XYOmuobIswIrmK9GYsLa/O8ap0NEddGwy
         RSbg==
X-Gm-Message-State: AOAM530PjGFR2qZLOHwC05bL5yNOTwLasPjK09/TrWsuakBVAWiVrI6p
        dUHy2XbWh2ff7joDN9HYYbWgag==
X-Google-Smtp-Source: ABdhPJx0Yr6reyiHyhZsaOkM7rzq2fgP9/YI4GoIKOHadjhSWZphN/IEG7hIgDtbYiQrLfBEBhSHxw==
X-Received: by 2002:a63:720c:: with SMTP id n12mr25325416pgc.97.1608778484909;
        Wed, 23 Dec 2020 18:54:44 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u11sm857259pjy.17.2020.12.23.18.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 18:54:43 -0800 (PST)
Date:   Wed, 23 Dec 2020 18:54:43 -0800 (PST)
X-Google-Original-Date: Wed, 23 Dec 2020 18:54:42 PST (-0800)
Subject:     Re: [PATCH] riscv: return -ENOSYS for syscall -1
In-Reply-To: <20201223082404.GB24581@infradead.org>
CC:     tycho@tycho.pizza, schwab@suse.de, david.abdurachmanov@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-c15e4fab-6487-4875-a392-85669982b8b1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 00:24:04 PST (-0800), Christoph Hellwig wrote:
> On Tue, Dec 22, 2020 at 09:22:19AM -0700, Tycho Andersen wrote:
>> On Mon, Dec 21, 2020 at 11:52:00PM +0100, Andreas Schwab wrote:
>> > Properly return -ENOSYS for syscall -1 instead of leaving the return value
>> > uninitialized.  This fixes the strace teststuite.
>> >
>> > Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")
>> > Signed-off-by: Andreas Schwab <schwab@suse.de>
>> > ---
>> >  arch/riscv/kernel/entry.S | 9 +--------
>> >  1 file changed, 1 insertion(+), 8 deletions(-)
>> >
>> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> > index 524d918f3601..d07763001eb0 100644
>> > --- a/arch/riscv/kernel/entry.S
>> > +++ b/arch/riscv/kernel/entry.S
>> > @@ -186,14 +186,7 @@ check_syscall_nr:
>> >  	 * Syscall number held in a7.
>> >  	 * If syscall number is above allowed value, redirect to ni_syscall.
>> >  	 */
>> > -	bge a7, t0, 1f
>> > -	/*
>> > -	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
>> > -	 * If yes, we pretend it was executed.
>> > -	 */
>> > -	li t1, -1
>> > -	beq a7, t1, ret_from_syscall_rejected
>> > -	blt a7, t1, 1f
>> > +	bgeu a7, t0, 1f
>>
>> IIUC, this is all dead code anyway for the path where seccomp actually
>> rejects the syscall, since it should do the rejection directly in
>> handle_syscall_trace_enter(), which is called above this hunk. So it
>> seems good to me.
>
> That change really needs to be documented in the commit log, or even
> better split into a separate patch (still documented of course!).

Unless I'm missing something, this is already how it works already?
handle_syscall_trace_enter is checking the result of do_syscall_trace_enter(),
which checks secure_computing().  When secure_computing() rejects the syscall
we already ended up rejecting the syscall, so this code wasn't doing anything
for the case it was supposed to handle.

It was, however, intercepting syscall number -1 when we weren't rejecting the
syscall and directly exiting rather than calling sys_ni_syscall.  That would,
at a bare minimum, result in an uninitialized return value.  It also breaks the
pairing of trace_sys_enter() and trace_sys_exit(), which doesn't smell like a
good idea.
