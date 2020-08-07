Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6939023F2C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 20:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHGSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgHGSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 14:31:29 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB1FC061A27
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 11:31:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x1so2564287ilp.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ow/n+p5v9AzYTA+9JReZiErGOMiITrcf1jfAhTavps8=;
        b=d/TLBHsbUxJim9gdd6Ilv6C2+IoLB5KGJSQKC8Y7rBSGC//gc3mJa8d+nyjASUx6Ld
         /Sap8yf2yTNMWrWQguBMFeBDe457yQgWGC1T1RXw2xz8rd6dATNB/I6tYOvkkueY3fQB
         ut599aJHWiP0JG0noR7f1MkiPe0AeqXyYCwUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ow/n+p5v9AzYTA+9JReZiErGOMiITrcf1jfAhTavps8=;
        b=iScJFy+X5ftASwHWEy3q1+DNUHG8tnDpOFDRNHJ/X99h1aTYj4N0+fZOvjclCBuzqh
         m6NZ0LM//eHmb257cmiCqohpm5ZdUxkBhE2AAn8XzSAmN+LyPpVjq5OQ7TmSw5HPu6zV
         BGX1baAspDGt1gELMar2MQOekUgjRh7YqjRR9i50WeakdxAF8AALMR0k1ZS6W6Qz6ACB
         bORU5qHEIBN2TV1FzuBrHa6JRF0gZ6ojd7PVOX2AH02IdavjbNduikbbPGsRwyhqhMVU
         q3DMGQxijmN7MsVq992W3b58oXH1ys/8SrgVVSSTiOT9v+u0isrrN8vzfRDktM2Icvba
         rRWQ==
X-Gm-Message-State: AOAM530X/OLzJEslHRFeQLC7YNpbPwdAWIfhtvBu9VtKLZ8vauA6VRGr
        LEknxQbvTs0913mgSA1bw75YG8jMyyw8CgH/dRs+AluiVdg=
X-Google-Smtp-Source: ABdhPJy8Y0pVCBFunfYxLQ12k7YK8BWag29BNhppx9OX5t9Bt5CkoRs73Za0PwiTyL4uNOvTk/9RI6PwxpJZBtDtM9Q=
X-Received: by 2002:a92:cb06:: with SMTP id s6mr5997240ilo.13.1596825087854;
 Fri, 07 Aug 2020 11:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200807170722.2897328-1-joel@joelfernandes.org>
In-Reply-To: <20200807170722.2897328-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 7 Aug 2020 14:31:16 -0400
Message-ID: <CAEXW_YSCjELpkFUoX=kNvrkPvU-mDwv50Bbu=MZmbKa8=+BbYw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] option-subject: RCU and CPU hotplug checks and docs
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Vineeth Pillai <vineethrp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 1:07 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
>
> This series improves/adds to RCU's warnings about CPU hotplug and adds
> documentation and testing.
>
> v3->v4: Minor cleanups.
>
> Joel Fernandes (Google) (5):
> rcu/tree: Add a warning if CPU being onlined did not report QS already
> rcu/tree: Clarify comments about FQS loop reporting quiescent states
> rcu/tree: Make FQS complaining about offline CPU more aggressive
> rcutorture: Force synchronizing of RCU flavor from hotplug notifier
> docs: Update RCU's hotplug requirements with a bit about design

Apologies that the cover-letter subject has the weird 'option-subject'
in it.  Likely my git-send script misunderstood one of my markers.

thanks,

 - Joel
