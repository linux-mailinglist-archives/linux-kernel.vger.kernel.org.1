Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFECB2AA3F1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgKGIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgKGIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:47:56 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9339C0613CF;
        Sat,  7 Nov 2020 00:47:55 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t14so3033755pgg.1;
        Sat, 07 Nov 2020 00:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZpwuF564hbZcjyk1Oa3agUsSrTimItihmfB6dOlwo0=;
        b=dNufYki4/f8inIB48XW9zbx02c1GAIXLf/NB1ZMUb20uN6nh48EVt0obJFEx0f1wXJ
         fiefojpmCv5oLzE3L79EsBU14XZqJ+R+hBlrZW5us0t7oKlxEpDk9Brw50qRyoZrsli8
         QSKxmIaCliW0kqGEUyMEV/IpOh9LIN0+kdZYZ83HFxL+Jue9U7h4k0+BId2fkRkVtvJH
         BTKqusBoNto2xEUscbF/IXHlRM5lTLmJ0fdqi56I0V9PxBxqqT0UqRNxL5iAeaQ7ffK5
         e4HgQVKEm6vZd4U75Tp+gCYaRBbC/yfkd95sxm2aMX/YOGfqDBljBc7vU+jZcOcng2TS
         8gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZpwuF564hbZcjyk1Oa3agUsSrTimItihmfB6dOlwo0=;
        b=CSLWQjbqnviD/ZiAalryg/QO5YyOIQ0OwC74RGPJ4d3fN5GizToR5aq80LVXd8YJsX
         1P144QiAfk84d8psdxWCRUG6egk4SUHS7Z0hsk2PRpKcldqpqz3Fca9oGX/68yEtwAzU
         Z/IbZMe7RAxqYaWAtBZSsk4BPi/y2pZn2sK8wNn6ny6saSGlv5gTf3jpqgO0gOl1RrfD
         tOTHhRDCPM9FB5Tf50QHXqJ00EFdn4KwytqaJpyzfXy2S9Ci5me0hQ7QQ9XnOy/0rPoD
         4vK3iLCpelGunYVahqOO1zRkqZAljkm9vAYUVhcWw5sUyObIzZatge13VH/0/vNGIBUI
         vRZA==
X-Gm-Message-State: AOAM530tv4odyeTeZvzVlfFYz79mV3wAhJF3/GLYQ+l4btr8iHuWD3/Q
        5dVRY0werPH90516YyvWu6g=
X-Google-Smtp-Source: ABdhPJyo+FW7XO57lJER/2gj1PHntYkEnSKY/kVUOVoSnSaFsTTvdxETY9+5fopyvoRYXQNw8nKKwQ==
X-Received: by 2002:a63:381:: with SMTP id 123mr5167410pgd.112.1604738875435;
        Sat, 07 Nov 2020 00:47:55 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f71sm4474710pfa.155.2020.11.07.00.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Nov 2020 00:47:54 -0800 (PST)
Date:   Sat, 7 Nov 2020 00:35:39 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v4 0/2] iommu/tegra-smmu: Two followup changes
Message-ID: <20201107083538.GA24113@Asurada-Nvidia>
References: <20200929061325.10197-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929061325.10197-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:13:23PM -0700, Nicolin Chen wrote:
> Two followup patches for tegra-smmu:
> PATCH-1 is a clean-up patch for the recently applied SWGROUP change.
> PATCH-2 fixes a potential race condition

These two changes have Acked-by and Reviewed-by for a month already.
Who can apply them?

Thanks
Nic

> Changelog
> v3->v4:
>  * PATCH-2: Fixed typo in subject
> v2->v3:
>  * PATCH-2: renamed "err_unlock" to "unlock"
> v1->v2:
>  * Separated first two changs of V1 so they may get applied first,
>    since the other three changes need some extra time to finalize.
> 
> Nicolin Chen (2):
>   iommu/tegra-smmu: Unwrap tegra_smmu_group_get
>   iommu/tegra-smmu: Expand mutex protection range
> 
>  drivers/iommu/tegra-smmu.c | 53 ++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
> 
> -- 
> 2.17.1
> 
