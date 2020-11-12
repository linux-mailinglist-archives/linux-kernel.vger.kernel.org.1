Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FED2B02BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 11:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgKLKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 05:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKLKbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:31:36 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F342C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:31:34 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so5409809wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=txrUYkO7G7WMIcGkKRsKP7lgukQE1FRd5vvgeKdhvCk=;
        b=nt0diYbVdasbGOyKUvpBrxPSa07zDp0sue9vY/DmDr8ZcreShitIl/4DBvbtGXluDM
         XfeuVVeR0uljLm86emuPNaXAHIB9eDNgFuRZOrDmh/3zzqaY22hxn1t6ycJ/3GHueSnL
         R+7h3ydM4WJmULsbEwqVmRIAOMP7iY3iyirLTwXZ2cBIBv71FxKH29tQO+vKskiS7XVk
         tHcYRd8DaglXoDs8xJ+X9V6FJDMCPiU6EZ1Q1nPAeFUm/9LBAlGdKj76/cGtuzRZHsax
         iooTB1y5revw6C439W4YE+D3H1678LTZEoUe28mxubtuOY/ToSw4qYLSeFRqGzY0taXL
         F+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=txrUYkO7G7WMIcGkKRsKP7lgukQE1FRd5vvgeKdhvCk=;
        b=Gzs+aNhunE7iXJIKhoqcU2oBLUQBHs73jKPRbZGJrXn5xM0k0Cg9vc8sPlJhCa7XDO
         8s/ddwgxkCRP1+t7YVKweNVEVzzdwXh8eqVI79zoNe5Z2ZQWzhGEloR17/7AfcLWc5By
         fDKIuAH0AU466lxBZbfMvzNFWWQF+WyLdesxvERKJVpDjNc2eiDYIt43kfH5wO7lIqTH
         0SRxViX36V1waWE/tHjASUO5QnhmxAU08oeyNOKKUgZY2YyyNyjq0Q1ILankX0N+uQ4N
         cIFmwYdlYEKcAmVwDRBhGpRklWnwAG3ol5seauew12jw8bPGsg2p/eM55+7MJkHP8mhA
         4RCg==
X-Gm-Message-State: AOAM530RUwWRxiwp7QoEqDQOfo+Med69vQOKepfE//VUfbi4+wAjvSZl
        d2pyKHgo3PtnKesKy02hV+ddZQ==
X-Google-Smtp-Source: ABdhPJwxmPB71y28TYpFNH6lpQAULkieG2QoqwkBQdYOJEaPs5BIwb3Ygxs2XMjfw/hAtY6o38hjlQ==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr8679286wrq.309.1605177092703;
        Thu, 12 Nov 2020 02:31:32 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 89sm6229664wrp.58.2020.11.12.02.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:31:32 -0800 (PST)
Date:   Thu, 12 Nov 2020 10:31:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sandeep Nair <sandeep_n@ti.com>,
        Cyril Chemparathy <cyril@ti.com>
Cc:     t-kristo@ti.com, tomi.valkeinen@ti.com, kishon@ti.com,
        dmurphy@ti.com, milo.kim@ti.com, s-anna@ti.com
Subject: Re: [PATCH 06/25] soc: ti: knav_qmss_queue: Remove set but unchecked
 variable 'ret'
Message-ID: <20201112103130.GD1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-7-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103152838.1290217-7-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc:ing a few people I know.

On Tue, 03 Nov 2020, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/soc/ti/knav_qmss_queue.c: In function ‘knav_setup_queue_pools’:
>  drivers/soc/ti/knav_qmss_queue.c:1310:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Sandeep Nair <sandeep_n@ti.com>
> Cc: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/ti/knav_qmss_queue.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Any idea who will take these TI patches?

https://lore.kernel.org/linux-arm-kernel/20201111052540.GH173948@builder.lan/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
