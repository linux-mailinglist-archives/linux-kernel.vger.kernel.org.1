Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F85288512
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbgJIISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:18:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgJIISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:18:23 -0400
Date:   Fri, 9 Oct 2020 10:18:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602231502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVNpfS1pDgfKgE0j5KH7ugPaGZjN/OuepCzg8dpUzZc=;
        b=Vto18k3o+T1AK3MkhkvUp6ZaWqYqrY4dvS0Dm/jdK4NJucl5pmxkALFHbJZ5EsDBtU8Qv6
        2ozPQ+Yksp8njZZZjIHhibFsPwYipz/SSyv7WqIb8mk/rLu127YXQVCvkzlvXwMJl/zFwh
        v/PEBmtxmriww4dXgAF6xz1CU3nslog0+SS+IWq+mUfdT/65bXaMq1E8/nxXzNC9HY3ItK
        AkGhV7KXS1GP4HY+TtwLY6cMdovOkmd7YDYzz3hbYFm//5oFKrkR6gfbE8aSrJ2XTnUnoX
        0wsbxR8w6KWbtlKmBoi2sdhZI7Cb4OomMpWEEWeamJdJG5cJ5n0bYacs+XxPkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602231502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uVNpfS1pDgfKgE0j5KH7ugPaGZjN/OuepCzg8dpUzZc=;
        b=EHfR7LVYDl1o236GGxjGuDikI4trDrSWwK9eR82JU4M4H4oCCBQRR+zhrp7yWRLsWduKap
        AqLqjqxWJMMjwZCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, dima@arista.com,
        will@kernel.org, jpoimboe@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, viro@zeniv.linux.org.uk,
        ldufour@linux.ibm.com, amanieu@gmail.com, walken@google.com,
        ben.dooks@codethink.co.uk, tglx@linutronix.de, mingo@kernel.org,
        vincent.whitchurch@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wangle6@huawei.com,
        luohaizheng@huawei.com
Subject: Re: [PATCH] arm:traps: Don't print stack or raw PC/LR values in
 backtraces
Message-ID: <20201009081820.jargnmck6zfkzegx@linutronix.de>
References: <20201009075957.110017-1-nixiaoming@huawei.com>
 <20201009080849.GM1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201009080849.GM1551@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-09 09:08:50 [+0100], Russell King - ARM Linux admin wrote:
> I am really not happy about this - it hurts at least my ability to
> debug the kernel when people post oopses to the mailing list. If
> people wish to make the kernel harder to debug, and are prepared
> to be told "your kernel is undebuggable" then this patch is fine.

I haven't look at the patch but don't they keep/add the representation:
  PC: symbol+offset/size
  LR: symbol+offset/size

? This is needed at very least as a replacement for the missing address.

Sebastian
