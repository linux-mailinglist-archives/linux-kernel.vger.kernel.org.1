Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E451CCDF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 22:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgEJUdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 16:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729276AbgEJUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:33:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F1C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:33:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k7so1778442pjs.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t7/Qx+MoMVSELV0AwEX9yeriQs+i2bJ9OEtioZrc6/E=;
        b=a05xacJBi8M5GW4q4TaYKuU7WRBZ+y4zUna0AIr7BOmfBcmoGGv7TNuSPQ2yzi9shD
         GDbaPFQy72q0inH5FQh0qcOJ6EIkWGXh0BpPb0QPqvl95FLK4xev16FsjRl7Wpss84QI
         7braW8unmkg+QBOtT7zDZK9cTS/T4zRyuxsSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t7/Qx+MoMVSELV0AwEX9yeriQs+i2bJ9OEtioZrc6/E=;
        b=g8Lk8MaImsVT0PgIVBsWTrVQlEiYuIkVzbUAuYPzBMoH15VZBJJ37f4UBeAVrbdEST
         6jqDvkMEUP/RpFZSTVXxzK4pFUnzHf2gSDEqGdJZkiFfIxYEYBgNx0IbNcm+eoAl12+d
         3NzfQAJIBFutW0yntk9gx1XLYaPgOiEqL9fu/oZy1Rq6Xkx5HYs4S6i5EC1faA8rNxbL
         KrwLrFBHo7ghRw8W1nVNNGtPX9JDscVuyVzVidqu9bH7zWhjaqoVxzPcAncYJPzroun6
         Kjoo2qsC7RDkgd7yNDr+Nq0ZNHw6uS6lx0OUXCLHZI85LplCrkL3uY6AsWFBy6wwUil6
         NXMw==
X-Gm-Message-State: AGi0PubRuolgMbMGDk9fWtKr3AMKl5qqPdAVx0VOz9MbMSJBMVJxoUm+
        Z61Yv5OD9qZtYeQBffAn5hWU1Jd2J/Y=
X-Google-Smtp-Source: APiQypICqSkXYu8+cYaIGfpRaZvwlAIZIkt+jRKxFakvU4nAmX1NSsrvqM+OkqXqpwg3vUSAoA6t4w==
X-Received: by 2002:a17:902:b68f:: with SMTP id c15mr12283260pls.303.1589142817020;
        Sun, 10 May 2020 13:33:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7sm7380670pfb.48.2020.05.10.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 13:33:36 -0700 (PDT)
Date:   Sun, 10 May 2020 13:33:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/6] exec: Stop open coding mutex_lock_killable of
 cred_guard_mutex
Message-ID: <202005101331.F0ADFAD@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:18:06PM -0700, Linus Torvalds wrote:
> On Fri, May 8, 2020 at 11:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> >
> > Oleg modified the code that did
> > "mutex_lock_interruptible(&current->cred_guard_mutex)" to return
> > -ERESTARTNOINTR instead of -EINTR, so that userspace will never see a
> > failure to grab the mutex.
> >
> > Slightly earlier Liam R. Howlett defined mutex_lock_killable for
> > exactly the same situation but it does it a little more cleanly.
> 
> mutex_lock_interruptible() and mutex_lock_killable() are completely
> different operations, and the difference has absolutely nothing to do
> with  -ERESTARTNOINTR or -EINTR.
>
> [...]
> 
> And Kees, what the heck is that "Reviewed-by" for? Worthless review too.

Yeah, I messed that up; apologies. And I know exactly where my brain
misfired on this one. On a related note, I must stop doing code reviews
on Friday night. :)

-- 
Kees Cook
