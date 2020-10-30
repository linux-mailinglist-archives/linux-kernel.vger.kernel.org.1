Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5431929FC3C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJ3DfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3DfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:35:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30925C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:35:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g12so4908214wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=059naSWfurNn2aUNwcfHXakrr4O73rHmWhbtYJ5BFu4=;
        b=sN1W6qxW83FwgI/hiYVad7M010tIqNjEifXVM+igY/j76qLOP+HDuyUAJ6lxaOiQgm
         1RoOtyvcl48nwtECpAlxj5kTcUZ3v6GYXEJSw6dzSLsIYJiXcC7igmcZNR+LptJtiEt8
         CkANG3NRGkZ0yQdx/gJD4g8D38NJEqYqJzqvH1pu9W7NzzzpFn3sNyp+o4vQ1Fv8v6HY
         Ew7T/W6oYINd/0Xa6czUH3zJ4b8wG52IH/6H5mLnpoBmcoj6EooUcpFKXeWXw5TpEAbQ
         fYLLezTyHmttOcx3xHgcToQmzn8o3+ArxM3sBIh6Y3aSU2Bykydo5p7Lqpy1VKTtK8ej
         VNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=059naSWfurNn2aUNwcfHXakrr4O73rHmWhbtYJ5BFu4=;
        b=EPJtPgmQUHaQz6u21tMel5k13MXYZWnqlvd0hGYQSAH5ivB2btIQwRIvN6TblHusTf
         aKWULQPQYqEqaNgdmtsBACvwEnTBMjPqerJSq42wLRXSbQfrNZ4enFkYUy6ft+MS2EPC
         MQPbG8ZRnJOb2RPC3mBhbMOU7ov5HKYR9PJd+CFCShci1tK3prRWR/vMjNOc0degUX30
         ygArQ3/9OKDkZtgwM/KtVks07fmxfUMtvpIjmi7xregoL+JCOJMQ3FC/pPXGtpN/I0ig
         6K0iTMBI32LqRV3lfIY5MjfaqJRGkXHOeJiu0iQ3sd5JxjVQ2dbgRRSSsSpP4wcUpcNE
         7XIA==
X-Gm-Message-State: AOAM531WIvpeVA6lvxmdSZIedsdU/lrQwR9t2wkewgQP3DIMMSr7c4Vj
        OOWF3AyPdQUMyd5LS9pQrqIKQZ71Hn8G57AktEA=
X-Google-Smtp-Source: ABdhPJxtD4X3iywmdZ0jW00LyhYdLNA9SC1N0Wv3820HxFdKXhmI67dXiwkKIzDvwYFHMjfvbJonG6MpaIIsHpqNNg4=
X-Received: by 2002:adf:f181:: with SMTP id h1mr331178wro.374.1604028910967;
 Thu, 29 Oct 2020 20:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201027190726.1588801-1-trix@redhat.com>
In-Reply-To: <20201027190726.1588801-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Oct 2020 23:34:59 -0400
Message-ID: <CADnq5_NbX+6bn13MzfEwFF86NB+Y8QsToiPZ21LfQgYXube1Pg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unneeded semicolon
To:     trix@redhat.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kim, Jonathan" <jonathan.kim@amd.com>,
        Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        zhengbin <zhengbin13@huawei.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        Joseph Greathouse <Joseph.Greathouse@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        "Chen, Guchun" <guchun.chen@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Dennis Li <Dennis.Li@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  I dropped the first hunk as that fix had already been
submitted by someone else.

Alex

On Tue, Oct 27, 2020 at 3:07 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 1b213c4ddfcb..19c0a3655228 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -654,7 +654,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
>
>         default:
>                 return 0;
> -       };
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8bf6a7c056bc..a61cf8cfbfc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -953,7 +953,7 @@ static char *amdgpu_ras_badpage_flags_str(unsigned int flags)
>         case AMDGPU_RAS_RETIRE_PAGE_FAULT:
>         default:
>                 return "F";
> -       };
> +       }
>  }
>
>  /**
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
