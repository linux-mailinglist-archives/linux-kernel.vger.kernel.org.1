Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C4269605
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINUHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINUHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:07:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD86C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:07:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v196so538080pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZ4bLQT3z6JaXubPXGB1pmNC9qXVT9dzt/Q3tQB/tJE=;
        b=Ynq1XjQqQyqDzGcbEpWuR+tn8iotDeNo64ENelIwB9piSHm41iSt9i3f39rH5D+om1
         keERJULeng1WXMMYCXPhEtW5SyxHlU8TiH52fpFeD8Pp6fdsI9afZXxlrtE30Z/5Q/tj
         Hc82oW6G31/pwJgEC8nt/ainOoG/8YaoIIiRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZ4bLQT3z6JaXubPXGB1pmNC9qXVT9dzt/Q3tQB/tJE=;
        b=YDFw9Tnr9kBV+Un3wHWJgThn4/2eqsmmS+hSQh2VsOuPwc8BD/djXGomTz6dcI0717
         2Sdp0IcNqPq4vWq0EreUYs3LN85d+FjwvcgpZGbWhUF7OMI5Au8/2T8hbtyd28A3w42c
         tHJS2duqitV5XS/F61n7UT9OOul+1BO2Jrjm5vyyUJYJZ8GPYBhNsDM7gIPhbDs+sSuJ
         2q0SUrtZMXM1OXi0YfBvLAT4syIlmaKxOEXVZWPjUC6/A/FQENJj9Fpl5n29QGsn9kSM
         SreEDAJor2rwSsVzIw3exh0fgeJsut7kQxbv3CzwtXkWljiiNvfkMMXAaOv8tqCAJucD
         gH1w==
X-Gm-Message-State: AOAM5309TQVVaTTt3fQw766abRX7xnGTO0XmhNls6rQBgqDb0OyWAyzf
        jk1iiuWfcTaAB0U4CiCkOm3hJnWeIjJX0Od0
X-Google-Smtp-Source: ABdhPJzaUD4byUjS+FfCzp5HP+hvFNCdMQPnI06A7ZsWWF5rIFk/LVI1jTpSrEU7+maEGPMn3CZRLg==
X-Received: by 2002:a62:5f02:0:b029:13c:1611:6536 with SMTP id t2-20020a625f020000b029013c16116536mr14113247pfb.8.1600114021316;
        Mon, 14 Sep 2020 13:07:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c22sm9060914pgb.52.2020.09.14.13.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:07:00 -0700 (PDT)
Date:   Mon, 14 Sep 2020 13:06:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in syscall_exit_to_user_mode
Message-ID: <202009141304.811BAC4A0@keescook>
References: <00000000000018a47605af074c7d@google.com>
 <202009121050.0D9CAB95@keescook>
 <87sgblpi4l.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgblpi4l.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 09:54:34PM +0200, Thomas Gleixner wrote:
> On Sat, Sep 12 2020 at 10:52, Kees Cook wrote:
> >> ------------[ cut here ]------------
> >> syscall 56 left IRQs disabled
> >
> > This WARN appears reachable. :)
> 
> The above is hardly a problem of the new entry code. It's just detecting
> the wreckage...

Oh, well that's actually even better! :)

> > I also see on the dashboard these other problems with the new entry
> > code:
> 
> > https://syzkaller.appspot.com/bug?extid=d4336c84ed0099fdbe47
>
> This one is also just the messenger. That's the
> 
>      lockdep_assert_irqs_disabled();
> 
> in irqentry_exit() if I'm reading the reports correctly. That's a #PF
> returning with interrupts enabled for whatever weird reason. Let me
> stare at that...

Cool; thanks.

> > https://syzkaller.appspot.com/bug?extid=c4af95386364bc59b13e
> 
> This one is not a new entry code problem either:
> [...]
> The new entry code is just in the stack trace because that task was
> preempted after a timer interrupt.

This seems a bit like the first issue: it's just getting noticed now?

-- 
Kees Cook
