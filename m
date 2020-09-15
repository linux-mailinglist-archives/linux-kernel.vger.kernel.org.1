Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5626ACDA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIOTBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgIOTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:00:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25104C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:00:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z9so562709wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbe6ZdGxEwcR9b8K0OVEiXqHGKm+h0uIzkdUkf9gYZY=;
        b=pghfZgdnq8jzq4Y9ctQ7O0/bHaLkehG1bO6eU160MqB/26LXMqmZ02GDPT5ezdRe5e
         MAkvtsbEUdm2eN7RMJQFwu7O7/iGzjKD6+aHT2gV0m7Co8/LxdI8dO440P3v4oKrQvDK
         AFK/P15dkXiNEjTcQ3tcbIhYgjzGMSWyR0EgGHTyt6Zap9pUqv7GYR0Y4Wo1mH7jI9YQ
         luMSDZv1mp3/KlxQOSYRPjzO2rFo5GhOpE2AyqGCWJvlS7S5wjiKCNGE2NFXiqpcumXV
         Afnhd/1SZW5/rImGmQ/PHjTwQ8TM8ITaJfrKM3DlcE08egSPLBaavcfHGEStftXi2hWi
         GEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbe6ZdGxEwcR9b8K0OVEiXqHGKm+h0uIzkdUkf9gYZY=;
        b=SZTnqrCtX97hVNhoCr7fyhXzZuTOjMBv9zAoBoRjRbydtU/Yh5X/hx5AXnQuRrbrqv
         6ePgzWRTkyedSsG9YoExvysREw3XfwDACGFTGJXZyzER0vyUzphPZlVPjBlVPc0CUmt6
         qUqbq6jJVsdYC4ynSrL/P7Jrijq+1TlJYp6Km68niy8/PG07n4+kqCbN0cZsRqDdv114
         R+RvS3vAeloWcdB7N3VQMur4Egs3dn9YKJYUcV4JVZ7wxJbVIfQw7akmIYw+KFVXmQ5M
         MXJXqbYc7cyk8wZ8oUZ3ttdLM6TjUM9lfoisJsKmd4iPkaVPaACWo4MHWzT/QFjA5wcU
         0orQ==
X-Gm-Message-State: AOAM532z0KAKHOMdFPwMgs9MImPsmVeCd49WysAGACiZELLREVEPAfgD
        wIxkAARWmzDgu6zahKGzmaZ2ef5ttldHYTRjM4c=
X-Google-Smtp-Source: ABdhPJyljGcRfZpn6y481EWeKWChcjJq5SRsk2k7JhjzCh+4uKOhuKOaaAceyLB2dxwuOeEKhlHzqIlKZdCLg7ba1c0=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr785558wmi.79.1600196413885;
 Tue, 15 Sep 2020 12:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200908133552.105282-1-chenzhou10@huawei.com>
In-Reply-To: <20200908133552.105282-1-chenzhou10@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Sep 2020 15:00:03 -0400
Message-ID: <CADnq5_PfQKwGyuqtzCOUjvXdfQ8WkmeckaiqF2D5Wac+dmSG4A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Remove duplicate include
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Sep 9, 2020 at 3:05 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index a5d750ed569e..65dc5dcd4eb8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -35,7 +35,6 @@
>  #include "dcn30_dpp.h"
>  #include "dcn10/dcn10_cm_common.h"
>  #include "dcn30_cm_common.h"
> -#include "clk_mgr.h"
>  #include "reg_helper.h"
>  #include "abm.h"
>  #include "clk_mgr.h"
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
