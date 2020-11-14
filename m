Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5D2B297B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKNAGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgKNAGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:06:39 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CEDC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:06:37 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b6so12057495wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMwx6LSJmhzHC8ZwI/8VJ7EjLxTfqp/OPgMA3Bg83jQ=;
        b=nrKE/pW+KWhWL7CSJSxYp2bfQtrqaK67kOP6ChC/xDuQNJQPHtUu39mOKt5BQ/1Iyz
         cw/kthSZj4IYEDbey39LpdtlAmtJCw+iPxwM54LuojmucBh71oasiBOML7kI/Ik6bCZM
         wM5o5Xw4uqi7GB1JyXD6HXyZwYjpxMD3xmUmkez13aSUzi7snYzTXK6FGdciN6zVJuXe
         lXg2h7Q1qwiiVkxjoFnfGowHd1G1J+ASGEyOfkuDoGo26bwX+xAgRca3Dm/q8D0ph26L
         EoO3sgfQMnfcLn1kWx7OFTffF22K5ZrS/67y4dvmFqLSLBL4j1nXG1j5jZL93hiD5flD
         syKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMwx6LSJmhzHC8ZwI/8VJ7EjLxTfqp/OPgMA3Bg83jQ=;
        b=eRruWB8buioPBrgV3dY+zoyCJeiUSbSBXdD/7wQlloGumUuQf0pX2MLlIqin5684cr
         mquoD9JIJimJ393N/66xYCdM7wpMzyHz90KDQOtvg4FQ0s98T/njjETjRr4/bQuIidmc
         ez6vlt/WXbgtoOtw69qyXCvErkWn17AGUF4dgxSneyU/JPh2Z4ycvH2LB3Lj7GZp9onZ
         00b4L9hgfQSJ/5nH0qZxyLsq/nyYsHbjPKgn2Q0B2wHkkLFdnsrHNIRwJfXPiJ3gA+Yq
         kpHsMlnP1GzAO6PUTtPwjWQ2nI1wVcO67PEN66Nn2o5OWlTbTZlYob1FTAquHN24G3vU
         oxbA==
X-Gm-Message-State: AOAM53238uoCMit2gCCnexKNssTnptVHcZCVauX8lSV1gxgWLv13FLna
        LAZoxQgXetaWiRTLmAD7/3NbBr5Wso1q9Gtup6SdRQ==
X-Google-Smtp-Source: ABdhPJwWY4RJZxOCag2JXa57h3SCp1jATWMjlVteiWIgM6nKnyg8a1mu6hL4Duzswr0lpdXyinvH5OHjmlUhGdYZgU0=
X-Received: by 2002:adf:9069:: with SMTP id h96mr6694004wrh.358.1605312396203;
 Fri, 13 Nov 2020 16:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20201113173448.1863419-1-surenb@google.com> <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
In-Reply-To: <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 13 Nov 2020 16:06:25 -0800
Message-ID: <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 3:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Nov 2020 09:34:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > When a process is being killed it might be in an uninterruptible sleep
> > which leads to an unpredictable delay in its memory reclaim. In low memory
> > situations, when it's important to free up memory quickly, such delay is
> > problematic. Kernel solves this problem with oom-reaper thread which
> > performs memory reclaim even when the victim process is not runnable.
> > Userspace currently lacks such mechanisms and the need and potential
> > solutions were discussed before (see links below).
> > This patch provides a mechanism to perform memory reclaim in the context
> > of the process that sends SIGKILL signal. New SYNC_REAP_MM flag for
> > pidfd_send_signal syscall can be used only when sending SIGKILL signal
> > and will lead to the caller synchronously reclaiming the memory that
> > belongs to the victim and can be easily reclaimed.
>
> hm.
>
> Seems to me that the ability to reap another process's memory is a
> generally useful one, and that it should not be tied to delivering a
> signal in this fashion.
>
> And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> few changes and tweaks, but can't that be used to solve this problem?

Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
one of the options recently discussed in
https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
. The thread describes some of the issues with that approach but if we
limit it to processes with pending SIGKILL only then I think that
would be doable.
