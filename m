Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAC278399
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgIYJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIYJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:10:27 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BA1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:10:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so2256779wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4bxN2fagu2rIKQxxyvxxjzncZ5aqxZkwbZ2FY0Psst0=;
        b=LxdC9Zu/73+wFvQcMk2+2joqpYrO9qtRHkxX8hNdZGlt7eQGoB9dygmySiEslOrlEF
         wYF0qYgQZbhczxJ8t5Tbl0VtdDZ+vruEJxtx0jq6acTdd+c4jq3aJAVLO1nc6afAK3qQ
         RgBq81pCn5niW1axKn/dLdeUnGx5zfai6EX7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4bxN2fagu2rIKQxxyvxxjzncZ5aqxZkwbZ2FY0Psst0=;
        b=D+jlqDejAADB5hqEUsdnpTIdAgN5Cgn6t4ewmS00PHUAVpuODUmGuHekiBsNNqMxxy
         17qbdCYarBruTbJjALHqBa8aUBdzbq433TujwX1dZSxxAhuW3cKPs5k+zEpv/NLSVp0l
         B61oRXPtktUnDMgfFkbpZ1V/mI7e0E8j3v68rlubiCULnkcWgtLmyh9C9buH+Ece0w/3
         Y2eDO9PzuqDQ5aY2OEQ9C/1kxPAPsKfncIXsgs+vi6gKxcYiypGuteaiQcgvNaX62WiL
         cdIn2zMVkvW93qHm6LbypRpil5RgM4V4NSKtCXGrdsNQxs2MXUcO8oxsZp4obv8v70C4
         AXGg==
X-Gm-Message-State: AOAM5335dwasU19J6OO6bKqoIXz5Xa6+IIReObeALOKfcbmoc/jzG33y
        MTKoKchBnLWECswKq+0fKwTsGQ==
X-Google-Smtp-Source: ABdhPJz39Njw83y/iQ1by8WVklDBrwBAysH2nbHjX1h9i0Z3FFq/537COlQ1R7PRkQNkxthD8z2i+g==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr2003936wmb.71.1601025025796;
        Fri, 25 Sep 2020 02:10:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm2106005wrt.38.2020.09.25.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:10:24 -0700 (PDT)
Date:   Fri, 25 Sep 2020 11:10:23 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     eric@anholt.net, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] drm/vc4: Deleted the drm_device declaration
Message-ID: <20200925091023.GE438822@phenom.ffwll.local>
Mail-Followup-To: Tian Tao <tiantao6@hisilicon.com>, eric@anholt.net,
        airlied@linux.ie, sumit.semwal@linaro.org, christian.koenig@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <1601023898-29886-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601023898-29886-1-git-send-email-tiantao6@hisilicon.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 04:51:38PM +0800, Tian Tao wrote:
> drm_modeset_lock.h already declares struct drm_device, so there's no
> need to declare it in vc4_drv.h
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Just an aside, when submitting patches please use
scripts/get_maintainers.pl to generate the recipient list. Looking through
past few patches from you it seems fairly arbitrary and often misses the
actual maintainers for a given piece of code, which increases the odds the
patch will get lost a lot.

E.g. for this one I'm only like the 5th or so fallback person, and the
main maintainer isn't on the recipient list.

Cheeers, Daniel

> ---
>  drivers/gpu/drm/vc4/vc4_drv.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 8c8d96b..8717a1c 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -19,7 +19,6 @@
>  
>  #include "uapi/drm/vc4_drm.h"
>  
> -struct drm_device;
>  struct drm_gem_object;
>  
>  /* Don't forget to update vc4_bo.c: bo_type_names[] when adding to
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
