Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8982B1E53
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgKMPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgKMPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:10:47 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AFDC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:10:47 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i18so8601902ioa.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqYVfEHdstLJDcIWROjqjtKTyucRszCwmWGVvQDjJQs=;
        b=b8fsqVWoMa2+F6qaJDtvjZCrUpTN1Js6GmdfH65U/3qx+2sc7Ub1OCwWrwTVXGPkYR
         aitwxAiVdrVH/EA9SZpTwx6r+t69UebGqmW94+9xXD6YmIIoKE9h4D/WfuE3mnl7on4L
         dXb6GeOSeqgatB2hrpzGoNKmMp7WqDT9+bir9A0cUoUPxeUTaYNkutSBgNaMqN17Q1ob
         o8TcZiGln9ExgwXDTvlMQ50f+kRe33bv9F45LOWXXFCPxATfv5yLqzRqotqFcdMNP+pj
         qHarggnP3fTnOkc15OyeugUuEYGrTnOXAW3d/K2fgUX4rL5oaKWrIrxl+ZahIQThwJzR
         hUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqYVfEHdstLJDcIWROjqjtKTyucRszCwmWGVvQDjJQs=;
        b=Nvn6iX7oSGS0+fyJjlFGsuIwxwJSeawA1fnfW6r9RdQML/o18ytl1wjgsgBp1tw5WB
         XqpDsMromLVOppyveAskUL1qAUzJUQG3plO+kLbaBP+OikMJBeNNMvArfg2m59dKIqwo
         bLovzDmNIl/IX8R6QwjkApND/HFpXYv9RhwsuzMd5oaNrQljGAufjcVL0gCVSmYOsidG
         MjJmgUISpx41qVAgFuH3Yb2tVeW8wgK7M9N3gR+xTMGEVhZmf7wzaNGMwWMc6z5uxRPM
         8wfqVYSjIbbrkzKnVTzqJiNzQkYKH49FIojtjaHBESKwxfZ6FTLtaM9NvhkN2CMQ3gLo
         TJ+A==
X-Gm-Message-State: AOAM5339KWNtyRs8Hd0VBN9M2kNpD5KeMVhdHSQ1EC0hj83ZYOdqK7wP
        PRrKwq07WfH59qBjSnLJakHHotKCNykUvYWVPrs=
X-Google-Smtp-Source: ABdhPJzLdPima03y6qgVeBglv6heP573C6yMxNq/WpghhqVue/a675oAsC21xYYdtg8PJRGlVRTKpAZOPXk4ZuyuPTs=
X-Received: by 2002:a05:6602:123b:: with SMTP id z27mr148789iot.167.1605280246091;
 Fri, 13 Nov 2020 07:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20201113141048.GA178922@rlk>
In-Reply-To: <20201113141048.GA178922@rlk>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 13 Nov 2020 16:10:34 +0100
Message-ID: <CAM9Jb+hJsjSm-2JVe2JSXndif_hz03hFLvR+LjxPQUxQN+HH3A@mail.gmail.com>
Subject: Re: [PATCH] mm/page_counter: use page_counter_read in page_counter_set_max
To:     Hui Su <sh_def@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> use page_counter_read() in page_counter_set_max().
>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  mm/page_counter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index b24a60b28bb0..c6860f51b6c6 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -183,14 +183,14 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
>                  * the limit, so if it sees the old limit, we see the
>                  * modified counter and retry.
>                  */
> -               usage = atomic_long_read(&counter->usage);
> +               usage = page_counter_read(counter);
>
>                 if (usage > nr_pages)
>                         return -EBUSY;
>
>                 old = xchg(&counter->max, nr_pages);
>
> -               if (atomic_long_read(&counter->usage) <= usage)
> +               if (page_counter_read(counter) <= usage)
>                         return 0;
>
>                 counter->max = old;

Reviewed-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
