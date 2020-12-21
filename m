Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4372E025C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 23:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgLUWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 17:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLUWMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 17:12:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 14:11:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r5so11017644eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kNGqROiacfcmcUXowv+ZZ8ynNfZ1+ApYSqleLuaCMpw=;
        b=YSofHheEMuxcvORf+W/Jxb1Lod8YHz02lgj/4BBiBuK5NgWJAYyc3+p34IM7vfLp/E
         qQBOyLJAkrwBZizYBfJEFToRp1v9s2u7QG7cIFUWRn0xLPAEfFYiCwNaE2wTJ0r3WVH7
         0G74he4noi7SBD947yCdpwHm89rnmy871XOvmT2pBN0K2meiOM/vW+Br70CD3vsWJtn1
         BeUjO+5HsrmoZ709IfwONT4YC/Nur/r17j5cUoKQkpodIJxnDy7vuwBMiefCoBgBRLK5
         UK2PA/k245Iz1553QjfDzd+2yBQgIBih4ZhXzMMc3vVcOe8kW4UkumWhP3A+EiwdaJiN
         ylEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kNGqROiacfcmcUXowv+ZZ8ynNfZ1+ApYSqleLuaCMpw=;
        b=fS49W9DfTpS+fSjHm4M5Dbh8Xw1pbS4bly7jCHQqvBRO0CKuE6KwEn3Xd1Z0kSeJ72
         pRyFO0PUOrFrrnnbmHSM88iHVXZhYAS7+gpwrYstqZ1BlVux8iKD8AY2O/ShWrgyUDSu
         JYEU2W2TCnaGx/zPme+onB4ytOX3tIABVURy+Hu9Z4nfFTQat/g8vJsuG6ZnOd3vQEJo
         uIzVeGhOP+gfuiBZB4NKmRoIdGyTRpCV42It9aHu9H0hRTSaI6ZVwEV4y+IpgMXV3/76
         PEjqeH9IuY3cuh688zJA3W5Y8avF58LMbPHkyBqS0f0Ou7OpJC06n5DwkwC6ncEDUnQP
         CRBg==
X-Gm-Message-State: AOAM531Y1hek7PgKjIMEPNqHCEikCtg5bKzEBZ93DMkroRufEYCEASYA
        DpOx71Q38rPrd0SiseToFXkqmQ==
X-Google-Smtp-Source: ABdhPJwoqxhhE4HMXehMSz/tbVtbcPVNbmvTTLjFChvxwTaxvvgkaT3/qsPbS+pnxOys0lWXvwOWtQ==
X-Received: by 2002:a50:bb44:: with SMTP id y62mr17753680ede.103.1608588691072;
        Mon, 21 Dec 2020 14:11:31 -0800 (PST)
Received: from [192.168.0.4] (hst-221-116.medicom.bg. [84.238.221.116])
        by smtp.googlemail.com with ESMTPSA id k21sm30267696edq.26.2020.12.21.14.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 14:11:30 -0800 (PST)
Subject: Re: [PATCH v2] venus: venc: set inband mode property to FW.
To:     Dikshita Agarwal <dikshita@codeaurora.org>,
        linux-media@vger.kernel.org, stanimir.varbanov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1608101388-31810-1-git-send-email-dikshita@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <09c794e2-24a8-f545-dac4-39d425a1ddd3@linaro.org>
Date:   Tue, 22 Dec 2020 00:11:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1608101388-31810-1-git-send-email-dikshita@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/20 8:49 AM, Dikshita Agarwal wrote:
> set HFI_PROPERTY_CONFIG_VENC_SYNC_FRAME_SEQUENCE_HEADER to FW
> to support inband sequence header mode.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> 
> Changes since v1:
> - added codec check 
> - fixed the mask while initializing the control
> 
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index cf860e6..a94f5fd 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -157,7 +157,17 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>  		ctr->h264_loop_filter_mode = ctrl->val;
>  		break;
>  	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:
> -		ctr->header_mode = ctrl->val;
> +		if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_H264 ||
> +		    inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
> +			if (ctrl->val == V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE)
> +				en.enable = 0;
> +			else
> +				en.enable = 1;
> +			ptype = HFI_PROPERTY_CONFIG_VENC_SYNC_FRAME_SEQUENCE_HEADER;
> +			ret = hfi_session_set_property(inst, ptype, &en);
> +			if (ret)
> +				return ret;
> +		}

I see NULL pointer dereference in this code snippet.  Please take as
reference the implementation of V4L2_CID_MPEG_VIDEO_BITRATE from the
same function (venc_op_s_ctrl).

>  		break;
>  	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:
>  		break;
> @@ -289,7 +299,8 @@ int venc_ctrl_init(struct venus_inst *inst)
>  	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
>  		V4L2_CID_MPEG_VIDEO_HEADER_MODE,
>  		V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
> -		1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
> +		~((1 << V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) |
> +		(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME)),
>  		V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE);
>  
>  	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
> 

-- 
regards,
Stan
