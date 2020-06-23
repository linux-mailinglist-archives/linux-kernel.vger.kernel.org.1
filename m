Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0280206871
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 01:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388395AbgFWXbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 19:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbgFWXbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:31:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0429AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:31:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f9so189219pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v2em8WufMe/XzcJqk7YFYQSWFx3qyHpDXzQPwunL4Mg=;
        b=D3PrKqttTaVJOmY8IJl9a74nK+vT3bB73vbRbEdADkSzTBJXKcW90YspYntqCqaJhL
         flrsd1SDjQCLrku8MvQ8ffq7WXYKSRZGpOZpkpo4jBmp8mt/S8qVrp+WIcjXLAe7m0ko
         4hPR6azoWVRP2H3o0QL67neEJZtUvscXqKhJetbfR1waX4Kr21d6Tx5UyWIuFiUn+ggZ
         pTTL8voMO9NWKPC/PhYy0SE0gPC1rE8w+3Sqkep5YwkwTRzpzrIJvD7ap/isv8xDIIkP
         3kgds5X7zJ30Hkne7cgO5PxcccR7DALNDjVPC5qn7FL9r/9FD7K39kmsydeCkzj2aDJ8
         pErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2em8WufMe/XzcJqk7YFYQSWFx3qyHpDXzQPwunL4Mg=;
        b=j3AImV7FWuWnQhm3aW5hC8k1H1eSLNmMqAMir86fj1spMfQIXqJn1tPpwBnEIMNExW
         v1wm22zYg21XqLSClnnolxMysQCNrEa2xsrw1LcAL1LTSUQflsiid5UYnwJYKeXw21Hw
         zdKrILXmJ5RTE4tK9X5hdSdWo7SC7n1qZ+EoEgcJVDGKbdZGZiaXfXLsoVGvNB7LHnwT
         KBI/MJR9pRz1T5mxwFK5E2pGAPJAXqwehqSrCWSgOGFg9JrzChPjbYgREVy08f1wJ8Ta
         NkpRjG3takUEVcsfuvHA0+Qr+HLm7cBn1oaQGRMrFsTGLpUMzqc/yEseE3POmIZsRUdl
         p7CQ==
X-Gm-Message-State: AOAM533uqxZHSeMImWxfMSNxQa5mWCiHPnVM8Ig5lzpBHZclofJ2Cz/P
        wv5+fnqyRHR9DAcDF9MQpu4=
X-Google-Smtp-Source: ABdhPJygTOv/K578Nfi+keQ7SWHWmMxiyqT1qgqh4PY1PWO2ZBzG5y01Ax6vFA6ckUG9CyH3gxpZZw==
X-Received: by 2002:a63:531a:: with SMTP id h26mr19943514pgb.188.1592955078526;
        Tue, 23 Jun 2020 16:31:18 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n62sm3651622pjb.42.2020.06.23.16.31.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 16:31:18 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:30:51 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: bindings: fsl-asoc-card: Add compatible string
 for wm8524
Message-ID: <20200623233050.GA28062@Asurada-Nvidia>
References: <1592895167-30483-1-git-send-email-shengjiu.wang@nxp.com>
 <1592895167-30483-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592895167-30483-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 02:52:47PM +0800, Shengjiu Wang wrote:
> In order to support wm8524 codec with fsl-asoc-card machine
> driver, add compatible string "fsl,imx-audio-wm8524".
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
