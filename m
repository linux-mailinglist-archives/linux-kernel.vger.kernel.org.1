Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89572F2A67
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbhALIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbhALIzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:55:37 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:54:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so1175076wmz.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3/6My/N1YrLFvQDKg+gKz1VOU4Sl62rFDPI1zr03AR0=;
        b=LDm1vYWycYft6Pq1UQdop0V2dt9egf1Bb+hDoXxwwKXmz67k+i3wXtV6hgytCieHso
         ldxW7TKOf2KymtwLZTnMdid8A+xzJJAIZxROY9sEyPbL9lKK+Bl4tg5QTRHt30wcji0n
         9+UMQjHeI4ll7QU6SqCMwmSWlwPW7uUDEnj5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3/6My/N1YrLFvQDKg+gKz1VOU4Sl62rFDPI1zr03AR0=;
        b=KHvlQ0yTTBdT+uX9VDUBwMePYgj5JizX9AFw1JqWfXCbP2Weazo1UIrkUbF2NI1FD3
         pSGcaUmoEffIQc9BpIh1pGbwM1LOC4RHFvmzVsWh02XbF0PM/0Kna5STESYSS+8J4aU1
         yIooYlSJseq52+d4aFHph+IgKd1kWHELLmnYxUkoXBrLMhwIqMt8U+K5JrU0La613xqq
         ePFfpTE9phPp3jLvYDWG5Qd9DmaoTiGJIPQ0UryagEychGL29ooqojt8y9cUO2diF8KL
         CKuwV+GLDq+fql5d+XY7ovzrTZ6t5BNo51AbROB/zq3o3F1l6l2S56c9PqkR8m90fqZv
         jgvA==
X-Gm-Message-State: AOAM530DVyB6CtmptexO/1SmSWUGCFZDsBj+4dmiUgmgtyZX8Il0k4IM
        UstTJi6Pwbr2c0wGBYy+qBXU1g==
X-Google-Smtp-Source: ABdhPJwjLMRuPAkF9U461wZdBK24OTyLSLPwahSw4uPrcB/jwHCmwl7tQSgzfp9ZXUXgPpEVMto7bQ==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr2438928wmf.59.1610441694774;
        Tue, 12 Jan 2021 00:54:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c20sm2772008wmb.38.2021.01.12.00.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:54:53 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:54:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zhaoge Zhang <zhangzhaoge@loongson.cn>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Removes invalid function return value comment
 information
Message-ID: <X/1j3Cb7KCvHD9ct@phenom.ffwll.local>
Mail-Followup-To: Zhaoge Zhang <zhangzhaoge@loongson.cn>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1610415567-32171-1-git-send-email-zhangzhaoge@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610415567-32171-1-git-send-email-zhangzhaoge@loongson.cn>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:39:27AM +0800, Zhaoge Zhang wrote:
> Signed-off-by: Zhaoge Zhang <zhangzhaoge@loongson.cn>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_file.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index b50380f..8548e8b 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -240,9 +240,6 @@ static void drm_events_release(struct drm_file *file_priv)
>   * before calling this.
>   *
>   * If NULL is passed, this is a no-op.
> - *
> - * RETURNS:
> - * 0 on success, or error code on failure.
>   */
>  void drm_file_free(struct drm_file *file)
>  {
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
