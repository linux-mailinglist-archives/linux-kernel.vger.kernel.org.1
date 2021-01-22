Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE87E300967
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbhAVROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbhAVRD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:03:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF9CC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:02:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j13so7375286edp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ke/qn9TuTwdPR0BXfRRkVX3tOOEqzWWEt/5038rSsL8=;
        b=DK6qQTGWlZbO/1KrKnXkTBmM7f3ehkB9ETlPBK6Dtl8NzhLfSZMoquqb93eycZXn57
         qSUc6IduN/h08n3jmoEGDcAicgjigIg+iBnARyPSGj4iC0PvhM1fAnBw4hNUosn0V3+v
         labbC3PTgMILUKqa/DiNcC0zqLH2gTm9HdmgjbmA8I0izc93cy0k9wJyNxcqc/Q87QPX
         geUd2bVapHAW8NGeEDDGbGsKn9HlsC9Xh3TUe7ijmRFAn0GT1a660sGdrlXtnvRwpdIk
         7ZKhmEIbTEoNnYrUBaourkqn/JUY1LUhjUgqsVNT1VlKxZsp0yp9QVrw6skymb9b7Fx/
         jHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ke/qn9TuTwdPR0BXfRRkVX3tOOEqzWWEt/5038rSsL8=;
        b=O7YqxpaylyIklmc+lm+jz/OfvsyoFpd2V3qzOpYJTg0KkKXpQzFuo1O7xgsml1+PrU
         +F0sAT8I0fn3qbHW4wrgC11NEfUUEilwFrhHe7mVCH3CdyTvGT0ovhxwcKUtQ48zlYxU
         arGIfCaOw0hRLSCtk59dgjF3RUPBNBTpVdPJTe6dwI6/qOFjD0yGVkuVnfYFWTzuG7l2
         PS2ks7LXJ84apkswXA0rs2RpHYglEBGfgMl6zjJEHcsnB5SbVoF1zode/hoJYYDuyK+U
         Hy67wlIdnsTZ6pJvrOQfoq8pu186Pa4jqvGQS3PVIxB81oH6pMnKMAmTdtNfiRicHjXA
         9Rsw==
X-Gm-Message-State: AOAM532nikAlgBNRhcVOJmSx7ZKdvve0pr7RfX4BgJPDvrAyv7U4tbKF
        MESSar5XkPemVBqHxAhtNdtPdgHDjMB2w0r+CuYK7q1+ig==
X-Google-Smtp-Source: ABdhPJybDZzkx9A9kmPqgORexS85AdcYmlb17I2eS1sUIlOqyFmXdWgBdx1uneSguKJ/EwhMThDbPIiu+Bx0ORFpKeo=
X-Received: by 2002:a05:6402:4391:: with SMTP id o17mr3982066edc.196.1611334966855;
 Fri, 22 Jan 2021 09:02:46 -0800 (PST)
MIME-Version: 1.0
References: <202101212154272626110@zte.com.cn>
In-Reply-To: <202101212154272626110@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Jan 2021 12:02:35 -0500
Message-ID: <CAHC9VhQuBFv83G05QQJLuOV903sFX7ijqjgpCvWH-dk7cbJCjg@mail.gmail.com>
Subject: Re: [RFC,v2,1/1] audit: speed up syscall rule match while exiting syscall
To:     yang.yang29@zte.com.cn
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 8:54 AM <yang.yang29@zte.com.cn> wrote:
>
> From 72f3ecde58edb03d76cb359607fef98c1663d481 Mon Sep 17 00:00:00 2001
> From: Yang Yang <yang.yang29@zte.com.cn>
> Date: Thu, 21 Jan 2021 21:05:04 +0800
> Subject: [PATCH] [RFC,v2,1/1] speed up syscall rule match while exiting syscall
>  audit_filter_syscall() traverses struct list_head audit_filter_list to find
>  out whether current syscall match one rule. This takes o(n), which is not
>  necessary, specially for user who add a very few syscall rules. On the other
>  hand, user may not much care about rule add/delete speed. So do o(n)
>  calculate at rule changing, and ease the burden of audit_filter_syscall().
>
>  Define audit_syscall[NR_syscalls], every element stands for one syscall.
>  audit_filter_syscall() checks audit_syscall[NR_syscalls].
>  audit_syscall[n] == 0 indicates no rule audit syscall n, do a quick exit.
>  audit_syscall[n] > 0 indicates at least one rule audit syscall n.
>  audit_syscall[n] update when syscall rule changes.
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  include/linux/audit.h |  2 ++
>  kernel/audit.c        |  4 ++++
>  kernel/auditfilter.c  | 30 ++++++++++++++++++++++++++++++
>  kernel/auditsc.c      |  5 ++++-
>  4 files changed, 40 insertions(+), 1 deletion(-)

...

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 333b3bc..9d3e703 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -926,6 +926,28 @@ static struct audit_entry *audit_find_rule(struct audit_entry *entry,
>  static u64 prio_low = ~0ULL/2;
>  static u64 prio_high = ~0ULL/2 - 1;
>
> +#ifdef CONFIG_AUDITSYSCALL
> +static inline void update_auditing_syscall(struct audit_krule rule, bool add)
> +{
> +    int i;
> +
> +    /* syscall rule with type AUDIT_FILTER_EXIT */
> +    if (rule.listnr == AUDIT_FILTER_EXIT && !rule.watch && !rule.tree) {
> +        for (i = 0; i < NR_syscalls; i++) {
> +            /* whether this rule include one syscall */
> +            if (unlikely(audit_in_mask(&rule, i))) {
> +                if (add == true)
> +                    auditing_syscall[i]++;
> +                else
> +                    auditing_syscall[i]--;
> +            }
> +        }
> +    }
> +
> +    return;
> +}
> +#endif
> +
>  /* Add rule to given filterlist if not a duplicate. */
>  static inline int audit_add_rule(struct audit_entry *entry)
>  {
> @@ -957,6 +979,10 @@ static inline int audit_add_rule(struct audit_entry *entry)
>                 return err;
>         }
>
> +#ifdef CONFIG_AUDITSYSCALL
> +    update_auditing_syscall(entry->rule, true);
> +#endif

I'm going to reply to your other email where we are discussing the
performance of this patch, but I wanted to make one comment about the
approach you've taken with the update_auditing_syscall() here.

First, naming things is hard, but the chosen name is not a good one in
my opinion.  Something like audit_rule_syscall_mask_update() would
probably be a better fit.

Second, in order to minimize preprocessor clutter, it is better to use
the following pattern:

  #ifdef CONFIG_FOO
  int func(int arg)
  {
    /* important stuff */
  }
  #else
  int func(int arg)
  {
    return 0; /* appropriate return value */
  }
  #endif

There are probably a few other comments on this patch, but I want us
to discuss the performance impacts of this first as I'm not convinced
this is a solution we want upstream.

-- 
paul moore
www.paul-moore.com
