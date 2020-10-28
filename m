Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5DA29D9E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbgJ1XEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:04:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33207 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731811AbgJ1XDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:03:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id b19so385024pld.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iQWMFgTL/g1cDwMTtMSRR9uxZa2RFRhOoqtzI84yFZI=;
        b=mQOR+YBXoaFtIl3xxbHTwOuZX8YsQZLa+s8Yqa67FWU/pBT6GS8cb2Y+Zt0LFxurZl
         Ks/ETgBN/DxmBQbpkG+JCrwHVWrFNeIc8lO7OgU/2VtSitE5InNe8My4PFbYm1T/ys2l
         +oWY5o3MYovYuSNH5o9Qcd5XMEQCCtVyNsJsQrCIO6VF9aHIm465HwZuEoY8kQ27GpPp
         Mqld2piMAga9+oiViN/p6WMHj3BjbjXduWLAePH8GJwpm63FTwaEZUgmQ9eA3YKf3xXX
         QZDzyDSVfCRV5UtZ/7MlLmc2lrttTGnfa4nHuea/XzzybHy8R55kvt+RJXV76NchrE6d
         bPSw==
X-Gm-Message-State: AOAM530U+x2BNgixQ0YGaANH5zLGbNOUPo74B+WLl5GY2y7dIKU26J7j
        Bc3ag3jfYKNu6HoPRHJunolKvNnqcK8=
X-Google-Smtp-Source: ABdhPJznHoWcGJ/5HK7isQqT5Bd+ED3gs24v+mxa/4YxSlZkUySwloM1A2qzgyd5YZ6/oTRFCGMYPQ==
X-Received: by 2002:a17:902:9890:b029:d5:e447:6b32 with SMTP id s16-20020a1709029890b02900d5e4476b32mr5927231plp.51.1603869308349;
        Wed, 28 Oct 2020 00:15:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8235:3100:f389:bca1? ([2601:647:4802:9070:8235:3100:f389:bca1])
        by smtp.gmail.com with ESMTPSA id 198sm4836143pfy.41.2020.10.28.00.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 00:15:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: introduce transport layer keep-alive
To:     zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de,
        chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201027121546.1776104-1-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bbbb8d0e-22a3-0e94-9a0a-b7ce1792a1ae@grimberg.me>
Date:   Wed, 28 Oct 2020 00:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027121546.1776104-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/27/20 5:15 AM, zhenwei pi wrote:
> In the zero KATO scenario, if initiator crashes without transport
> layer disconnection, target side would never reclaim resources.
> 
> A target could start transport layer keep-alive to detect dead
> connection for the admin queue.

Not sure why we should worry about kato=0, it's really
more for debug purposes. I'd rather that we block this
option from the host altogether.

> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  2 +-
>   drivers/nvme/target/core.c      | 14 +++++++++++---
>   drivers/nvme/target/nvmet.h     |  3 ++-
>   3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index dca34489a1dc..53fbd5c193a1 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -729,7 +729,7 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
>   
>   	nvmet_stop_keep_alive_timer(req->sq->ctrl);
>   	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
> -	nvmet_start_keep_alive_timer(req->sq->ctrl);
> +	nvmet_start_keep_alive_timer(req->sq->ctrl, req);
>   
>   	nvmet_set_result(req, req->sq->ctrl->kato);
>   
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 957b39a82431..451192f7ad6a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -395,10 +395,18 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
>   	nvmet_ctrl_fatal_error(ctrl);
>   }
>   
> -void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
> +void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>   {
> -	if (unlikely(ctrl->kato == 0))
> +	if (unlikely(ctrl->kato == 0)) {
> +		if (req->ops->keep_alive)
> +			pr_info("ctrl %d starts with transport keep-alive %s\n", ctrl->cntlid,
> +				req->ops->keep_alive(req) ? "failed" : "succeed");
> +		else
> +			pr_info("ctrl %d starts without both NVMeOF and transport keep-alive",
> +				ctrl->cntlid);
> +
>   		return;
> +	}
>   
>   	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
>   		ctrl->cntlid, ctrl->kato);
> @@ -1383,7 +1391,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   	ctrl->err_counter = 0;
>   	spin_lock_init(&ctrl->error_lock);
>   
> -	nvmet_start_keep_alive_timer(ctrl);
> +	nvmet_start_keep_alive_timer(ctrl, req);
>   
>   	mutex_lock(&subsys->lock);
>   	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 559a15ccc322..de1785ce9fcd 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -305,6 +305,7 @@ struct nvmet_fabrics_ops {
>   	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
>   	void (*discovery_chg)(struct nvmet_port *port);
>   	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
> +	int (*keep_alive)(struct nvmet_req *req);
>   };
>   
>   #define NVMET_MAX_INLINE_BIOVEC	8
> @@ -395,7 +396,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req);
>   u16 nvmet_set_feat_kato(struct nvmet_req *req);
>   u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask);
>   void nvmet_execute_async_event(struct nvmet_req *req);
> -void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
> +void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
>   void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
>   
>   u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
> 
