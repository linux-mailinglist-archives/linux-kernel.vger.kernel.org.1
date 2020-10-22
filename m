Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B3B2960BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895579AbgJVONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895495AbgJVONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:13:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0A6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:13:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so2438296wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=enF/NQ78UlHZi0kpjlRMqO+lesxBNMFNnWEi966YlwU=;
        b=lcgl8RehFALlBvKW+2WEqI6hL3DQCvnayUx386YFYdIACL6eZdDekWSge6wl0xau/P
         OurS80PGFdE+uCz2ywydsXe1KEcW2OKxZnMZUyxNDMbbrQ0IMr0SI/JTRmyVAXaE9J1O
         hmmezb9rcO1k/LRCAp+BJe5NUZwtKmz2hdtkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=enF/NQ78UlHZi0kpjlRMqO+lesxBNMFNnWEi966YlwU=;
        b=KZO+Hsb3Y2Sg4SLpmcSPVE39l39JX6dvzvB/i+jhrwjpJigVqKSvwAwHUWnAF/EHDe
         4inHxBh9juNhFHnStEs21U8kikaXA7/gC68rZrg8CTqVUBdrPtYI58aQlA3hwOentCho
         mhPFb1NnA1mDU5ZNIQbSTwujNrFnlgEtjVmuVpSPfAiuJmVanZU0QaOZegw+koPGcDqI
         q2JplRoIDuelZxhiHVJzX5Ehn2BnENfkyM71YaHcGzTeNXj5A3OQpWil5cktQFai47mU
         jJFmHTgtP2PYDUce9IrTAYqqtw1Lbpg37wWlgwPMvloDNsgtY6NUHlpm2LeCZBjalz/A
         UY9w==
X-Gm-Message-State: AOAM532Di/pRJ214yHvO88529U+6JzMjSr13NJ1ZJ2P8DOTd/Y5tdWNY
        wiI0rUJiHeD4/Pq8xdJKm8wX8A==
X-Google-Smtp-Source: ABdhPJwHYDGIRoRMV1tiPrqE+G8DvABiHKwtdx9svGn7vK4QZAvd1J5pyjsiQ/shrV+Vnd5qklpZ6Q==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr2863073wma.95.1603376030491;
        Thu, 22 Oct 2020 07:13:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y4sm3726390wmj.2.2020.10.22.07.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:13:49 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:13:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, melissa.srw@gmail.com,
        linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel][PATCH 0/5] drm/amdgpu: Replace snprintf()
 with sysfs_emit
Message-ID: <20201022141347.GZ401619@phenom.ffwll.local>
Mail-Followup-To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        dri-devel@lists.freedesktop.org, outreachy-kernel@googlegroups.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, melissa.srw@gmail.com,
        linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1603371258.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1603371258.git.sylphrenadin@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 07:07:50PM +0530, Sumera Priyadarsini wrote:
> Using snprintf() for show() methods holds the risk of buffer overrun
> as snprintf() does not know the PAGE_SIZE maximum of the temporary
> buffer used to output sysfs content.
> 
> This patchset is a series of Coccinelle cleanups across the staging
> directory to convert snprintf with scnprintf in the relevant files.

I think you need to edit your template here since this is now drivers/gpu,
not staging :-)
-Daniel

> 
> Sumera Priyadarsini (5):
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
>   gpu: drm: amdgpu: Replace snprintf() with sysfs_emit()
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c      | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      | 4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
