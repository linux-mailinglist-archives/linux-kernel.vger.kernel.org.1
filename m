Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFD72A2704
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgKBJ3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:29:13 -0500
Received: from foss.arm.com ([217.140.110.172]:56568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgKBJ3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:29:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C476101E;
        Mon,  2 Nov 2020 01:29:12 -0800 (PST)
Received: from [192.168.1.79] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AC263F718;
        Mon,  2 Nov 2020 01:29:10 -0800 (PST)
Subject: Re: [PATCH -next] drm/panfrost: Fix unused variable warning
To:     Zou Wei <zou_wei@huawei.com>, robh@kernel.org,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1604309599-10078-1-git-send-email-zou_wei@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <8729ad8d-31db-c7cd-e962-a0f7db6891b3@arm.com>
Date:   Mon, 2 Nov 2020 09:29:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604309599-10078-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2020 09:33, Zou Wei wrote:
> Fixes the following W=1 kernel build warning:
> 
> ./panfrost_job.c:617:28: warning: unused variable ‘js’ [-Wunused-variable]
>    struct panfrost_job_slot *js = pfdev->js;
>                              ^~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Boris posted an identical patch earlier:

https://lore.kernel.org/r/20201101173817.831769-1-boris.brezillon%40collabora.com

Steve

> ---
>   drivers/gpu/drm/panfrost/panfrost_job.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 4902bc6..e75b7d2 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -613,8 +613,6 @@ int panfrost_job_open(struct panfrost_file_priv *panfrost_priv)
>   
>   void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
>   {
> -	struct panfrost_device *pfdev = panfrost_priv->pfdev;
> -	struct panfrost_job_slot *js = pfdev->js;
>   	int i;
>   
>   	for (i = 0; i < NUM_JOB_SLOTS; i++)
> 

