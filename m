Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7B32742CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVNTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIVNTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:19:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E28C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:19:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so17009214wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9GewOd7ipMCxF1aHwWxW4PsJZfwIrEIh8kBMz05Lk/w=;
        b=PzjE8iv+J3iIp+Oj4o3PfIPMtV8nUR7EAaBbIYDmYOpwjFlmejWWdMfF61ABZKnIML
         96KhiUwPwUKgo5Qo3t6TfKg5SFqQBL59u7bTjgQQv4SkvNWOxHUNtCDNQK+w8W1FHwKc
         P9m7bN1PVj3l46dRCfH2kjE28+5MztTu3wmxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9GewOd7ipMCxF1aHwWxW4PsJZfwIrEIh8kBMz05Lk/w=;
        b=WRqcE7IsJKuug+0pbAKWGuEgrE8EEnGm9sF8NVOmcNKFcgCnHydlc3wj2KWTB7YETi
         F6YjPbVd0HGT6uWHxYp3rSB1AyMjmy/7wxa6V/atmAB5A0+jlpXlNH640SOsbsSZJdhN
         2G0Ya9yq4/z4lXeJxCjekhudhmDEcl/sSvepvmlSnVF8IXgSMGhZDjrmFniyf46VCI21
         1xsOx/fcs7dVtreMKF5ccGWoS+5CErtviJlo4T/SpOpomZk9weVVQ+pQp4IFTa2ZJ13n
         6rJobq33A/xE+zi9UPohwVpaUtqW3TiuVIzGQoaSBbjRJ9EyxucxJ34wkwbybOMzC4H7
         N8Jw==
X-Gm-Message-State: AOAM530JTvaEuI8R+tDu8a981VidCqdZJ746zXXbwe32jEi5TOMdTI6T
        HkgQ/Wl1pRv6Ro1s+mfr0tDoUw==
X-Google-Smtp-Source: ABdhPJzk2cI1GO9aUXv3aroOKwskrl9jpqIgCYu3y/tFOrzYAI88vNvGrwji8l2K4v5ufLKV4CXjgA==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr5457066wrn.109.1600780759566;
        Tue, 22 Sep 2020 06:19:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y5sm26160278wrh.6.2020.09.22.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 06:19:18 -0700 (PDT)
Date:   Tue, 22 Sep 2020 15:19:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Colin King <colin.king@canonical.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: clean up indentation issues
Message-ID: <20200922131916.GM438822@phenom.ffwll.local>
Mail-Followup-To: Colin King <colin.king@canonical.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200920141407.32672-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920141407.32672-1-colin.king@canonical.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 03:14:07PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of statements that are indented too deeply,
> remove the extraneous tabs and also an empty line.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Pushed to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index 720a767118c9..50016a754172 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -1501,8 +1501,7 @@ cdv_intel_dp_start_link_train(struct gma_encoder *encoder)
>  	clock_recovery = false;
>  
>  	DRM_DEBUG_KMS("Start train\n");
> -		reg = DP | DP_LINK_TRAIN_PAT_1;
> -
> +	reg = DP | DP_LINK_TRAIN_PAT_1;
>  
>  	for (;;) {
>  		/* Use intel_dp->train_set[0] to set the voltage and pre emphasis values */
> @@ -1575,7 +1574,7 @@ cdv_intel_dp_complete_link_train(struct gma_encoder *encoder)
>  	cr_tries = 0;
>  
>  	DRM_DEBUG_KMS("\n");
> -		reg = DP | DP_LINK_TRAIN_PAT_2;
> +	reg = DP | DP_LINK_TRAIN_PAT_2;
>  
>  	for (;;) {
>  
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
