Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA32C2D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390565AbgKXQml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390522AbgKXQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:42:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90915C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:42:40 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so2990420wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dze+9qs3CL67LNyJlDApQNkdcs/suDR4TCdiUKUwE5A=;
        b=DgUQSmvfX7fcj/3ueVABOb2YXaTAq8629BfhnSrAL77wmv/G3WWdloicSJO1qOCAJE
         An5T26D2FAVMoBIz6OCinKOBY/et6yFth4/rVoMr4ny58VdfabCYwpqX9Cq3nAPjM16x
         cOcwWROrqmxs6Ce3c8uBhSOll9lsNQI+L3yJs2aeWjPO13YPkPFO1178al2F3L/MfcdK
         vhz9rctErIPnpLIXEENVY5medWEIduJF7kczhhGv6D4MfC47Vgi6emGa4GcqUbJj1MMh
         rn2DK+S86MHAinqNlC7Yd/iro/oGdg+R7jXngJ7I5wW6FAp2Sq+rhe/Acn/770MUE5/g
         FnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dze+9qs3CL67LNyJlDApQNkdcs/suDR4TCdiUKUwE5A=;
        b=Xx/Q0a4SkEKE9Pqs5ilx5NYQ7qipRxEuuANr5+0cCFNy0utdzsWWUC2Sgdp4weHCZC
         avIcdCics/amZmvbtv39x+l7Rr4MK2j98CNT7YgNzms5Bq3MAB5ewwB0LvlcJiW5PkkN
         3PDC6E4cWzOmbKLbpoip2zIjgw8UEDTy67vcTd2q20WS2Ko65e68H1lIuhuj3OcNcr+X
         Z0jys0UBBc/QAG8VOISNcQUZhg3T5+N3qidHffLiSbhg4K+yuthcGmy6Iu0LGNcnsCnc
         IzW2S3ALzPeWfTmG+B7M/3JlT76DMZLWVoRZviDxuKXVDofY69pSLMyOCMcKkhiGlQY/
         y0kw==
X-Gm-Message-State: AOAM530Y/0BPEIDZnHW24IZbkqVQFh82XyAow7jf5CxAWx+04waWeOue
        JrbsjhZCi4tOHGx4vQ3EyOwgiDY/yV8bkT7E55c+CA==
X-Google-Smtp-Source: ABdhPJzcW6Q0VtnxmMDrevqVdV9vRxQg22ghFk+oO5YtNLDLp8wXM2tahrHunqHHAMd1A2ppbwLtFTeuU40+plshnvA=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr5298401wmf.37.1606236159094;
 Tue, 24 Nov 2020 08:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-3-surenb@google.com>
 <20201124134208.GA30125@redhat.com>
In-Reply-To: <20201124134208.GA30125@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 24 Nov 2020 08:42:28 -0800
Message-ID: <CAJuCfpGdH0EzA9KjNBtKm-yywx4XbvpXXBskQ-pzExXYsTqTRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/madvise: add process_madvise MADV_DONTNEER support
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 5:42 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/23, Suren Baghdasaryan wrote:
> >
> > +     if (madvise_destructive(behavior)) {
> > +             /* Allow destructive madvise only on a dying processes */
> > +             if (!signal_group_exit(task->signal)) {
>
> signal_group_exit(task) is true if this task execs and kills other threads,
> see the comment above this helper.
>
> I think you need !(task->signal->flags & SIGNAL_GROUP_EXIT).

I see. Thanks for the feedback, Oleg. I'll test and fix it in the next version.

>
> Oleg.
>
