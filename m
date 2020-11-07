Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F502AA239
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 03:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgKGCki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 21:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgKGCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 21:40:38 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A4DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 18:40:36 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so3317915pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 18:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uIZQwyu3heVWOuZiTU19D+Rn7MoOiKM8zu84y+cy574=;
        b=UwI9OV4XjHg/GOytA2RlHLo2M6JLlW7M5230uqzFpBC2M9Mtkw30LzLDYQ69j0W7Iz
         KJvGsPiCipMbg8JMEm9fW8u1REnbRLHe+lh4W8Ssz++RgLG2DKQnJQJhMqMeE9hFwOEb
         fG+8RdA6cyA8TWfJ8nPCA+d6OL81wPnp0j3mENUpIzfW4GoLgQ9sM5D3bkuzQI+y4alf
         bTay6lXpq+gBveRpOK94h8DQF+ZDYHBJmCfvdbJ09U3Lp/MNQ67qO6P4Pov8neD6GJ6M
         hJX5AQ90xKKCRRFM641cHKHqagg+mKQ5HyM3XIHcmryL782zL1wcEBGQEEFKKVYr7vj2
         My9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIZQwyu3heVWOuZiTU19D+Rn7MoOiKM8zu84y+cy574=;
        b=fO2WOHrd3TBdI3dEmMifsL4SIh4r5osKaW6n+y/gAqCi/V5vPivNtAXgAgj33ZV14K
         sYZHBrzoGi1mbBLijFhbONEXDFKhSRxO20j8q4q6G6rhwrDMxzq7ohQ2aTkUq7CRibJI
         InWw0mo1qQ8WgMIchvlyW/ROo1RInHh1OAnP4il5TbfEZdA84a0dN9vWoZOObX21wVKt
         IwTINR45cY/wxDra30FVUCd9jxg7iyY3n9Azvpwn2KCiNvNohylebixRlIjfTIXpnG7C
         mZcPihHcifMkDZVUXOXcDwt4erA8rvRzfxvBoBlm9FZ5HGSDWzL1nS2KMfQtmNDB5bLQ
         ztZw==
X-Gm-Message-State: AOAM531+HcuJwFjEhPAtm9IqDK4M50g83B3nSntVK0HQKgqs/7mwqObg
        8YdTmwfkEjeUZMcV7zrztNE=
X-Google-Smtp-Source: ABdhPJwppyyTWHSp5pmK5h5/8Fa9jyRxfiLX2TJyLtAO4il12N3D8xn3qiRuq1mH+2JebQBByBlSqw==
X-Received: by 2002:aa7:815a:0:b029:164:cc2e:2c56 with SMTP id d26-20020aa7815a0000b0290164cc2e2c56mr4532319pfn.21.1604716836081;
        Fri, 06 Nov 2020 18:40:36 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d68sm3670126pfc.135.2020.11.06.18.40.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 18:40:35 -0800 (PST)
Date:   Fri, 6 Nov 2020 18:28:22 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_aud2htx: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20201107022822.GA5163@Asurada-Nvidia>
References: <1604715643-29507-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604715643-29507-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 10:20:43AM +0800, Shengjiu Wang wrote:
> platform_get_irq() would print error message internally, so dev_err()
> after platform_get_irq() is not needed
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
