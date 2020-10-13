Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F2328C58F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgJMAPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgJMAPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:15:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16070C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:15:02 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so9942648lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcAlh3D5iLy5D5zvtjnZlsBrwvPYCnLArQkD54CMr6A=;
        b=e4QFRiqDo/miM+WEUVN3tRDmXgSNBRtijwtdO7kttRQk7LMudYPtipxXOnTkFRqMkK
         Q2+24yIlPzr1u3pD2NhZ+c0FV6865f7/CaAcreo6J0bqUXz3FTHNUfTKSccZTvfC8zb9
         cXc8H/DdZal9BQSh3Y8KLhjHhoHsdrCtkU/KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcAlh3D5iLy5D5zvtjnZlsBrwvPYCnLArQkD54CMr6A=;
        b=ecLf2w0Bvlh2EjgswODetUaPhgnzyBc5yXt6mPo8BY2ZJ6FbAoX3ua6OCVAQwJer1Q
         r56IaliQNgntLMga/rJG3LZEpwnXqUlzVZtmQaRfxkPhc121Y4TxyW8f7SwtZVH0KYMj
         JfWJieaXLvMJzacWJN62gibOQwJQ2ucqgwIAp+SCV9l1MsytEXbVY66GxGunxl8sXs/r
         lG2asndxNbnY50BdP0hwK3AbODKCJ2BoHP5iof7GJ14LOAVCRpSRKsP6OOyQulYxVIQ/
         lVPvxQPxLmJxNX3/9RkpX5AujMkPvRGjKKvYvMi5obVslRqDOvuzvMYwJBmXX+QHHr6q
         leiQ==
X-Gm-Message-State: AOAM5309myIQTYb6v4QBQw/nGVUcHgw74N+Gcyzlm0CYfFqX0jhzOGTk
        jR3VeAVRs+ddU07Vdaf7MnVZkNu+N7KwFQ==
X-Google-Smtp-Source: ABdhPJw+GxiZ8dQ1osywp7poM/zxT6XH6J9fbY3N3PygIMeOM/Xff4sR/22KXw422Q/fBCjy0+9hlw==
X-Received: by 2002:ac2:5230:: with SMTP id i16mr8150974lfl.33.1602548099786;
        Mon, 12 Oct 2020 17:14:59 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id j12sm4452433ljg.22.2020.10.12.17.14.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 17:14:58 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 77so9942563lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:14:58 -0700 (PDT)
X-Received: by 2002:a19:c703:: with SMTP id x3mr8101151lff.105.1602548097868;
 Mon, 12 Oct 2020 17:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201012141451.GA3425471@gmail.com> <CAHk-=wiWowWNsrOh+Ye+b_x=7_4MQmvXq0cdmLwqr2=YYj-jgA@mail.gmail.com>
 <20201012214405.GI3249@paulmck-ThinkPad-P72> <CAHk-=wgYr6DHdK1p5RTa4yemf=6t86UtRnY4VhKjcvovBxO_hw@mail.gmail.com>
 <20201012235426.GJ3249@paulmck-ThinkPad-P72>
In-Reply-To: <20201012235426.GJ3249@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 17:14:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQDWhcH6jTJuS_OFpdnuh9mMHt7x7hJ5OocLVfgfKEqA@mail.gmail.com>
Message-ID: <CAHk-=whQDWhcH6jTJuS_OFpdnuh9mMHt7x7hJ5OocLVfgfKEqA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v5.10
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 4:54 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> In CONFIG_PREEMPT_NONE=y kernels, RCU has no way to tell whether or
> not its caller holds a raw spinlock, which some callers do.

Only kfree_rcu()? (And apparently eventually call_rcu())?

And since we have lockdep, and it warns about it, and raw spinlocks
are really really rare, do we really need to then disable this simple
optimization for everybody else?

We have been very successful with "don't do that then" rules.

Eg, you cannot do normal memory allocations inside a spinlock (or you
have to mark them with GFP_ATOMIC, and not all allocations can be
marked as such), and this has been the case basically forever. And we
have debug code and tools that will check that.

Why is it impossible to just say "you can't do kfree_rcu() while
holding a raw spinlock"?

Particularly for something like kfree_rcu() and particularly if it's
just about raw spinlocks, it would seem to be very natural to just say
"just delay freeing it until after you've released the raw spinlock".

Because I sure hope that you don't find raw spinlock users in random
places. It should be stuff like core scheduling, RCU itself, etc.

> Making CONFIG_PREEMPT_COUNT unconditional allows
> RCU to make this determination.

I understand _that_ part, but the thing I find objectionable is how a
small piece of code seems to want to change the rules we have had in
the kernel since basically day #1.

(Ok, so the preempt count itself is much more recent than "day #1",
but the basic non-counting spinlocks do go back to very early in the
SMP stages).

                    Linus
