Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8FB2BAF45
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgKTPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgKTPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:46:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E4C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:46:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so14063651lfj.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yps1e5KzrIWuWLTz7SlzGPsEJ9zx8qv8vtiS4Y+fzRs=;
        b=rCTDRbJfZOnUWWo5y33U/5YZehyzFwE68YkK2VrRXJBFoHAjkpD+g/l4cHSC7NeZZ+
         0YdW7KZNJiLLSMjnhI/QJa+HnUTyqF4HibOUOLQpcAj9pY4vYWR5nKmFdyqx7U2ZiFbr
         +zpxSQ68zHlODo2Nqu/+4QkqHkHRvflqrzcniIdhcfbfrTtBZOaQttJu36xcRZxKnEK0
         o8CZtUmcjVvZU0gNLITvw/RemOvT7mRKtsR1dbgulsKKC5NM7TiG2d0EvnZUByN3cVDV
         6EjCnzhFD5ao5TOIXEIc6sHCkGfCLDbvnK+CQgFZEcL+em1/BlARllGspl6BLvu84RCJ
         K0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yps1e5KzrIWuWLTz7SlzGPsEJ9zx8qv8vtiS4Y+fzRs=;
        b=DDYw60QIxy9qI8N124wktGXpv77ToF090SxoR58l4u2SUWLZFzEGB6QpJGRU5IHNo7
         396vhZJ2K3545WNKieecr1oAwiC4YWjiDYQuAb6uq602Bz9BkGQn83hmhezFA4CF9ZkS
         6nmtb1wr6wlCqSNBsFeJBBil+t4xBGTTVnwMaxnyr4q3gI0gs9OWp6KUSTMnMwhWsksR
         sfkysfdDBm9akCT/nFtJgyVXTPGyMTQQGjvTSCr84+HKYo6lOVgBSCJ8uDCtpliaoC7c
         HNe0LNihAyEp33fBjb8Cd3pX4C93R/Jx1toketp1N2YwKufgDqjdibX1JFj1+evPzs2W
         ptjg==
X-Gm-Message-State: AOAM530+7AwkWw8j/k7IHSY47Qo7pvOgNIMHBdDyWx9SFkXuwLDtjWNw
        /+jNsk4/WF1zv65u6dZhFVam62kRjBfcTk5ZVVnIZQ==
X-Google-Smtp-Source: ABdhPJzqVdHx85a27hK4ZeMMJMNdsvH3jFYK4AvuGPChIjOe/zteMjcwE+Tgd+zwuo7mnmIVIAWeI0SXxcCKxVMk4Ho=
X-Received: by 2002:a19:686:: with SMTP id 128mr7865344lfg.198.1605887172681;
 Fri, 20 Nov 2020 07:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20201120015913.1375667-1-jannh@google.com> <20201120153559.GA4119@sequoia>
In-Reply-To: <20201120153559.GA4119@sequoia>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 20 Nov 2020 16:45:46 +0100
Message-ID: <CAG48ez22JooyfTbPkhhfU15Oo3vcRr-bc1d3SQV1aGFaQuwVfA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Remove bogus __user annotations
To:     Tyler Hicks <code@tyhicks.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:36 PM Tyler Hicks <code@tyhicks.com> wrote:
> Hey Jann - Thanks for cleaning this up!
>
> On 2020-11-20 02:59:13, Jann Horn wrote:
> > Buffers that are passed to read_actions_logged() and write_actions_logged()
> > are in kernel memory; the sysctl core takes care of copying from/to
> > userspace.
> >
> > Fixes: 0ddec0fc8900 ("seccomp: Sysctl to configure actions that are allowed to be logged")
>
> After tracing back through the code, I was struggling to understand why
> I thought the __user annotation was needed back then. It turns out that
> __user was correct when I wrote 0ddec0fc8900 and that the Fixes tag
> should be changed to this:
>
>  Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
>
> If you agree, please adjust and resubmit with:
>
>  Reviewed-by: Tyler Hicks <code@tyhicks.com>
>
> Thank you!

Aaaah, that makes sense. Thanks, will do.
