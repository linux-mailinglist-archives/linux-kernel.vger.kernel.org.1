Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7BC27AE31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1MvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgI1MvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:51:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD2C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:51:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x123so936463pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QctrJGO1I1Zuq9UjMR9T/NENbwiqNJx5W8ogBL7RQ5k=;
        b=Wdbs+kQhoDgB+n99eSez3KyAycIljc9Qj/GQ39BXZvD9xGiS9EynalYs0Q4br8vS12
         drU4r1qnw04T/+k4hDdBJ6lu/ugHFPvQ59DawL4UGbaCznu28po0/vwp23JsmL6ajkU1
         7+dL2mIBh/kofHf4TWgUnp63wdbkh2lK8w+K5UXkgLGA0XEBvGo9II52ooO2Bf6XPsfJ
         L5iQws00GWLHkVNkL6qkJJZLkS3USdMpipUqDZZTbxkKZQshtpRw9B8cD/yIr0LSj3Lk
         ONA23uHk80zPrU9hYVszOHe/Veleq9MpkYzzePz31Ywp24nsCK2jp3XDUBKlHeRYs2PY
         821w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QctrJGO1I1Zuq9UjMR9T/NENbwiqNJx5W8ogBL7RQ5k=;
        b=tIZLRg+NYqRqP4DEBXAUCJS3OO8N/k8TV8XMHnsZDnP5c5D4x8hUCP9YxbkxaN/ia5
         5U2JN03qVVamygULMbaPWev75NWh39PXGPIs0DaKVVOVy3sQD3aj4NXVHGLZ7LRSegvV
         irntMRGX80N3qqNvzfoeli+r+Qn6L8TqYzdApTUC75wUylsDllyrusATsP75ccPfVVy8
         jPQMk9PIlxatzlyPLjVwdZfSMHVFQG0+wyaPHe4yej9KRbQcYqAgjwvl76UVLzql4i98
         +mGLSECJiuDVGDMXJ1/Qu3Sv2mGfSnKzTHDXIc4yULy/4qI9aKYZ2psiasGP5zN36Jlk
         ahag==
X-Gm-Message-State: AOAM533tB/hMECAgg2tb30R9mtBXcS1m+xw/2hYGG7ET6h5kS/8dybAK
        PihOnFvBHprnghOp8+V1+yOyE87OYJ2woArk7OqyUw==
X-Google-Smtp-Source: ABdhPJz9AK/9Nb+6ZHbA6CAHV8fQ++VqMz+5ImOS6aqC3CdqZZQF7dyj+J1OJFyYnyhqbh7E1B/9cyjzPInPq4h19mk=
X-Received: by 2002:a63:c112:: with SMTP id w18mr1007690pgf.31.1601297481123;
 Mon, 28 Sep 2020 05:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200923114419.71218-1-songmuchun@bytedance.com>
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Sep 2020 20:50:44 +0800
Message-ID: <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] io_uring: Fix async workqueue is not canceled on
 some corner case
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yinyin Zhu <zhuyinyin@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping guys. This is worth fixing.

On Wed, Sep 23, 2020 at 7:44 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We should make sure that async workqueue is canceled on exit, but on
> some corner case, we found that the async workqueue is not canceled
> on exit in the linux-5.4. So we started an in-depth investigation.
> Fortunately, we finally found the problem. The commit:
>
>   1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
>
> did not completely solve this problem. This patch series to solve this
> problem completely. And there's no upstream variant of this commit, so
> this patch series is just fix the linux-5.4.y stable branch.
>
> changelog in v2:
>   1. Fix missing save the current thread files
>   2. Fix double list add in io_queue_async_work()
>
> Muchun Song (4):
>   io_uring: Fix missing smp_mb() in io_cancel_async_work()
>   io_uring: Fix remove irrelevant req from the task_list
>   io_uring: Fix missing save the current thread files
>   io_uring: Fix double list add in io_queue_async_work()
>
> Yinyin Zhu (1):
>   io_uring: Fix resource leaking when kill the process
>
>  fs/io_uring.c | 59 +++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 20 deletions(-)
>
> --
> 2.11.0
>


-- 
Yours,
Muchun
