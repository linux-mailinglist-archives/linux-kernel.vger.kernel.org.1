Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C37121FD1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 21:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgGNTSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 15:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgGNTSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:18:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64622C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:18:02 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e64so18516576iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+ls3I/N5zsUDO1aedELyDp7Kj09Qsqb8dgbqg/A980=;
        b=IzZThgcPgwciiCyVEcQUJ/jfFCpEk/2MHNYLhGkXYrsI6T2S8YEvqn5hytvliX0W+a
         U7XZBozq1quYR/PnHj+En8JweGapYod2EjFhYop3iQeptqiKwVZaNeAE8n7jGZHJcvi3
         i3JGBvvQYa93bVF4ZKKbvhP+oEPqsJPa/kDdn718wyLjxL5hwY8Cyc/ANYx83mLLq3Kt
         hahpKBGipauXvaLE91+i7Sfd6BSBkQbSqBonxcodbI5jBjAVj7m7zoOG8fvSd2fBd2Ig
         nVvOebWetUGEnnommtlkzG0peh1QODDmBQszhuzATE44PAl30vckla5GrFIcRciKPwUz
         Yb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+ls3I/N5zsUDO1aedELyDp7Kj09Qsqb8dgbqg/A980=;
        b=bbJLMeZYe0UG2GkjyspiZ1YwDTHpTWxU1wSwfhw28LHCTN5mrNcFRGosOAF2j1DuOH
         tipOkaFvkX5gSgy/eIWE2E64dJ9+z7oKroj+7WmGfAsbssBF/InCJAA/fniy3oQVPvsr
         eqlTsCJ3lklvWGCrhd9ZrqpNkpv60Fn+Z6W+dOkH+aeHAtxUP+iuT9Wa96mTMsRJiWZo
         GZKfB1on49F8iKPqYc1t7C9ytZfKJBfuPIJ7LXtMKbOYWOPaFiuPvGGGjzdeY12RfBDh
         C85bsgfO1vUHeeEeHs4Ak9TVd9Vni+xq/Q1lzg5Dhr7BtjUP6rtW8ymPi6sJcpfm+e+y
         3/vw==
X-Gm-Message-State: AOAM530h19DKfeC1Bp5O4xasGYYID2zx+JBqB3cYA57hbr9rYVjk4YDx
        KP0bCOe26q3iBtOwBY16GJTI11Mt3f/G16rJzbglqQ==
X-Google-Smtp-Source: ABdhPJzbujNqtoQoRYwDGoiM7cW9ZxY92ueoJ7abo6SGFJr01p4gHzSMuSZlOFme+LCpUveW0ZKh0vQSSFndz7J0gTc=
X-Received: by 2002:a6b:6508:: with SMTP id z8mr6459683iob.82.1594754281290;
 Tue, 14 Jul 2020 12:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200615063837.GA14668@zn.tnic> <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic> <20200714160448.GC2080@chrisdown.name>
In-Reply-To: <20200714160448.GC2080@chrisdown.name>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 14 Jul 2020 12:17:50 -0700
Message-ID: <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
To:     Chris Down <chris@chrisdown.name>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 9:04 AM Chris Down <chris@chrisdown.name> wrote:
> Either way, again, this isn't really the point. :-) The point is that there
> _are_ currently widespread cases involving poking MSRs from userspace, however
> sacrilegious or ugly (which I agree with!), and while people should be told
> about that, it's excessive to have the potential to take up 80% of kmsg in the
> default configuration. It doesn't take thousands of messages to get the message
> across, that's what a custom printk ratelimit is for.

Agreed - we should now offer all the necessary interfaces to avoid
userspace having to hit MSRs directly for thermal management, but that
wasn't always the case, and as a result there's tooling that still
behaves this way.
