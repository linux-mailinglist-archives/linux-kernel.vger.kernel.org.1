Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787C526D0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgIQBrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgIQBrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:47:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F22C06178B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:47:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so421301pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IAe9YrO2c2nTBXJ+6AECIPfq5RqNfakgD6ec87G1lRc=;
        b=BRj0knLsGJxxYLXBhVmfZKGmxujjz+/Hmqi/qEwMX//OJvKf9yyDeEixQBGPd4wts4
         6a1NAlBUMJK+9HsT0tHExIiIBY51fBoIN1yU3XQ8O9EkJj//97LGtCL11Pe5o+QJ+bcS
         et0sT0lWTzye+QnNs4WZa5DghwevjSdMMaI9tIfXsfOrCJHnbGucKLqyBveNCMYoqf3A
         9t6u+brl3mB9g4hGos+8dgLT0f8ElY0zna3yl8gzeOh5Pr+C5judrj0NmF4GGrl6ENI7
         ParWAThpX6/xse3rOFEo2Qr7eC6Z7XHGuVFMsX8cwQuJ1jtwBxjW95ySSrHiGJABu2XO
         wuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IAe9YrO2c2nTBXJ+6AECIPfq5RqNfakgD6ec87G1lRc=;
        b=IXL/gl0dEm5hFtCX/EVLseJB+TkOHR8CNe+ZAxrSOUmbFLykUr9CapTek7m+yzpUus
         EVU+mjOIExTxWqZGVZ/450yhfcYiDYWY7vT3B1s00tSA1Lcu9A6RPGGVC3/xEMZ2gePO
         of0Dz+rg/rsznqQFJlnrs3v5Ga0aUdw7au8MHzImk0Db1AVOnfGgS1y0NHL0TaWljQXA
         SEwEFW5vUAfbpuKO1+MRxrWoiRh8WXpdxxjWZ4aCtRO+tqQ4cywxEnLJ2Cb/y2WbaTYY
         NG6+rfxC4qGAHuCRX6wBZl7QW4dhXBXdGykRkwO46VVRgkjaiHRvTPGQ0wSD3P4aiZj+
         XDLQ==
X-Gm-Message-State: AOAM533bHCpOOspRUR8hD0mOXphg4S01Gvnz8+fiUbDRhNFsjW/AfTSL
        QAmQ6vCGWRMA3cIydCCqD/w=
X-Google-Smtp-Source: ABdhPJxQrmqIyoEdGAwBvg6EW9yUh/vXTcfWc6Q0cRa/d1a/exrU70dlGhePTvzfeLRNM6mxTIWJgA==
X-Received: by 2002:a17:902:8605:b029:d0:cbe1:e773 with SMTP id f5-20020a1709028605b02900d0cbe1e773mr27020490plo.26.1600307259038;
        Wed, 16 Sep 2020 18:47:39 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u2sm3883917pji.50.2020.09.16.18.47.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 18:47:38 -0700 (PDT)
Date:   Wed, 16 Sep 2020 18:44:27 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: fsl_sai: Add new added registers and new bit
 definition
Message-ID: <20200917014426.GB22566@Asurada-Nvidia>
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600251387-1863-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:16:25PM +0800, Shengjiu Wang wrote:
> On i.MX850/i.MX815/i.MX845 platform, the sai IP is upgraded.
> There are some new registers and new bit definition. This
> patch is to complete the register list.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Change itself looks good.

Can add once fixing the commit message:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
