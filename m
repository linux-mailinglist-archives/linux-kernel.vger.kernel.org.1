Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFEB2452DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgHOV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgHOVwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B5FC061363
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:34:06 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m15so5754586lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qv3qmfuM3ON3dTRR9DJ/SW9QfEaLnmKIX6GHHlE8Ljg=;
        b=HMXEuIIUsx9XgiA0p9Nl4Mb/yft6xail9kTFSwgsTDZgS3IrGkRKl307Q+vB4t7MEL
         ymg2OU+CfzNAxV/xS1WJ7U0fVxN9MN4ScyCpWZhXejsoAxugr9Pt/URbmafCy6qw6cgG
         sjLdtC+S9bZeT7peOnhGNNfF0zG+zP1z6RlG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv3qmfuM3ON3dTRR9DJ/SW9QfEaLnmKIX6GHHlE8Ljg=;
        b=qrE4T5d5w5z75O16JZ8iGxRAaxhDNwGzbv2lzeGN76SU3J4gnz1WqL5MIqbtcmDGNF
         1AiaxM32EE1gwKGgwX7A+xiLfn+aV5lxuoU+ifKZDinrYR7ul3APWfroGI+WpOLj+BJn
         GKGHdOuzb+HjOaEAmqsWkRslVIa/KwJ2xDBsZHjamwoKGiPSkyjycLuAwHeyoOPrZFg7
         FXmD623RLPYafvIkh86mzNF1rdVkuzcHCO17hViK5qCujM4wmbGom+lG1d0fhszlNrqI
         CBl5ySL3H3fGqVCewist0T7etLXgQcGafWtSs9iM9P8AwQAPrDUrNDSDHHtzq2OBTjfP
         DdSg==
X-Gm-Message-State: AOAM530PJBIP2WbP6ytXKTPPVZYRqhlXtcSMg7ZnHByaRV6qAjsy691+
        dpg04i6v92iVi1rqiaDPQMKQERYYYTBLuw==
X-Google-Smtp-Source: ABdhPJzMdbf5LCXevAEwb+AuSJt17q60Te6RIf7FhU65hsPcf1pH4/oi8QgTEU4MjPxkxp421F4YiA==
X-Received: by 2002:a19:3d4:: with SMTP id 203mr2486100lfd.183.1597458844746;
        Fri, 14 Aug 2020 19:34:04 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id t27sm2087585ljd.101.2020.08.14.19.34.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 19:34:03 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w25so11837234ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 19:34:03 -0700 (PDT)
X-Received: by 2002:a2e:92d0:: with SMTP id k16mr2338800ljh.70.1597458842826;
 Fri, 14 Aug 2020 19:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain> <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley> <20200813115435.GB483@jagdpanzerIV.localdomain>
 <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com> <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
In-Reply-To: <b87a02b75c715d9a9f381fe3869612bb826a7351.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 19:33:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
Message-ID: <CAHk-=wjNZ40akqgnb1y=dSYv1fX2Wk1SGF5hAzuV2azi5oQ+Tg@mail.gmail.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 4:52 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-08-14 at 15:46 -0700, Linus Torvalds wrote:
> >
> > This is why I think any discussion that says "people should buffer
> > their lines themselves and we should get rid if pr_cont()" is
> > fundamentally broken.
> >
> > Don't go down that hole. I won't take it. It's wrong.
>
> I don't think it's wrong per se.

It's *absolutely* and 100% wrong.

Yes, any random *user* of pr_cont() can decide to buffer on it's own.

But when the discussion is about printk() - the implementation, not
the users - then it's complete and utter BS to talk about trying to
get rid of pr_cont().

See the difference?

                Linus
