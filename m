Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CBF2D9E82
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407936AbgLNSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408303AbgLNSGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:06:10 -0500
X-Gm-Message-State: AOAM532+Iuh/M+D67djNp4+s99wECyST1lxCtY1IhZw1EaHVI0+/JaQ2
        E916sJ+XWppP73o2amjy/gamj4BfbNY7MGZzr/97Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607969130;
        bh=rAaVfHwnElycFCW/txpY82sI5mEz7/7D/XkiCH7nAxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U0cd+4uDEePQwse8+8APKunOZ/tDjqSWFYL+2PPRj9Kdu/7qaDci0Z5hTrSAFczzF
         rKrIWQOTrnXogWqQS5gocuQzmniHnxiTBtlfFwJM5Wkv94wTKimg00ePrtA4lz2aIb
         TO5h4nrV6Gk6dCuT9oqOvFKqcHHxxfdL5xMpRhX7rhqeYjkwa4cI4l8ndM0nyIJrZ6
         mOjrIj+qCL0hOkyuGyxjSj4d3tGeBh6VqU4hOBvidENFwCXeQJq6ORNHu68L8WPLIZ
         g7r9tt7boM6N+HEasPe2Y73qPoXemNkPbjrgHU/NCRMPPuEP/y+hWgGTZZzv74TaPJ
         hONUnblH/cGCg==
X-Google-Smtp-Source: ABdhPJxfn6S4mVr9Zd7vPIFH7/vXr1SlgoPxayWAiaO86zkxmLkcozP3AR/ZAC/1h72TbkN0IM+oRpphJTrim2gok5o=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr14778136wrq.75.1607969128267;
 Mon, 14 Dec 2020 10:05:28 -0800 (PST)
MIME-Version: 1.0
References: <d3e7197e034fa4852afcf370ca49c30496e58e40.1607058304.git.luto@kernel.org>
 <160750336770.3364.7388742360472960633.tip-bot2@tip-bot2>
In-Reply-To: <160750336770.3364.7388742360472960633.tip-bot2@tip-bot2>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 14 Dec 2020 10:05:18 -0800
X-Gmail-Original-Message-ID: <CALCETrW4KAbvAE45T4N0CMdR7XQyrRQTEAq5fX=xVpGAEb3KwA@mail.gmail.com>
Message-ID: <CALCETrW4KAbvAE45T4N0CMdR7XQyrRQTEAq5fX=xVpGAEb3KwA@mail.gmail.com>
Subject: Re: [tip: x86/urgent] membarrier: Add an actual barrier before rseq_preempt()
To:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        stable <stable@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:42 AM tip-bot2 for Andy Lutomirski
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/urgent branch of tip:
>
> Commit-ID:     2ecedd7569080fd05c1a457e8af2165afecfa29f
> Gitweb:        https://git.kernel.org/tip/2ecedd7569080fd05c1a457e8af2165afecfa29f
> Author:        Andy Lutomirski <luto@kernel.org>
> AuthorDate:    Thu, 03 Dec 2020 21:07:04 -08:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 09 Dec 2020 09:37:43 +01:00
>
> membarrier: Add an actual barrier before rseq_preempt()
>
> It seems that most RSEQ membarrier users will expect any stores done before
> the membarrier() syscall to be visible to the target task(s).  While this
> is extremely likely to be true in practice, nothing actually guarantees it
> by a strict reading of the x86 manuals.  Rather than providing this
> guarantee by accident and potentially causing a problem down the road, just
> add an explicit barrier.
>
> Fixes: 70216e18e519 ("membarrier: Provide core serializing command, *_SYNC_CORE")

Whoops, this got mangled on its way to tip.  This should be:

Fixes: 2a36ab717e8f ("rseq/membarrier: Add
MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ")

and this patch does not need to be backported.
