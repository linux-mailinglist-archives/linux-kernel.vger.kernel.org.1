Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAD22A318A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKBRad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:30:33 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:44072 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgKBRac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:30:32 -0500
Received: from comp-core-i7-2640m-0182e6 (ip-89-103-122-167.net.upcbroadband.cz [89.103.122.167])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 028AA209AF;
        Mon,  2 Nov 2020 17:30:28 +0000 (UTC)
Date:   Mon, 2 Nov 2020 18:30:24 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH v1 4/4] Allow to change the user namespace in which
 user rlimits are counted
Message-ID: <20201102173024.oflzudkq6cnolqyr@comp-core-i7-2640m-0182e6>
References: <cover.1604335819.git.gladkov.alexey@gmail.com>
 <2718f7b13189dfd159414efb68e3533552593140.1604335819.git.gladkov.alexey@gmail.com>
 <CAG48ez0zGoB4Pr_+nLKaycCgEUtUrAvLJ89JG1ZbcbjKChMcng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0zGoB4Pr_+nLKaycCgEUtUrAvLJ89JG1ZbcbjKChMcng@mail.gmail.com>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Mon, 02 Nov 2020 17:30:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:10:06PM +0100, Jann Horn wrote:
> On Mon, Nov 2, 2020 at 5:52 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
> > Add a new prctl to change the user namespace in which the process
> > counter is located. A pointer to the user namespace is in cred struct
> > to be inherited by all child processes.
> [...]
> > +       case PR_SET_RLIMIT_USER_NAMESPACE:
> > +               if (!capable(CAP_SYS_RESOURCE))
> > +                       return -EPERM;
> > +
> > +               switch (arg2) {
> > +               case PR_RLIMIT_BIND_GLOBAL_USERNS:
> > +                       error = set_rlimit_ns(&init_user_ns);
> > +                       break;
> > +               case PR_RLIMIT_BIND_CURRENT_USERNS:
> > +                       error = set_rlimit_ns(current_user_ns());
> > +                       break;
> > +               default:
> > +                       error = -EINVAL;
> > +               }
> > +               break;
> 
> I don't see how this can work. capable() requires that
> current_user_ns()==&init_user_ns, so you can't use this API to bind
> rlimits to any other user namespace.
> 
> Fundamentally, if it requires CAP_SYS_RESOURCE, this probably can't be
> done as an API that a process uses to change its own rlimit scope. In
> that case I would implement this as part of clone3() instead of
> prctl(). (Then init_user_ns can set it if the caller has
> CAP_SYS_RESOURCE. If you want to have support for doing the same thing
> with nested namespaces, you'd also need a flag that the first-level
> clone3() can set on the namespace to say "further rlimit splitting
> should be allowed".)
> 
> Or alternatively, we could say that CAP_SYS_RESOURCE doesn't matter,
> and instead you're allowed to move the rlimit scope if your current
> hard rlimit is INFINITY. That might make more sense? Maybe?

I think you are right. CAP_SYS_RESOURCE is not needed here since you still
cannot exceed the rlimit in the parent user namespace.

-- 
Rgrds, legion

