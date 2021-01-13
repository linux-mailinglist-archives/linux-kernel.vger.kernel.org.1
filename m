Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748882F4EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbhAMPiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:38:21 -0500
Received: from foss.arm.com ([217.140.110.172]:38248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbhAMPiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:38:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA071FB;
        Wed, 13 Jan 2021 07:37:34 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3C8B3F66E;
        Wed, 13 Jan 2021 07:37:33 -0800 (PST)
Subject: Re: [PATCH] drm/panfrost: Use delayed timer as default in devfreq
 profile
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     robh@kernel.org, tomeu.vizoso@collabora.com,
        alyssa.rosenzweig@collabora.com
References: <20210105164111.30122-1-lukasz.luba@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <5a52797c-eb03-3dcc-932f-14a08828799e@arm.com>
Date:   Wed, 13 Jan 2021 15:35:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210105164111.30122-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2021 16:41, Lukasz Luba wrote:
> Devfreq framework supports 2 modes for monitoring devices.
> Use delayed timer as default instead of deferrable timer
> in order to monitor the GPU status regardless of CPU idle.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Looks reasonable to me.

Reviewed-by: Steven Price <steven.price@arm.com>

I'll apply to drm-misc-next.

> ---
> Hi all,
> 
> This is just a simple change but has impact on reliable polling mode
> with guaranteed sampling rate. The devfreq framework has 2 modes for
> checking the device status which updates the statistics. When the
> default mode is used (deferred work) it could happen that the
> framework won't check the device, if the CPU which was running devfreq
> code went idle. In deferred mode, the deferred timer is not fired,
> thus framework won't check the device status.
> 
> The log below is taken when glxgears was running. It can be seen that
> periodic checks are missing (should be every 50ms).
> 
> ----------------------------------------------------------------------
> 
> [  128.046555] panfrost ff9a0000.gpu: busy 18029406 total 67940380 26 % freq 200 MHz
> [  128.110538] panfrost ff9a0000.gpu: busy 7975930 total 63980997 12 % freq 200 MHz
> [  128.210606] panfrost ff9a0000.gpu: busy 21148792 total 100074440 21 % freq 200 MHz
> [  128.594638] panfrost ff9a0000.gpu: busy 53739467 total 384032219 13 % freq 200 MHz
> [  129.178749] panfrost ff9a0000.gpu: busy 89206245 total 584111500 15 % freq 200 MHz
> [  129.294601] panfrost ff9a0000.gpu: busy 16446118 total 115852915 14 % freq 200 MHz
> [  129.762616] panfrost ff9a0000.gpu: busy 71481587 total 468015722 15 % freq 200 MHz
> [  129.874762] panfrost ff9a0000.gpu: busy 15614112 total 112139938 13 % freq 200 MHz
> [  130.026585] panfrost ff9a0000.gpu: busy 21397620 total 151821546 14 % freq 200 MHz
> [  130.110536] panfrost ff9a0000.gpu: busy 21429365 total 83952016 25 % freq 200 MHz
> [  130.178524] panfrost ff9a0000.gpu: busy 16458197 total 67989072 24 % freq 200 MHz
> [  130.246528] panfrost ff9a0000.gpu: busy 9876225 total 68004030 14 % freq 200 MHz
> [  130.310529] panfrost ff9a0000.gpu: busy 9211725 total 64000524 14 % freq 200 MHz
> [  130.410528] panfrost ff9a0000.gpu: busy 21780828 total 99999250 21 % freq 200 MHz
> 
> ----------------------------------------------------------------------
> 
> It has impact on devfreq cooling and thermal governor. They rely on these
> statistics, but sometimes the data is stale.
> 
> This patch switches to more reliable devfreq mode, which uses delayed work.
> 
> Regards,
> Lukasz
> 
> 
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index f44d28fad085..56b3f5935703 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -76,6 +76,7 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
>   }
>   
>   static struct devfreq_dev_profile panfrost_devfreq_profile = {
> +	.timer = DEVFREQ_TIMER_DELAYED,
>   	.polling_ms = 50, /* ~3 frames */
>   	.target = panfrost_devfreq_target,
>   	.get_dev_status = panfrost_devfreq_get_dev_status,
> 

