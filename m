Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1C2A260B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgKBIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:24:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44597 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBIYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:24:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so7553266wrx.11;
        Mon, 02 Nov 2020 00:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTb/nfp4nQ+7c+frBD27iwhczhBtI0z5xWSXbiHenyU=;
        b=TKTiop3q8n8XK8N1kTrq2djaomYk/DQhtbaslFH2lwxoKcZ+2j+k5fjI4wj1r9pURO
         KeKCG8ambN4/PuRmwKyxzfyY7fiM/0vlc82ayPGRMXyxSQa07KZ4P3grKgDLpVA+OQP6
         hL4W2STIhgOxZoxWdq4LCprgiBbOE6T9hp09OGAV0uAPbgPjcqZ08TFF3V5W5WBdKEoH
         IvdXxBUmKBOp9dhlWdAFt0bq83LhfFBHW/T9bwZrBJLDjQ7+3+jtCXFyji8smsusLsXC
         p8Iv/Fvm2kh/Tk2G3qNA9cYhHOAfBural+tOrJ0XjQFwpFDJLLMwd2RPhMTmGbBvzwo3
         epAQ==
X-Gm-Message-State: AOAM533SY536ImTL49aOZJUYIs1SpN2dzSuLI+vDUAx5Wd2nK1ymPv5h
        BeJbXdgDbUndYKi+Mqf2aIU=
X-Google-Smtp-Source: ABdhPJx5BhKxovb46yfkZcV9GmrQtBUrd1Dojv/dfXSdtwdX89VkqH5dNCEEqdmvjxIquZIaa4HVyg==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr17857532wro.337.1604305446067;
        Mon, 02 Nov 2020 00:24:06 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v19sm13861971wmj.31.2020.11.02.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 00:24:04 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:24:03 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mq-evk: Add spdif sound card
 support
Message-ID: <20201102082403.GA6152@kozik-lap>
References: <1604283077-27012-1-git-send-email-shengjiu.wang@nxp.com>
 <1604283077-27012-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1604283077-27012-2-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 10:11:17AM +0800, Shengjiu Wang wrote:
> There are two spdif IP on imx8mq, spdif1 is for normal
> spdif device, spdif2 is for HDMI ARC interface.
> 
> Enable these spdif sound card in this patch.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - remove undocument compatible string.
> 
>  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 38 ++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 48 ++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
