Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C208A1A4DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 05:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDKDpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 23:45:07 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:40692 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726659AbgDKDpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 23:45:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1D1A1182CCCD0;
        Sat, 11 Apr 2020 03:45:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:4321:5007:6737:10004:10400:10848:11026:11232:11657:11658:11914:12043:12048:12296:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21433:21451:21627:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: talk45_669e7c599bf44
X-Filterd-Recvd-Size: 2138
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 03:45:05 +0000 (UTC)
Message-ID: <78e966cacffbab8c43be6a02aa3f5af2478917d0.camel@perches.com>
Subject: Re: [PATCH] drm/hisilicon: Code refactoring for hibmc_drv_vdac
From:   Joe Perches <joe@perches.com>
To:     Tian Tao <tiantao6@hisilicon.com>, puck.chen@hisilicon.com,
        airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        kraxel@redhat.com, alexander.deucher@amd.com, tglx@linutronix.de,
        dri-devel@lists.freedesktop.org, xinliang.liu@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com
Date:   Fri, 10 Apr 2020 20:43:02 -0700
In-Reply-To: <1586573387-42003-1-git-send-email-tiantao6@hisilicon.com>
References: <1586573387-42003-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-11 at 10:49 +0800, Tian Tao wrote:
> code refactoring for hibmc_drv_vdac.c, no actual function changes.

Seems sensible.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
[]
> @@ -109,13 +83,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  	struct drm_connector *connector;
>  	int ret;
>  
> -	connector = hibmc_connector_init(priv);
> -	if (IS_ERR(connector)) {
> -		DRM_ERROR("failed to create connector: %ld\n",
> -			  PTR_ERR(connector));
> -		return PTR_ERR(connector);
> -	}
> -
>  	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
>  	if (!encoder) {
>  		DRM_ERROR("failed to alloc memory when init encoder\n");

The alloc error messages could be removed.

> @@ -131,6 +98,21 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>  	}
>  
>  	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
> +
> +	connector = devm_kzalloc(dev->dev, sizeof(*connector), GFP_KERNEL);
> +	if (!connector) {
> +		DRM_ERROR("failed to alloc memory when init connector\n");

and here.


