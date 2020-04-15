Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88E1AAD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410281AbgDOQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415445AbgDOQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:14:56 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A26C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:14:55 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i22so403019otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YY754z9PeJMmvslMfaTQ60iPR2h8d8EcgLpNFKs6TXQ=;
        b=ensIBQhTLfMUhI/AckVjVSeNIMurfIMWlyjQNC/y5Q1n7X+sGHs4D9Oj738io+6WKn
         q2Qz6jdWHlsLR8zgo9vbuOru8r2nwbOuQpjauUXlDEyrjyx+/Oru+42U19TfNVW1bm4Q
         V4m66v0rPlaBKNn4G/i9kCLpyUoayUjPU8Pn0Y9xY3vS6jSERLN8RInC04HBbf5rK3kp
         0mBGR8KABY3swFRi3z9R2jpb0OPQAF6Z5UmZlfGAU0byMnbraf/GjP1Ovebc9H0MGrCG
         BY54TPpG+RrUpYd/cqywxRmA5oCwGKtcaBoGxFvBw5G9hnLrVxJCRNuCj6vAAlkRJHtv
         3kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YY754z9PeJMmvslMfaTQ60iPR2h8d8EcgLpNFKs6TXQ=;
        b=DfK45xNFCefE+6MRXpC4ZFQaU8FVJgljM/gMqf3C5DaY5/G1VFnde5FRjjBkVQ7ieP
         7sveVTfhaFn8rxkwsgen8pwhCdIKdsNkI4NcwRj9j7mjqKghGDSjlvqSAeOgMylFcIp7
         m9htQBtmnX5hjITuSmhQ6uhzcT3nqfveF/rXXletGwgXIR2YYI6998dnhwXc2Z+lzLMk
         hWrN+rDpEaunyCJ7guNQoSz5s+JkyLQ+yo4hcahiX6pDgaxZu6wtNb12uYMHn+fph1bG
         zbaHnUMkNsEUXYQotzqx4YcgfhL8CWk/ckJ3MWLjFHQOXr8U3yOVBHwjqRU9euzLdFxj
         uxeQ==
X-Gm-Message-State: AGi0PuZjrGNnpJu0D0pDl1JfqradFGuUD3djDSZudJwSwF0eS+FF9NrP
        DaCxZxgve+0j3r2A9IRwbkW6YQoTFFq/ig9Di/UAh9AAzGo=
X-Google-Smtp-Source: APiQypKmOr4pyj5woZliOKqqj9jDH9F/Bq9sHVlUWf6TaSVf+a6bzHks4NlheUCnPxbK/0asJqZNCnLSyAr1bvDFDto=
X-Received: by 2002:a9d:629a:: with SMTP id x26mr21214050otk.201.1586967295087;
 Wed, 15 Apr 2020 09:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200225073731.465270-1-avagin@gmail.com> <1c1ab662-5475-9d8b-038b-8411b060202a@arm.com>
 <CANaxB-xUYOrVnfLPRYVBiASzCH89sZkD6vTdy8EFjT16ZJhLfg@mail.gmail.com> <1d9c4c56-af16-e54f-08ca-76c6570b2d53@arm.com>
In-Reply-To: <1d9c4c56-af16-e54f-08ca-76c6570b2d53@arm.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 15 Apr 2020 09:14:43 -0700
Message-ID: <CANaxB-w+_4BUOYb-5+w1xBPoZGOzBh-LYOFCY-WSysgbAAcn_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] arm64: add the time namespace support
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 2:02 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Andrei,
>
> On 4/11/20 8:33 AM, Andrei Vagin wrote:
> > On Thu, Apr 9, 2020 at 6:23 AM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> I have though a question on something I encountered during the testing of the
> >> patches: I noticed that all the tests related to CLOCK_BOOTTIME_ALARM fail on
> >> arm64 (please find the results below the scissors). Is this expected?
> >
> > static int alarm_clock_get_timespec(clockid_t which_clock, struct
> > timespec64 *tp)
> > {
> >         struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
> >
> >         if (!alarmtimer_get_rtcdev())
> >                 return -EINVAL;
> >
> > It is probably that you get EINVAL from here ^^^. I will send a
> > separate patch to handle this case in tests properly.
> >
>
> This makes sense :) Please let me know when you post the fix so I can test it again.

I have sent this fix: https://lkml.org/lkml/2020/4/15/72

>
> Are you planning as well to rebase this set?

What is the right tree to rebase on?

Thanks,
Andrei
