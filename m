Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CF91E9276
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgE3QJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3QJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:09:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8215FC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:09:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k22so2465176pls.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=252ke6cdhBvZkDN0y0wJTXtUprLVIQrGLeOXw+zQ7uw=;
        b=MNkjPFQloO7aCLrPQprxVs/raW+LBnQ/2HTjSLzEY5kkFiwHDEQXJT3R8eicGvfR8c
         wQldew+m5xw/O/x9BxHz/NxS6hjrCn9KZWQo5jz9NR5bdqTUcdbQ7P+G7ZO5Nr1QyuHN
         jisROnKeO5jgHpKmBR50AhGRUTryP2GJYQ/6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=252ke6cdhBvZkDN0y0wJTXtUprLVIQrGLeOXw+zQ7uw=;
        b=MW9WjpKfuc6561kLvaGWCR72BTfYO+u2hXscJTMOhU7x04/XXnJ4uCwC61E5HN/gGF
         o9IYa+B5jLDEN3t78CDya4jJJjsqEkcB76SJAYkA81oe++MSO9MhPo7uJtU+qIKwxYr5
         MAb9lp6ONI+3rBGEun7uzHRpCqNsKaFKfw3emu0aRNxRW37x/O9NKsFavevcxtE3CHiQ
         Y0q6urU86fDCDLxPLJ4nGka3wisY9PF5FKECwG5ZyLupV6zCPou7SLvTtWGQKuVxnnSx
         Me4X1dAKvpxoON+9HnG0QDyINB4dvQBII9f8WUDzQ6Zn/vmAU/BcWosjs+eqsrg/WSMn
         L6/g==
X-Gm-Message-State: AOAM531mXFvT7f5IgTq1loIcTCCL8o0GE088dqpMbvqpZAT0aoJo7FIu
        RLA/9hBud9U5oFBHkVDwfc+lxA==
X-Google-Smtp-Source: ABdhPJxyXNiqub5XgSRuVucIGQS0F4umnhMeX/svhi5z2B5N2t8ed+ZzymZL6UPdJnyeZxbNfcaMfA==
X-Received: by 2002:a17:902:b682:: with SMTP id c2mr13384155pls.313.1590854971980;
        Sat, 30 May 2020 09:09:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z18sm9391330pgi.68.2020.05.30.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 09:09:30 -0700 (PDT)
Date:   Sat, 30 May 2020 09:09:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jann Horn <jannh@google.com>, Sargun Dhillon <sargun@sargun.me>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005300908.303040EF9@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <CAG48ez0+BvbLoSc+zcZwnwfOSCFt2LHnUkzzt-d4LQFJYXZC9w@mail.gmail.com>
 <20200530135827.cxltfmiqara4yaki@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530135827.cxltfmiqara4yaki@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 03:58:27PM +0200, Christian Brauner wrote:
> On Sat, May 30, 2020 at 05:17:24AM +0200, Jann Horn wrote:
> > On Sat, May 30, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> > > I mean, yes, that's certainly better, but it just seems a shame that
> > > everyone has to do the get_unused/put_unused dance just because of how
> > > SCM_RIGHTS does this weird put_user() in the middle.
> > >
> > > Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> > > move the put_user() after instead?
> > 
> > Honestly, I think trying to remove file descriptors and such after
> > -EFAULT is a waste of time. If userspace runs into -EFAULT, userspace
> [...]
> 
> There's really no point in trying to save a broken scm message imho.

Right -- my concern is about stuffing a fd into a process without it
knowing (this is likely an overly paranoid concern, given that if the
process is getting EFAULT at the end of a list of fds, all the prior
ones will be installed too..)

-- 
Kees Cook
