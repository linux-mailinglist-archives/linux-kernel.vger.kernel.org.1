Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4786929E0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgJ1WAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgJ1WAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:00:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D187C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:00:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t22so291179plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3JieeaKV82uBzVj5aRl8IywWoZYnp9JS5mMh/75gXqM=;
        b=NmEmglnKx6HJo9sWaosHifGEl7RCpwWehcJXW808Kc+hXV4a8E9Vw43iFLsAF49WDx
         Msyh6w4Bd2EMii4HDVhAhqbLNwd0uhh1eVPEBDokDHUEZHV0uXYY1o+EXThpLKfOq9Nd
         KUIea1k2bYzI0krz9qvF01queeWI6rSfR3RQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3JieeaKV82uBzVj5aRl8IywWoZYnp9JS5mMh/75gXqM=;
        b=ZPWDAcnlXusXTzeOez0lR7kqZMbuhSnVnZ+LbRj9zQnZFxZV9Y8khI/FJJFen8xLaw
         Bj31LcMZRaHIUVgTHNVxbX27ItVQ2+06H/i9rTTs7c6jUwKvu+kvqgA581R9NdjMvELr
         e43TAmoH5ZWbfdx6u2xUKMV+Z3nma0Bo6FZpwTCPoCioNfueEOAASNEe9G0XenWFt5zX
         4HIgfqH1tjhpoDZILpB+uVNhs87nk4CL/Qi4rVg3sjQjMUXpXWey4+Gxvgrr88MSA+j6
         6OCqVpelOK/9qZ0husTEhGG+tGDZuf6tgV527qrN1U7PvmNatAyD5TgudNX7ckkg8kMk
         ubSQ==
X-Gm-Message-State: AOAM532D2+7jpiwnToB/KUxpdMWo2UuAKe75YKxhf1OIVFjG3M1DkLvc
        qOT8DdstO5TfL9rQOgxINSxLdA==
X-Google-Smtp-Source: ABdhPJxqkk4DlhkCifC09cfsKnyxs3iZSoM2ZinUMhWFN8LbNMyJyW/8sk3i2Z3Zr8vUXkUjGZGt6g==
X-Received: by 2002:a17:902:a70a:b029:d3:b4d2:32c3 with SMTP id w10-20020a170902a70ab02900d3b4d232c3mr1257100plq.66.1603922446008;
        Wed, 28 Oct 2020 15:00:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t14sm177575pjy.46.2020.10.28.15.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:00:45 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:00:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Camille Mougey <commial@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Rich Felker <dalias@libc.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [seccomp] Request for a "enable on execve" mode for Seccomp
 filters
Message-ID: <202010281457.42139F3FC@keescook>
References: <CAAnLoWnS74dK9Wq4EQ-uzQ0qCRfSK-dLqh+HCais-5qwDjrVzg@mail.gmail.com>
 <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3ZXmJ1ndEmZtoieOAm05p+5X7+HXo61LwpuiWFWGWK4w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:42:13PM +0100, Jann Horn wrote:
> +luto just in case he has opinions on this
> 
> On Wed, Oct 28, 2020 at 12:18 PM Camille Mougey <commial@gmail.com> wrote:
> > From my understanding, there is no way to delay the activation of
> > seccomp filters, for instance "until an _execve_ call".
> > [...]
> > It would also ensure there is only one thread running
> > at the filter enabling time.
> 
> You're alluding to cases where library constructor functions launch
> threads? Is that a thing anyone does? (And in case someone does it, we
> still have TSYNC, so I don't think this would be a real problem.)

Unfortunately, yes, it happens. TSYNC got designed specifically to
"recapture" these constructor-launched threads. :( It was a common enough
situation Chrome wanted to solve due to some weird GPU libraries that
did this during init before Chrome was running.

-- 
Kees Cook
