Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF629F11C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJ2QS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgJ2QS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:18:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB8C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 126so4040407lfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9EtR8ay+CFHP0VWhr60l9Agx6oBhnBUNvO58Pm5n2c=;
        b=ZypFrwHFGFdiH3//0NKW6vQX1p5u1pLj9CchSpsY8VglCbaO2vGBx2uveHOn+HSxzq
         O9Uwvtp1dzgD56WgMNXb2hhjjdjiSi/B1wQtiI6Ap/p4ZUtD3xctBS+5x3BZ2cOEhSSg
         +nX9mb4w+MOOeGPQM6MbQXVpUd2uhKi+z1z7Xtf6A07T8HHVYZ8i3zH4begi4U/VBCuX
         Yn2KWTFJa0FSTi3LiRcT1LGfcNUBE8/Mza2QMwPBACfFLoCzE6DaLbauBuPCkbTQgTWr
         QDTXah3K6U8HNIb/ifAcYX6mB4g+Nsw837iHGB7rnB488OMnyCTszLAZZ84zKoyFiCZ6
         VzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9EtR8ay+CFHP0VWhr60l9Agx6oBhnBUNvO58Pm5n2c=;
        b=QWKleTVkhm6Qp/j19/XLiSDViSks4DwEG7bCwt6wMWx3ySnjj2+MGn7dqYWyuUoWun
         IEFRFVf2nK7PKLRHLUFHXEYxM8ZfMgVX4+S7qmoU/agMlKq/xs2fF4aQRRCJOiUPq8qA
         19K/5wQfMLgN8IvTowQN/SS8xLdXOBpufki3Wz+9gM+XkLVgw6XKUp7AKEMNFplnP1dK
         azk63mUW/BaDyJPMjPNPiNN0otXii8CKAr6SSGkFehPwzLh6xx7LQvoybTOSKqbSH5Nu
         arzzbJ3hKcK/0r6ADUUdWOg8XypgNO+lilqLzBZ+Ph9y2kp83QulR24Y/kHNA4OR9lLg
         YaNA==
X-Gm-Message-State: AOAM5303Ia78RVOgsqbeepX/CbCryVPM92g0SF4NEIJap8C/ce7z62Ee
        IbwI8hBYp+hnCq0SSD4v7aAGwggeN+X8/JJzdG2y7w==
X-Google-Smtp-Source: ABdhPJwDUMPMP12s120vl/5u2CihW7CO4f8+IgmIiwZd79+cJvWwOZSSCzYSedlU15A8/2stmps0+QqOjNwIgwF0euA=
X-Received: by 2002:a19:7719:: with SMTP id s25mr1785670lfc.521.1603988336095;
 Thu, 29 Oct 2020 09:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com> <CAMZfGtW38sFcdpnx3Xx+RgRL37WzpQsq8qvfdnmhbh4H9Ex0cg@mail.gmail.com>
In-Reply-To: <CAMZfGtW38sFcdpnx3Xx+RgRL37WzpQsq8qvfdnmhbh4H9Ex0cg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 09:18:45 -0700
Message-ID: <CALvZod68HooK_bnaxFLEBL_neVybVRECkHJyb6r8LHWqwTOe5Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcg/slab: Fix return child memcg
 objcg for root memcg
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 9:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Oct 29, 2020 at 11:48 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > Consider the following memcg hierarchy.
> > >
> > >                     root
> > >                    /    \
> > >                   A      B
> > >
> > > If we get the objcg of memcg A failed,
> >
> > Please fix the above statement.
>
> Sorry, could you be more specific, I don't quite understand.

Fix the grammar. Something like "If we failed to get the reference on
objcg of memcg A..."
