Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3B327FA35
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgJAHZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAHZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:25:41 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50381C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 00:25:40 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s66so4463465otb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfGZF4MV9LWG1+NodJbiuxHC3TceIWUFb6Ap4wdqNIA=;
        b=TeI3sAnlerg81mosNDi1OU1FCraSaz39/P0KX8M369xRjqBBQkO+GqE2gaeovGyU5N
         SbXwsl1688O6wtDdN6VHp62NfTmHkeBC1jiNQ35ZVLOsXBUby+JsGUj4lx3gCLV/odyn
         gV7DGZGClSGws3CNeOiHg/3Ob+oMbLzNx+/Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfGZF4MV9LWG1+NodJbiuxHC3TceIWUFb6Ap4wdqNIA=;
        b=pPcQba03RAF29wFzIjorT6nyYz0N9GvBzhle2o4jYesord3iwEZ3KwS1mLjMTjyfg3
         KXRFY7GDJJps3J73l62OXOGwK4p7/7/l2OJ98JfD68Ic/o1laB9kIqaDzfXiU0MKV0If
         Lzn9UEyzKRq2G/8psnMtui/lfQMrTyCSripYnVlJC6WxdicLK0oFsz0U4eONBRRfTa4j
         iU+yPw3FaGoY3At+w53/X45g08HPug1BLBJiHT7skvEsDrvsP8A7IFwb9tUniTI3FVGP
         8/sbCKl8I8ZhlIBk5qVKQaQ6cL7p1r46muRsLNn/2esp79pCYisWOumhXAVF36Oc0CFm
         Zjxw==
X-Gm-Message-State: AOAM530HgYUF6Dm6yzAAXkL3yHdUl4LwwAHOlmuH5zmSpEmEXwTH/K0T
        1hJlfetLO7HP26yi+lYEmKQ/6T3+tuYiLDx+gMlF+A==
X-Google-Smtp-Source: ABdhPJxYphOpZt0pFo5YwUFzXc9UFWkrH6ESb9yDDzrn4yIDZ604inDZBF2z+vgTw/HQBxJ8xJ7E9csTDfXJDlrJHIE=
X-Received: by 2002:a05:6830:14d9:: with SMTP id t25mr4211927otq.188.1601537139212;
 Thu, 01 Oct 2020 00:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200930211723.3028059-1-robdclark@gmail.com>
In-Reply-To: <20200930211723.3028059-1-robdclark@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 1 Oct 2020 09:25:28 +0200
Message-ID: <CAKMK7uHHPWE3h7ssG-dpb3czwbP5VtZYztMA=CpvQ4HV4LQTXA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm: commit_work scheduling
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Tim Murray <timmurray@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:16 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The android userspace treats the display pipeline as a realtime problem.
> And arguably, if your goal is to not miss frame deadlines (ie. vblank),
> it is.  (See https://lwn.net/Articles/809545/ for the best explaination
> that I found.)
>
> But this presents a problem with using workqueues for non-blocking
> atomic commit_work(), because the SCHED_FIFO userspace thread(s) can
> preempt the worker.  Which is not really the outcome you want.. once
> the required fences are scheduled, you want to push the atomic commit
> down to hw ASAP.
>
> But the decision of whether commit_work should be RT or not really
> depends on what userspace is doing.  For a pure CFS userspace display
> pipeline, commit_work() should remain SCHED_NORMAL.
>
> To handle this, convert non-blocking commit_work() to use per-CRTC
> kthread workers, instead of system_unbound_wq.  Per-CRTC workers are
> used to avoid serializing commits when userspace is using a per-CRTC
> update loop.  And the last patch exposes the task id to userspace as
> a CRTC property, so that userspace can adjust the priority and sched
> policy to fit it's needs.
>
>
> v2: Drop client cap and in-kernel setting of priority/policy in
>     favor of exposing the kworker tid to userspace so that user-
>     space can set priority/policy.

Yeah I think this looks more reasonable. Still a bit irky interface,
so I'd like to get some kworker/rt ack on this. Other opens:
- needs userspace, the usual drill
- we need this also for vblank workers, otherwise this wont work for
drivers needing those because of another priority inversion.
- we probably want some indication of whether this actually does
something useful, not all drivers use atomic commit helpers. Not sure
how to do that.
- not sure whether the vfunc is an awesome idea, I'd frankly just
open-code this inline. We have similar special cases already for e.g.
dpms (and in multiple places), this isn't the worst.
- still feeling we could at least change the default to highpriority niceness.
- there's still the problem that commit works can overlap, and a
single worker can't do that anymore. So rolling that out for everyone
as-is feels a bit risky.

Cheers, Daniel

>
> Rob Clark (3):
>   drm/crtc: Introduce per-crtc kworker
>   drm/atomic: Use kthread worker for nonblocking commits
>   drm: Expose CRTC's kworker task id
>
>  drivers/gpu/drm/drm_atomic_helper.c | 13 ++++++++----
>  drivers/gpu/drm/drm_crtc.c          | 14 +++++++++++++
>  drivers/gpu/drm/drm_mode_config.c   | 14 +++++++++++++
>  drivers/gpu/drm/drm_mode_object.c   |  4 ++++
>  include/drm/drm_atomic.h            | 31 +++++++++++++++++++++++++++++
>  include/drm/drm_crtc.h              |  8 ++++++++
>  include/drm/drm_mode_config.h       |  9 +++++++++
>  include/drm/drm_property.h          |  9 +++++++++
>  8 files changed, 98 insertions(+), 4 deletions(-)
>
> --
> 2.26.2
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
