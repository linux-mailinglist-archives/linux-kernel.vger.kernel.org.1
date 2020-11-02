Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1873B2A30FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKBRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgKBRKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:10:35 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED6C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:10:35 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v6so18328608lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUhgKcjbc2s2EhhIkvemuRNHWDak5R9RJ9CGVBXgZ48=;
        b=HjoXjBTh/qMKF+PBX2unf6tg/4usdIKMSKAIxixFWbuZHeBxEiGMSat4Zh8HZSatkD
         yh34u2mi6GUPgEYC6XkEPYo9Jg3f2gJXkUFr9G4Vvun79vVX68OERc5TLzSyunRKdFDX
         dXic1qzf0FZGzvOWnm+oao39D40nWO8SbcQW9xGmSduixw6yzJAAWRiiCCgacbUftFDg
         CO3ynoaxLyFgWKeEvUBTvyhNfWfeINFsEGF0BpEt24j21pUMQmdXQoisKd5Nrev316TT
         QVVxu63+MfITJp0rNMsvdZHkgJ6zrk7DolMLGWJcPuz9HNC5O73afCtEwXRLxA/Cvp9z
         P+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUhgKcjbc2s2EhhIkvemuRNHWDak5R9RJ9CGVBXgZ48=;
        b=DaMnKlXuwLyEpOcuqMEl3PSCAfmjIbRrnMSlfiWLVpTBS08VTfMmc6odIj+RF+Mi1/
         Y9HMyk6CyAmQQXAfFZOwLNtHGEhj5jMAYi5MwbzL0PCR0Awr4xsa3XkjUuwzoR4Vypgw
         btF+3PgdFliBnBgPvTug5hdQwnO5KO1nVePbO0y4B6TVVvQ0QJ+Cd8X737mFgZ6JLWmR
         cIfo9OVjyTDSLw2tI1G0fsnrFygQ/jzINfkfY19AOcjAp/MFNyPHCCffMqTFVSSJC1Ng
         pSUHb46pDJlmszogHigPhdJInml02wjobEuxlt/nCq+cB7dv9zwP0pioJCN4gUuWen/U
         ESoA==
X-Gm-Message-State: AOAM531dtaFqsoPVQvg02KRp6MSwnXrwgfroxaWPMn4g1JSvRh8pREq6
        IQQfFZReVYvZp1QtyEhL21+ipUqOVcH7Lul7ydaSKK4fMUo=
X-Google-Smtp-Source: ABdhPJxkJnEbvYM5/968FpfLPAantffeO/sBABvh2n53Wp/IAlVp7pFGbWZ1wReq9yCdHL8ATpXRmVFjRmjODYdsmhc=
X-Received: by 2002:a19:c357:: with SMTP id t84mr5636062lff.34.1604337033294;
 Mon, 02 Nov 2020 09:10:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604335819.git.gladkov.alexey@gmail.com> <2718f7b13189dfd159414efb68e3533552593140.1604335819.git.gladkov.alexey@gmail.com>
In-Reply-To: <2718f7b13189dfd159414efb68e3533552593140.1604335819.git.gladkov.alexey@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Nov 2020 18:10:06 +0100
Message-ID: <CAG48ez0zGoB4Pr_+nLKaycCgEUtUrAvLJ89JG1ZbcbjKChMcng@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/4] Allow to change the user namespace in which
 user rlimits are counted
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 5:52 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> Add a new prctl to change the user namespace in which the process
> counter is located. A pointer to the user namespace is in cred struct
> to be inherited by all child processes.
[...]
> +       case PR_SET_RLIMIT_USER_NAMESPACE:
> +               if (!capable(CAP_SYS_RESOURCE))
> +                       return -EPERM;
> +
> +               switch (arg2) {
> +               case PR_RLIMIT_BIND_GLOBAL_USERNS:
> +                       error = set_rlimit_ns(&init_user_ns);
> +                       break;
> +               case PR_RLIMIT_BIND_CURRENT_USERNS:
> +                       error = set_rlimit_ns(current_user_ns());
> +                       break;
> +               default:
> +                       error = -EINVAL;
> +               }
> +               break;

I don't see how this can work. capable() requires that
current_user_ns()==&init_user_ns, so you can't use this API to bind
rlimits to any other user namespace.

Fundamentally, if it requires CAP_SYS_RESOURCE, this probably can't be
done as an API that a process uses to change its own rlimit scope. In
that case I would implement this as part of clone3() instead of
prctl(). (Then init_user_ns can set it if the caller has
CAP_SYS_RESOURCE. If you want to have support for doing the same thing
with nested namespaces, you'd also need a flag that the first-level
clone3() can set on the namespace to say "further rlimit splitting
should be allowed".)

Or alternatively, we could say that CAP_SYS_RESOURCE doesn't matter,
and instead you're allowed to move the rlimit scope if your current
hard rlimit is INFINITY. That might make more sense? Maybe?
