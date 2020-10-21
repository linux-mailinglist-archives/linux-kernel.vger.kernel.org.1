Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6465429524A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504143AbgJUSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393547AbgJUSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:33:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069F8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:33:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d3so3645337wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5j6DB/Z5rJHZN4Xv7MCF1wLoQyev8+XvCjJ+bJuvbWg=;
        b=pBCFQeyKSJiVVPEep2Tg482gOn+YHInxQc9UW+D6rVFfFdlNOMY1N8Q4kB9MpHRsiM
         7UddmLOyN+wpR46uQBiF5cQeXdF75LWERzVtR6T+kUBRbr1ZTaJSeHRHtiyT9EKG3fuD
         jXDw/Hcwp8PCZ/OGehABf2Qw+/HKgH0pWujaNTQN0HtgrcuamcptuGerIU/D/eQkSnGN
         1KqFjBZgzu9uF3sRmRfRVBEHLD8raWonn1VxSJcyiUk9nWAdoIwEGNXpL3fbF/BJAuH2
         9x5cWHx0VGiheV8uRQ1dFurChN1VygL0HmPk0qAHQ0gp2tnKA4GucmQUwfwdZ1DnX+lj
         5Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j6DB/Z5rJHZN4Xv7MCF1wLoQyev8+XvCjJ+bJuvbWg=;
        b=lB/RwD8RRXmL/dK/HYPObQc4zm3yjiWNpCUL4WWHNJU48/3IYXvy9iMCmWFPQC9I+5
         YuaMROnVlvkz7dhEFYD83O+JlX0ClP4DNmhi1TnItZS/EY2kMFQgPkK3i8uKzZ+AGbLp
         onph+q1uyEGMoVpDG18ZxJApnBjk91zh0k39lnX7n8uiDMrQhmO9OYtyfTItXPTORxxF
         swmbCU586NzSFKNrdaczS1aPaifBCGTr+ll/3gW+SmrAYIuI7EW8uoYtDt68hNFK2hvc
         IKBQT769W9elNQTvTyYn4toUDBEyyhLuztDExz6v9NwsjTnkygNpgeaDqaIYBVYohxPA
         Wf0g==
X-Gm-Message-State: AOAM533/xAavtxW+9f91GKbUkKmGJ7l0gUNHQFJzJwyNJVHa7H/8DtwP
        58ZubwJmL+ViDUGTi7kQqfB4Ndb0CiM0SPW9oSE=
X-Google-Smtp-Source: ABdhPJzPaIruAPrEkLX+4gFBwskCJuWJ/R1jH2ZlUJQ08UNuVVoDQ7DYW2fnxGZo+EekRucucu9hHau88dnsgXcrSms=
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr5008613wma.56.1603305203705;
 Wed, 21 Oct 2020 11:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201021182610.4l65yg3y3nhzcac4@adolin>
In-Reply-To: <20201021182610.4l65yg3y3nhzcac4@adolin>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Oct 2020 14:33:11 -0400
Message-ID: <CADnq5_PkEszu1Uz+vcnVF+_qUgVmMAcO_vvKhpVFVm0N0PUR3Q@mail.gmail.com>
Subject: Re: [Outreachy kernel][PATCH] gpu: amd: Return boolean types instead
 of integer values
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Oct 21, 2020 at 2:29 PM Sumera Priyadarsini
<sylphrenadin@gmail.com> wrote:
>
> Return statements for functions returning bool should use truth
> and false instead of 1 and 0 respectively.
>
> Modify cik_event_interrupt.c to return false instead of 0.
>
> Issue found with Coccinelle.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 24b471734117..8e64c01565ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -66,12 +66,12 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>         vmid  = (ihre->ring_id & 0x0000ff00) >> 8;
>         if (vmid < dev->vm_info.first_vmid_kfd ||
>             vmid > dev->vm_info.last_vmid_kfd)
> -               return 0;
> +               return false;
>
>         /* If there is no valid PASID, it's likely a firmware bug */
>         pasid = (ihre->ring_id & 0xffff0000) >> 16;
>         if (WARN_ONCE(pasid == 0, "FW bug: No PASID in KFD interrupt"))
> -               return 0;
> +               return false;
>
>         /* Interrupt types we care about: various signals and faults.
>          * They will be forwarded to a work queue (see below).
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
