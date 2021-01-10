Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D497A2F0919
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 19:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAJSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 13:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 13:47:08 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7614DC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 10:46:27 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n11so1155293lji.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 10:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQXV1o093eVpYrQ6SjYKMkYU2gxMAjF5N9e9XTlzNEE=;
        b=ZeHp/DLnTCjx/1ndzrrdXLbs+ofveQ60Mwd9VBFVezBZLlHfmdd3j2voOnqpw8488y
         HaLlr1rUwDJNnpcMRpAOAtKBNTqrWuGc2WNSPVEBGtVTzQC0Vzx8mbTatpAO5uM8+7wD
         /TrltXUH7SyNTMyWDX+1SlvDZZeSfzqrCwLlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQXV1o093eVpYrQ6SjYKMkYU2gxMAjF5N9e9XTlzNEE=;
        b=tGyArZfcujPLXWfmoPikDhM/5Fi9Ou68AT19EcRbiCb3ss7AXRKakKsofBy3KTm9R8
         JqcH1uzAO1Yglopj8FX+z9KxpkdLzeKQsuSluwFdrvpO/7F85JooEDuU7SzcFvSCY55z
         X2fEXDvot301MGICb8fPSEw7KMnRsMlgWaVGv2wPiTSSNE0n0bFgLT/NTEnG4ENrzuku
         IsuCq4HrVPYF8aMrN5O0iUJ9/ZBXiB1upKjF5J8O2TwuSe5D0OQwpa7QsGohLnYPMIa3
         AbAsSGCUP5Q7vqRbYA/YIiHP/34eXc71M/vaHseiwgZFXwDpv/oqGdphaShdheesLXDb
         4unw==
X-Gm-Message-State: AOAM530nNPMCJ9EHsTZk8tCLam9DuZmL7DTFHUghVCv0kMl4wGlMd0gQ
        AoNpbo+a6siOcHKKTUnI2Prbgc0/aKW0xg==
X-Google-Smtp-Source: ABdhPJwmxw9P5AxQM48VNifS+x/ImeUZZMKIv+ktTZQec1wBtDrHWZEeTu0DFROMW+4DCCnXKeDU0w==
X-Received: by 2002:a2e:8e64:: with SMTP id t4mr5649157ljk.141.1610304384360;
        Sun, 10 Jan 2021 10:46:24 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f19sm3131514ljm.7.2021.01.10.10.46.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 10:46:23 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id m13so1151582ljo.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 10:46:23 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr5614023lji.48.1610304382840;
 Sun, 10 Jan 2021 10:46:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610299857.git.gladkov.alexey@gmail.com>
In-Reply-To: <cover.1610299857.git.gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Jan 2021 10:46:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXZmRu762bjSeK80+T_LTo+UP9y5rP-uvym1vquSxmBw@mail.gmail.com>
Message-ID: <CAHk-=wgXZmRu762bjSeK80+T_LTo+UP9y5rP-uvym1vquSxmBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] Count rlimits in each user namespace
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

On Sun, Jan 10, 2021 at 9:34 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> To address the problem, we bind rlimit counters to each user namespace. The
> result is a tree of rlimit counters with the biggest value at the root (aka
> init_user_ns). The rlimit counter increment/decrement occurs in the current and
> all parent user namespaces.

I'm not seeing why this is necessary.

Maybe it's the right approach, but none of the patches (or this cover
letter email) really explain it to me.

I understand why you might want the _limits_ themselves would form a
tree like this - with the "master limit" limiting the limits in the
user namespaces under it.

But I don't understand why the _counts_ should do that. The 'struct
user_struct' should be shared across even user namespaces for the same
user.

IOW, the very example of the problem you quote seems to argue against this:

> For example, there are two containers (A and B) created by one user. The
> container A sets RLIMIT_NPROC=1 and starts one process. Everything is fine, but
> when container B tries to do the same it will fail because the number of
> processes is counted globally for each user and user has one process already.

Note how the problem was _not_ that the _count_ was global. That part
was fine and all good.

No, the problem was that the _limit_ in container A also ended up
affecting container B.

So to me, that says that it would make sense to continue to use the
resource counts in 'struct user_struct' (because if user A has a hard
limit of X, then creating a new namespace shouldn't expand that
limit), but then have the ability to make per-container changes to the
resource limits (as long as they are within the bounds of the parent
user namespace resource limit).

Maybe there is some reason for this ucounts approach, but if so, I
feel it was not explained at all.

             Linus
