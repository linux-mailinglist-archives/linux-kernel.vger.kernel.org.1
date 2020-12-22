Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3F2DCEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgLQJq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgLQJq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:46:56 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED53C061285
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:46:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q16so27938209edv.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 01:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qs9G1Hna8FkBf2U6+3PXrFWB1lYrYKjRbwLmbEVDCSA=;
        b=N3vnIoF+/gaqAFgniw8NeEhMQDYOrBskumgwQ3O8y03aarMUdEz0RbfezB7KPfb2Nb
         ORN1bAqwLGanHEXDeORKayuExhSAcVPyhxEFGJiRLr1hIUmQsZUYHGXWl2VTt2fDUTj2
         Dp0BSJggXRG7zQrCXC+Gh1zl8COmTYJdGt37CC/04j00HL4T/eK3wy0PmMs/7Vevw+w2
         q10EgBFo6oihBZBbNbbD9/ynB9Clt1dn1Pe0VN35GBRkgfE9ZGzWccOWy0SbF1gzHMNx
         iFm+T7xBg4ci8Utf39+lMzZJ/kdZzu+UF3jE01UGlgcnWL+wIySdoUd4a4HK9ACeJsl2
         saAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qs9G1Hna8FkBf2U6+3PXrFWB1lYrYKjRbwLmbEVDCSA=;
        b=rACfbdjPtCDyebK/YUjcv9lQ1jj9hXRUw+MCv/SfSGvHq/sqcEZZAlWaeV8ng66nVn
         MA5l7qGW8PVZ4a6yqO4RnNC23pVGQmRotxkDX1X+RzKeqrPGZXz5n4kkWV6sQ0U+DsQB
         MwR0f3rmnpSzOaXRIYKoGSjyo0NXdI5qaixv22XfPmWPpkPJBbv2edyqSQdtP7nbX3BY
         rdRujDefkBHbBhy7eiDhD1opSGOYaw8WJqGVKVyQ3G6QDMUdLfUk0lGCbgpCS/VnDR1J
         EIh/6k56oJLYCr+fy+TvTPvOo+IR5wBQE5GKMyARRPYjdVUeoSDTB06fP4Pr+lCJcVWg
         Qn3w==
X-Gm-Message-State: AOAM532pt8xEth2J76FzWo/CvL4GnCF68Co273yHmwQsQw0KBXO8bl1M
        AUi/k/Cqwo6jJ4A+aIzgMOhSpwqJeNreG7mt
X-Google-Smtp-Source: ABdhPJw+on5FbfMy9nXFFZmJV9Ud1VPuIkst7xacktXlp2wyTjB1+tQ7ayGqXSLZcGPk5aJRrF7ShQ==
X-Received: by 2002:a05:6402:13d1:: with SMTP id a17mr37073638edx.202.1608198374469;
        Thu, 17 Dec 2020 01:46:14 -0800 (PST)
Received: from [192.168.0.3] (hst-221-81.medicom.bg. [84.238.221.81])
        by smtp.googlemail.com with ESMTPSA id o13sm22683887edr.94.2020.12.17.01.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 01:46:13 -0800 (PST)
Subject: Re: [PATCH] media: venus: preserve DRC state across seeks
To:     Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201202053424.3286774-1-acourbot@chromium.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <02c8623d-66b6-b4d3-8bb2-43dc78c3d5d6@linaro.org>
Date:   Thu, 17 Dec 2020 11:46:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202053424.3286774-1-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,


On 12/2/20 7:34 AM, Alexandre Courbot wrote:
> DRC events can happen virtually at anytime, including when we are
> starting a seek. Should this happen, we must make sure to return to the
> DRC state, otherwise the firmware will expect buffers of the new
> resolution whereas userspace will still work with the old one.
> 
> Returning to the DRC state upon resume for seeking makes sure that the
> client will get the DRC event and will reallocate the buffers to fit the
> firmware's expectations.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 8488411204c3..e3d0df7fd765 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -972,7 +972,10 @@ static int vdec_start_output(struct venus_inst *inst)
>  
>  	if (inst->codec_state == VENUS_DEC_STATE_SEEK) {
>  		ret = venus_helper_process_initial_out_bufs(inst);
> -		inst->codec_state = VENUS_DEC_STATE_DECODING;
> +		if (inst->next_buf_last)
> +			inst->codec_state = VENUS_DEC_STATE_DRC;
> +		else
> +			inst->codec_state = VENUS_DEC_STATE_DECODING;
>  		goto done;
>  	}
>  
> @@ -1077,8 +1080,10 @@ static int vdec_stop_capture(struct venus_inst *inst)
>  		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
>  		fallthrough;
>  	case VENUS_DEC_STATE_DRAIN:
> -		vdec_cancel_dst_buffers(inst);
>  		inst->codec_state = VENUS_DEC_STATE_STOPPED;
> +		fallthrough;
> +	case VENUS_DEC_STATE_SEEK:
> +		vdec_cancel_dst_buffers(inst);
>  		break;
>  	case VENUS_DEC_STATE_DRC:
>  		WARN_ON(1);
> @@ -1102,6 +1107,7 @@ static int vdec_stop_output(struct venus_inst *inst)
>  	case VENUS_DEC_STATE_DECODING:
>  	case VENUS_DEC_STATE_DRAIN:
>  	case VENUS_DEC_STATE_STOPPED:
> +	case VENUS_DEC_STATE_DRC:
>  		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
>  		inst->codec_state = VENUS_DEC_STATE_SEEK;
>  		break;
> @@ -1371,6 +1377,7 @@ static void vdec_event_change(struct venus_inst *inst,
>  			dev_dbg(dev, VDBGH "flush output error %d\n", ret);
>  	}
>  
> +	inst->next_buf_last = true;

Setting next_buf_last unconditionally makes me think can we reuse
inst->reconfig instead?

>  	inst->reconfig = true;
>  	v4l2_event_queue_fh(&inst->fh, &ev);
>  	wake_up(&inst->reconf_wait);
> 

-- 
regards,
Stan
