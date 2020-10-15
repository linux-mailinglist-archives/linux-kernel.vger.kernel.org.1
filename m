Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D406228F54B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbgJOOxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbgJOOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:53:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99BEC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:53:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b127so4018288wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+E7HunszzPZSotVNRgNcC7Nfy+vpMwTQ74FpdWH9JM=;
        b=sLA+aCJEXSwtHlBJJzmLua1KG22wStLlb7ofOKhxgeNdjBAzu596rx2IbIMwrnB3ps
         5bGPxHqmQZWqVkdslLY7Cam7xHB/fmD0W6JSSrbBTNpEPYHZfsGW/X9M1+dcxYX9w4au
         dfGvCiNpJ/DSZMDkeyANmvgoMk4tua9uZw6A5zCOsxzzvxJpXN+EI2DbfQIvgYW83yjZ
         om2L/YC8lsOWyvRJVJnmAG7EJKdTEJ92WfNEKuo0Ti0rfr+yeelhiKmQ8ZZ3q6Y8EXgs
         9EU4KjGn/ww708Jz8tBSf9dViHOQtgxS8ieiiuLnU2yqmXKwBwHAxhWxaHWyalymzah+
         gEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+E7HunszzPZSotVNRgNcC7Nfy+vpMwTQ74FpdWH9JM=;
        b=VFwKSuvlH28KS/d09LM/mpHnEFLVz6GArcwy3IOjpTOF5zWII68JmQLAqcEO9FsVS6
         eDmISVtKUWk6NFtAuR38UTgFs7RGFwkU6P3k8/eqdQCyXVQeTJ8M1umAGiB6zegk0FPu
         oHPE+D68bYjytabdphLiPgicZvkHwtnfXXv6CLJOBIghK0/Gr9oClfzN7DIBI/Ah8sFI
         juCihWWELXCQlEyk6YcLgnPOafCQsTS1Zp62B9R6nHUNCdJQJjuJkZtQnKbpWFI9zIZt
         pg8qQKahok/Ao/c3eu2Y2NBpYFJX0MMMDmhjz07sYvIftxvjUg8lkNFTyxn/KJxRVn10
         PONA==
X-Gm-Message-State: AOAM530aNMxoYwhbUyWMy9/Vgc6RFFMbFnpgi3d9xJtd1VFs9pih78fW
        P+w7msRY4msD7RAfvyj+L9B0xjAqCe2LvzPWjQ0=
X-Google-Smtp-Source: ABdhPJxSVlYADlSa2G7Ly6zx6sWDW2MUAiGZDD0DOatN/musxqLz9Ij2aDC59rAdSqszHKz9juBSxDcxeCvNNcJTVcE=
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr4537548wmd.79.1602773620456;
 Thu, 15 Oct 2020 07:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <20201015135932.GA277152@PWN>
In-Reply-To: <20201015135932.GA277152@PWN>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 15 Oct 2020 10:53:28 -0400
Message-ID: <CADnq5_PqhJFRDofb0pNsgrp7O8M_D9o3gz5_Nt8KL=0cgMWoKA@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 9:59 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> Hi all,
>
> On Thu, Oct 15, 2020 at 11:33:08AM +1000, Dave Airlie wrote:
> > Peilin Ye (1):
> >       drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()
>
> This patch is already in mainline:
>
> commit 543e8669ed9bfb30545fd52bc0e047ca4df7fb31
> Author: Peilin Ye <yepeilin.cs@gmail.com>
> Date:   Tue Jul 28 15:29:24 2020 -0400
>
>     drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()
>
> It has been applied to linux-next twice, for unknown reasons. Thank you!

The patch was already in drm-next, but since it was a bug fix it was
applied it to 5.9 as well.

Alex
