Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4062AB4CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgKIK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:26:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:52342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKIK0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:26:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F072AAF39;
        Mon,  9 Nov 2020 10:26:17 +0000 (UTC)
Subject: Re: [PATCH] drm/ast: Create chip AST2600
To:     KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        jenmin_yuan@aspeedtech.com, arc_sung@aspeedtech.com,
        tommy_huang@aspeedtech.com
References: <20201109093812.161483-1-kuohsiang_chou@aspeedtech.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <fd2cdee4-3eb3-facd-5398-56d74fa7cf14@suse.de>
Date:   Mon, 9 Nov 2020 11:26:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109093812.161483-1-kuohsiang_chou@aspeedtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 09.11.20 um 10:38 schrieb KuoHsiang Chou:
> [New] Support AST2600

A style issue: better write a nice sentence than these tags.  For the
patch at hand, I'd preferred something like: "Only add an id for
supporting AST2600. No functional changes are required."

I assume that there areno further changes required for AST2600.

> 
> Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I'll add the patch to drm-misc-next. Thanks!

Best regards
Thomas

> ---
>  drivers/gpu/drm/ast/ast_drv.h  | 1 +
>  drivers/gpu/drm/ast/ast_main.c | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index 467049ca8430..6b9e3b94a712 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -63,6 +63,7 @@ enum ast_chip {
>  	AST2300,
>  	AST2400,
>  	AST2500,
> +	AST2600,
>  };
> 
>  enum ast_tx_chip {
> diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
> index 77066bca8793..4ec6884f6c65 100644
> --- a/drivers/gpu/drm/ast/ast_main.c
> +++ b/drivers/gpu/drm/ast/ast_main.c
> @@ -143,7 +143,10 @@ static int ast_detect_chip(struct drm_device *dev, bool *need_post)
>  	ast_detect_config_mode(dev, &scu_rev);
> 
>  	/* Identify chipset */
> -	if (dev->pdev->revision >= 0x40) {
> +	if (dev->pdev->revision >= 0x50) {
> +		ast->chip = AST2600;
> +		drm_info(dev, "AST 2600 detected\n");
> +	} else if (dev->pdev->revision >= 0x40) {
>  		ast->chip = AST2500;
>  		drm_info(dev, "AST 2500 detected\n");
>  	} else if (dev->pdev->revision >= 0x30) {
> --
> 2.18.4
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
