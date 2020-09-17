Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3842F26D0E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIQByD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQByB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:54:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58804C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:54:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so219852pfk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dgnODGIAWL13nIbhEz3ezEHyZ73l+QamiC/feoln9pA=;
        b=kKCLvI754VQRS48l6o9prlDOUU+078HIdKfltH5m2ufXjuitexI7+27BaPPbM7YOID
         U4w8RnHLvpLY6DPhDtH3pQ47Rn2QsEssszplv8yr+YnXJ+rGa7Z5m2m57TcVX7Ak+Oy1
         HsAT+RyItKoLxTRjYInlcUVR46IQszNC9caKIBbvexWbuSURvAc4MRb7ULAPtnXFWxEl
         0SKF+LI7ZsEnX+o8uZzG1pKsT4P50TqHlS4lKHl8Qt/9CH5Q6Y7YqZxoZAf/k5zH6tAb
         TUp/JF4nyi97FbyqS/39j2QdLJ2Vz7Ueo6qTZqvhHjxpgIPFFbbJpThvMPx6urXE0CfF
         SDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dgnODGIAWL13nIbhEz3ezEHyZ73l+QamiC/feoln9pA=;
        b=FbszOuHrGejRjR7MlIg5GmTzpZEQwMA4BzcvqDHEzdTqOSoFWhslihD9omm948s7jU
         rnPJUtnE3b8mJU85/Ed0M1MoMWzorYyXwCDOYs2syIzr+WCk9U4QUhzi9wy3oX4K7Bzn
         4KEysJSnlHrsogPsLuJQ+iY2LZ/vRRbzF1MynXHHx5bd9UYmNmoMAqcrYbpymCYLbVw/
         mzvJRBNkMwE0+6z2FL4hY277fuGgHRkF2ruklQbfzJETI/KATKiUJ1BExVe+gGv3hX0L
         ERBOCTZ2LHrl2Rc+WzA8r8a0zEkxEphDlQQxS3WW8ojJRY5rDSs+87OW4vgqKK17tRYh
         jx+Q==
X-Gm-Message-State: AOAM532xP53y8W7MWnwBlbFVB6znDnm0YxzIlB+UrcczlRoONEXNoA78
        LbnIKernMY2a6A/1QT4X5Mhru0hlZ0Q=
X-Google-Smtp-Source: ABdhPJxnNOKTfJ7qLfSj/RIBwWtTsFveH5xnCH12xhYaBkeSNyJehUmbC9p4FCNpFJCk1tW0zIOOLg==
X-Received: by 2002:aa7:9635:0:b029:142:2501:3980 with SMTP id r21-20020aa796350000b029014225013980mr9025261pfg.69.1600307640882;
        Wed, 16 Sep 2020 18:54:00 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id gd14sm4050934pjb.0.2020.09.16.18.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 18:54:00 -0700 (PDT)
Date:   Wed, 16 Sep 2020 18:50:49 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: Set MCLK input or output direction
Message-ID: <20200917015048.GD22566@Asurada-Nvidia>
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <1600251387-1863-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600251387-1863-4-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:16:27PM +0800, Shengjiu Wang wrote:
> SAI support select MCLK direction with version.major > 3
> and version.minor > 1, the default direction is input,
> set it to be output according to DT property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 738b4dda7847..5117c1cd5682 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1117,6 +1117,13 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		dev_warn(&pdev->dev, "Error reading SAI version: %d\n", ret);
>  
> +	/* Select MCLK direction */
> +	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
> +	    sai->verid.major >= 3 && sai->verid.minor >= 1) {
> +		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
> +				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
> +	}
> +
>  	pm_runtime_enable(&pdev->dev);
>  	regcache_cache_only(sai->regmap, true);
>  
> -- 
> 2.27.0
> 
