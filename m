Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCDC292038
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 23:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgJRVkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 17:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 17:40:15 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDCBC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 14:40:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a7so11430403lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0jSfjnqiQQQfOeSaR7he4TbB5fwHxIKefRPBjlDOeo=;
        b=HzTK/HJpulOmR1nbJP7aPOsmd1U6PimlbXkkI4rDsQsWJNnndj28bNdmTKHVjwst1p
         TrMZvnXIL5NJHfqktSTc4DgoEHUKNVV2SpS+AXMbvdRVDtccF1mTSfMdqClqq5MV3PLa
         apFfL2KRjiezzvpmltnj+tTp5xBUaTjOPogt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0jSfjnqiQQQfOeSaR7he4TbB5fwHxIKefRPBjlDOeo=;
        b=b58wPEpBzIV8Ne1RwaLNdtj1+Uk8AZV31mR2udN3+SUksa8FlQ5fC/17NJGvvm3Dq8
         Ihuorxog5U7cQu2h/+J0kXaUlDowKXHTgguk0yItVVYuNmDjuLaHrQFCZgQaeUu7MNvb
         nBJlcr6VRwskFuU4xkOXerFxfjsU4JBoh7CqbD1Vh5WUBANCn7NRV4GFAacL35JxKTO9
         yoXGpcLKOGNXn7uDc0hFzkemNBj0I3jG6NZhGYXKiQD6pgnGtk4oOLDM0F+5f2wfcP1G
         GghL2LCLjXWsDxmL3gOZ/QMJE2YuhJNnTz9GhjPDpgwk+iL0r/FejtU0AigHzMPnYVtH
         I5MA==
X-Gm-Message-State: AOAM533i4UDrR8KeKFxgFcO8VXG+C+3ULdCMB/SYpiWG1QXTjA9C1/1w
        NjOC6gE7FS7MDAAIX8sWTlCv2OItg4lulw==
X-Google-Smtp-Source: ABdhPJw8soI4dtWpRtpKM21yYIpFKWsVgHdMJKmWSnGJ9CsegVwz0RT+IxFC4AZO7R1Yj2q7qVufig==
X-Received: by 2002:a19:414b:: with SMTP id o72mr5062543lfa.23.1603057213738;
        Sun, 18 Oct 2020 14:40:13 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x17sm2952123lfc.33.2020.10.18.14.40.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 14:40:12 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id l2so11497953lfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 14:40:12 -0700 (PDT)
X-Received: by 2002:a19:4b03:: with SMTP id y3mr4359919lfa.534.1603057212428;
 Sun, 18 Oct 2020 14:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201012141451.GA3425471@gmail.com>
In-Reply-To: <20201012141451.GA3425471@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Oct 2020 14:39:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE1rajA5Kzqey802zwv-82yrK5qc=nR3xRo5f38t-K8A@mail.gmail.com>
Message-ID: <CAHk-=whE1rajA5Kzqey802zwv-82yrK5qc=nR3xRo5f38t-K8A@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.10
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 7:14 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest core/rcu git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-10-12

I've pulled everything but that last merge and the PREEMPT_COUNT stuff
that came with it.

When Paul asked whether it was ok for RCU to use preempt_count() and I
answered in the affirmative, I didn't mean it in the sense of "RCU
wants to force it on everybody else too".

I'm pretty convinced that the proper fix is to simply make sure that
rcu_free() and friends aren't run under any raw spinlocks. So even if
the cost of preempt-count isn't that noticeable, there just isn't a
reason for RCU to say "screw everybody else, I want this" when there
are other alternatives.

            Linus
