Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01E92A4AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKCQMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:12:30 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7938C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:12:30 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id r10so14023047pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 08:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l1ro1Lxvrl7gs3AZydmjoaVsX0+iaNCcctscSnkcqnc=;
        b=M4I1V0JI8M9T9QZVAfPJ0Hya0JkBihCise1QUaNdIOipsmhywpCxPXK7Sk74GW/ICG
         dZVv0zCOTYnRn52uJLM8/OvNVou7mqHV0H9AFUWc8rmmgVrKRpSdRJNzQDiT16KR7FgT
         ny2EmeXN6anD+FvA8gzt0Dfv7U88Ggve+mFNSG3TTrmVedaTmdJOcX2e0Teh3x0j/Y7h
         dPuMZRYsGNPqXlbeddCop6E2wEu16hx8xa9K9c8HMNvBaybIfSuqFi9K84T+YjdIy6bO
         HHyfbeGEGaC6K0sAgSRf0RpcW+cL+lsHlFtwGYeu5wWALB7aPEYOTyY8F3ftgiu+mUnM
         R4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l1ro1Lxvrl7gs3AZydmjoaVsX0+iaNCcctscSnkcqnc=;
        b=cQQWi0WnAHMlWlFcZ/zHWEZENrdRD9yf6miK06LpVhnVA7bOeLmk7UEVAbDNoM7mY+
         NpvhQYrSijgQJB11Ub+4A/bwm2+ZTVCoBNV1miokb3RyNDM/x6dTytGhSvUZcrW3nS0M
         S33mElU/FnYj9X1bSo9xoQvM4ot6+hYzmVkj1Cz1k5QR3m0qxomZiUeOwZR9uwlA1ixB
         LDJ6McAXoTrCRDlqFwGovjkZOm3x3iEImcyZi1SSl9RiYc5uRsfSlNQl4N2Pq4uBu+Ss
         WBc3aALFFMrTV1KqI1gN91O/RUFKrsA7itBriKmr0pPlUIj9wnSxj3nx2quUsHGyFsUK
         KM/w==
X-Gm-Message-State: AOAM531nCL4xLnsYR9UKdQIKijngF0g90PYECPOuZYrJ20P+qAyK2Vr9
        79S47MTB+rAxQkECXNJs2GBmtw==
X-Google-Smtp-Source: ABdhPJxvfv94PiWJ+DS1wTXAsJ/iZiU4YCpLmiB2EsmcJKEnuF6SZNX3Q5X9Kpc+cNmSARsc9GwQZg==
X-Received: by 2002:a63:fb4a:: with SMTP id w10mr17269993pgj.285.1604419950333;
        Tue, 03 Nov 2020 08:12:30 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y23sm3912228pju.35.2020.11.03.08.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:12:29 -0800 (PST)
Date:   Tue, 3 Nov 2020 09:12:27 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
Subject: Re: [PATCH] coresight: Remove unnecessary THIS_MODULE of funnel and
 replicator driver
Message-ID: <20201103161227.GA2852321@xps15>
References: <1604409708-12400-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604409708-12400-1-git-send-email-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:21:48PM +0800, Qi Liu wrote:
> As THIS_MODULE has been set in platform_driver_register(), so remove it
> from static funnel driver and static replicator driver to avoid set it
> twice.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-funnel.c     | 2 +-
>  drivers/hwtracing/coresight/coresight-replicator.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index af40814..39be46b 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -356,7 +356,7 @@ static struct platform_driver static_funnel_driver = {
>  	.remove          = static_funnel_remove,
>  	.driver         = {
>  		.name   = "coresight-static-funnel",
> -		.owner	= THIS_MODULE,
> +		/* THIS_MODULE is taken care of by platform_driver_register() */
>  		.of_match_table = static_funnel_match,
>  		.acpi_match_table = ACPI_PTR(static_funnel_ids),
>  		.pm	= &funnel_dev_pm_ops,
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 62afdde..6772f23 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -374,7 +374,7 @@ static struct platform_driver static_replicator_driver = {
>  	.remove         = static_replicator_remove,
>  	.driver         = {
>  		.name   = "coresight-static-replicator",
> -		.owner	= THIS_MODULE,
> +		/* THIS_MODULE is taken care of by platform_driver_register() */

I have applied your patch.  Next time please version you revisions.

Thanks,
Mathieu

>  		.of_match_table = of_match_ptr(static_replicator_match),
>  		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
>  		.pm	= &replicator_dev_pm_ops,
> --
> 2.8.1
> 
