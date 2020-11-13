Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DF32B24E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKMTqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:46:49 -0500
Received: from z5.mailgun.us ([104.130.96.5]:33716 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgKMTqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:46:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605296809; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XQR2DizaqucPQpeF3S73VOOHiAuFQxlGivhbcgxWTSo=;
 b=WeXwaIFzRU9eFqtUVYFlQF5nEGHW2Vz8yUcDEfOhKKcwAQEkDQ3d5ddwiOsswmzHgkJssJJf
 72q37v+To+A6crgP/CiLqIWZXE3J30GMI0zeZGPd5Wunim2scyhgl+rq5WOt7QEjAN03Sl8I
 R76ZGqkNnfEcaUQQlcKAQNy9bk4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5faee2a1135ce186e9fc298a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 19:46:41
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18F88C433CB; Fri, 13 Nov 2020 19:46:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57163C433C6;
        Fri, 13 Nov 2020 19:46:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 13 Nov 2020 11:46:40 -0800
From:   abhinavk@codeaurora.org
To:     Lee Jones <lee.jones@linaro.org>
Cc:     freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 35/40] drm/msm/disp/mdp5/mdp5_kms: Make local functions
 'mdp5_{en, dis}able()' static
In-Reply-To: <20201113134938.4004947-36-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-36-lee.jones@linaro.org>
Message-ID: <cf160e1968c0473501e66e163c4c6beb@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-13 05:49, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c:299:5: warning: no previous
> prototype for ‘mdp5_disable’ [-Wmissing-prototypes]
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c:319:5: warning: no previous
> prototype for ‘mdp5_enable’ [-Wmissing-prototypes]
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index b3eecf8694771..15aed45022bc8 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -296,7 +296,7 @@ static const struct mdp_kms_funcs kms_funcs = {
>  	.set_irqmask         = mdp5_set_irqmask,
>  };
> 
> -int mdp5_disable(struct mdp5_kms *mdp5_kms)
> +static int mdp5_disable(struct mdp5_kms *mdp5_kms)
>  {
>  	DBG("");
> 
> @@ -316,7 +316,7 @@ int mdp5_disable(struct mdp5_kms *mdp5_kms)
>  	return 0;
>  }
> 
> -int mdp5_enable(struct mdp5_kms *mdp5_kms)
> +static int mdp5_enable(struct mdp5_kms *mdp5_kms)
>  {
>  	DBG("");
