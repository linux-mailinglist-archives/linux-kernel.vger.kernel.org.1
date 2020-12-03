Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6782CE1F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgLCWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgLCWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:40:29 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570BDC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:39:49 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id o9so2300353pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qtj77dS9cHDPtLOQV8kRZMJrnqowkKFbs0Ao69ze8yo=;
        b=p1gwki3oOUo+P7PEOXQvu0gEWvu282wplUNpim3bRudNhLVadPVjh3Nx0CBqu2B2si
         2tH9peMetiV8ZLFoBtSCyttjOzm46Xp/iC8USe1djX4MQr7Dnb5fAKiuRvzC829CKSYf
         vZvcGqDgtR4MeHvDKqhfVjCsRNSHd33LVwpqdNceX/miA/4I/MPUDdCxbDWoRMBSfCiv
         ZLxzMWwOunAjPVyEudrVou3xwAcj4ypDZFOVMqQ/pSaLUmyYH3L5ej5MKHVreGIMiRNy
         LE6PYmlZKKud/KnvpcHekr/20xf9NQshmEvEL8ZJuip+Xhm6YHgc1hnkv1AjVnHBpOoq
         8qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qtj77dS9cHDPtLOQV8kRZMJrnqowkKFbs0Ao69ze8yo=;
        b=UFwkTUVhEAvWMn4XQqiQ5GILYIjI+h+p1Q8dX0B5DOwhavq6308Na30HydCVF9Nf8I
         /YYiQmX4VOYer4LRuAC/hITA6VKpFJH+LhJZPNglNO30hsm35RvosTZd3wEvdD94jcbw
         ecE6QEJvq1ZDWmLgUDC3+4Fd0ILO8X+nU3/mbcCijDnnoX8JFguiOMdRsCbFrd8mX+/T
         YQKLIk6IPbP8iPV1AIvU5PfDuwofQtCmafzod6UVV5c9LAn3WlUb6NqLybC7UYDeU4td
         9BA5PAY2PRv+nqsNb8XZe8+jQH1QFu6xkSPRSab/crI2a1MWMV1u3YoSih1PDA9wAVog
         6d9w==
X-Gm-Message-State: AOAM530fkcewWFv08D7lDoV8ZI4y4/QuR28D6UMWyj9q6i6qMYbJE0bD
        KyrnulPhjVpsHJwdsy6WCUg=
X-Google-Smtp-Source: ABdhPJyRSHJAid1qLYHP9zDmtf4HjETwpYJVHYSQGmjoPkUfJgaFvmQ4jNjlnjBiGOtzRniTkZ8HUA==
X-Received: by 2002:a63:4623:: with SMTP id t35mr4888350pga.270.1607035188896;
        Thu, 03 Dec 2020 14:39:48 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u3sm2817244pfu.47.2020.12.03.14.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Dec 2020 14:39:48 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:36:55 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_aud2htx: mark PM functions as __maybe_unused
Message-ID: <20201203223654.GA10130@Asurada-Nvidia>
References: <20201203222900.1042578-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203222900.1042578-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:28:47PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_PM is disabled, we get a warning for unused functions:
> 
> sound/soc/fsl/fsl_aud2htx.c:261:12: error: unused function 'fsl_aud2htx_runtime_suspend' [-Werror,-Wunused-function]
> static int fsl_aud2htx_runtime_suspend(struct device *dev)
> sound/soc/fsl/fsl_aud2htx.c:271:12: error: unused function 'fsl_aud2htx_runtime_resume' [-Werror,-Wunused-function]
> static int fsl_aud2htx_runtime_resume(struct device *dev)
> 
> Mark these as __maybe_unused to avoid the warning without adding
> an #ifdef.
> 
> Fixes: 8a24c834c053 ("ASoC: fsl_aud2htx: Add aud2htx module driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
