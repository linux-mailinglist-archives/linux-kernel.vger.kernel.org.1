Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158812DEAFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgLRVTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:19:01 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:39951 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgLRVS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:18:59 -0500
Received: by mail-ot1-f48.google.com with SMTP id j12so3253386ota.7;
        Fri, 18 Dec 2020 13:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H68oJ1veub/N/sJgxu616Ofk95w8UIImHp8Gl1T/ERU=;
        b=lQT7iRqmMs82opvO62N5C6jeWDmPtBCMQNwOQ1U8a8lKCSR2GwfTxi8fcd+mBmXrcy
         RGcDdBDXdQ8T6aIPlWjE3utMZklaDxAobkjm82qAtYe8+pW5DWdHxF3nXNQ7ZFchGLT1
         appaW5cKafJjqYSkf7qU4ZcUPFeB+eyXcmWs9rBhO+bz65Iddcf2LGa/8iPP1H0iTH5k
         hAl5PXsO4bQH5yeRqDfwHdhBdLDNsRQCguzO7GWrP6CElsqzJ305Hl6TT8b7A21ut+DZ
         NI7IaFSGPwov42zdeImjJDnprj1HQvdFs8QDsUwmOgknJUuXWX4IiY+Y4vRoqARL9Pnv
         NyzQ==
X-Gm-Message-State: AOAM530agVMDKv0/Of7CmbTphSYeruitdAWbbayEwJOQazRbvkC6XgeV
        bhYJFkk3BIBbLglFUE80cA==
X-Google-Smtp-Source: ABdhPJy8sQG5Cy69vLmv0EPAgz9Gu+Ggh0c7KDIAvES68hWv/VkEHe57wEWEs1xemVvo1hDc3Fmn/Q==
X-Received: by 2002:a9d:208a:: with SMTP id x10mr4243581ota.260.1608326298191;
        Fri, 18 Dec 2020 13:18:18 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t24sm2213662oou.4.2020.12.18.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:18:17 -0800 (PST)
Received: (nullmailer pid 2192221 invoked by uid 1000);
        Fri, 18 Dec 2020 21:18:15 -0000
Date:   Fri, 18 Dec 2020 15:18:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/1] dt-bindings: clock: imx8qxp-lpcg: eliminate yamllint
 warnings
Message-ID: <20201218211815.GF2190633@robh.at.kernel.org>
References: <20201207045527.1607-1-thunder.leizhen@huawei.com>
 <20201207045527.1607-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207045527.1607-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 12:55:27 +0800, Zhen Lei wrote:
> Eliminate the following yamllint warnings:
> ./Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
> :32:13:[warning] wrong indentation: expected 14 but found 12 (indentation)
> :35:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../devicetree/bindings/clock/imx8qxp-lpcg.yaml      | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Applied, thanks!
