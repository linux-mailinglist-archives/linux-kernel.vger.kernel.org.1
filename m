Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3528D665
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 00:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbgJMWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 18:18:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43151 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJMWSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 18:18:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id a200so689756pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5J+JqftU6ifZN1KxMsrqREjbvuZkrZjLOw71HrhLGPI=;
        b=CTacjOSb9bkvs0hqs3ZwUO0XVjc4TDMszXB3UovmA+4cVeqE3q911nFgcuYQMmKogx
         FuMaAn9ukSVni1I+Ki9PUEfNrOUSqCfnijHyzY8j+3sI9CKaw+47QhLuL2zS7xZopeSm
         R088etjlDO+LfG0dUZy1lqsgRx57mHSI+zeK7KpZ1iuRr4e0uW110RO+JbGMbOiXjD/B
         0bvW819N7EXqObv5LAspTnFaIYwRh6uUSyr/Zhezqq19kjED85ObN+wMt2yUJpFubiRk
         mU6bGjyXhleVJ7GeBrFk+J9u+09S2/pI19aEquTpYg8QyYFuZZADQxuNC9otqSL9ului
         PcDQ==
X-Gm-Message-State: AOAM531MaUsWpBwFgRDNnBmK4SpErdZRNbHyazDpxpInIgpp6rwvEVzA
        iHTa3CYTJGXUIvBbnDwNsjXl/ErBBOg=
X-Google-Smtp-Source: ABdhPJyjCBM/sNIokxxhfFLnmFg5c8GYQ3dccLlv3pIx6CMJOE3U7NqVRRJ//ztXhobI6kFL/uEbqA==
X-Received: by 2002:a63:4854:: with SMTP id x20mr1420189pgk.220.1602627534298;
        Tue, 13 Oct 2020 15:18:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0? ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
        by smtp.gmail.com with ESMTPSA id o78sm693871pfd.105.2020.10.13.15.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 15:18:52 -0700 (PDT)
Subject: Re: [PATCH] nvmet: fix uninitialized work for zero kato
To:     zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de,
        chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201013035233.923889-1-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a75e067a-d0ea-8402-b883-cedd36bb7cf7@grimberg.me>
Date:   Tue, 13 Oct 2020 15:18:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201013035233.923889-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hit a warning:
> WARNING: CPU: 1 PID: 241 at kernel/workqueue.c:1627 __queue_delayed_work+0x6d/0x90
> with trace:
>    mod_delayed_work_on+0x59/0x90
>    nvmet_update_cc+0xee/0x100 [nvmet]
>    nvmet_execute_prop_set+0x72/0x80 [nvmet]
>    nvmet_tcp_try_recv_pdu+0x2f7/0x770 [nvmet_tcp]
>    nvmet_tcp_io_work+0x63f/0xb2d [nvmet_tcp]
>    ...
> 
> This could be reproduced easily with a keep alive time 0:
> nvme connect -t tcp -n NQN -a ADDR -s PORT --keep-alive-tmo=0
> 
> The reason is:
> Starting an uninitialized work when initiator connects with zero
> kato. Althrough keep-alive timer is disabled during allocating a ctrl
> (fix in 0d3b6a8d213a), ka_work still has a chance to run
> (called by nvmet_start_ctrl to detect dead host).

This should have a "Fixes:" tag.

> 
> Initilize ka_work during allocating ctrl, and set a reasonable kato
> before scheduling ka_work.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/target/core.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index b7b63330b5ef..3c5b2b065476 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -19,6 +19,8 @@ struct workqueue_struct *buffered_io_wq;
>   static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>   static DEFINE_IDA(cntlid_ida);
>   
> +#define NVMET_DEFAULT_KATO	5
> +
>   /*
>    * This read/write semaphore is used to synchronize access to configuration
>    * information on a target system that will result in discovery log page
> @@ -385,6 +387,11 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
>   	if (cmd_seen) {
>   		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
>   			ctrl->cntlid);
> +
> +		/* run once, trigger from nvmet_start_ctrl to detect dead link */
> +		if (!ctrl->kato)
> +			return;
> +
>   		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);

It will be better to just schedule/mod the ka_work if kato != 0, other
changes in the patch aren't needed IMO.

>   		return;
>   	}
> @@ -403,15 +410,11 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
>   	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
>   		ctrl->cntlid, ctrl->kato);
>   
> -	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>   	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>   }
>   
>   static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
>   {
> -	if (unlikely(ctrl->kato == 0))
> -		return;
> -
>   	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
>   
>   	cancel_delayed_work_sync(&ctrl->ka_work);
> @@ -1107,6 +1110,8 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>   
>   static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   {
> +	u32 kato = ctrl->kato ? ctrl->kato : NVMET_DEFAULT_KATO;
> +

The controller shouldn't have a default value, it should receive
the desired value from the host.

>   	lockdep_assert_held(&ctrl->lock);
>   
>   	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
> @@ -1126,7 +1131,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   	 * in case a host died before it enabled the controller.  Hence, simply
>   	 * reset the keep alive timer when the controller is enabled.
>   	 */
> -	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
> +	mod_delayed_work(system_wq, &ctrl->ka_work, kato * HZ);
>   }
>   
>   static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
> @@ -1378,6 +1383,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>   
>   	/* keep-alive timeout in seconds */
>   	ctrl->kato = DIV_ROUND_UP(kato, 1000);
> +	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>   
>   	ctrl->err_counter = 0;
>   	spin_lock_init(&ctrl->error_lock);
> 
