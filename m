Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8EC2A6D65
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgKDTCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:02:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41650 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgKDTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:01:15 -0500
Received: by mail-ot1-f68.google.com with SMTP id n15so20288908otl.8;
        Wed, 04 Nov 2020 11:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCdADtGJbCE4LsoGfkd3VKJpJmoa6WJULS6JxI7ElEc=;
        b=mVoIDb/0ANev04ACzpu8Fev0NWMYjiE8NBEcjVzrnLvqR21pAntcI1zYcHyKnAG8jZ
         mGPg/D491ayByM3A2zXa52Fiq0KNhHtBoXllwBx6WXllVt2F6aVijoV+I7drXKMG3DWa
         deoGn8OWuaZ0ohAQ41XpX2TL8WcGZNSAegYpyLwsL9Nb5iSmcp6T3mrVH34U3D3qs46Q
         kXcVD5aqqdnnXF4IehFZNDPAJG3+q6qqemt4VyabvEKqn0Q1z7WCOJiz3f7L3wwMhmfF
         yzr/soDaRUgMw83ZrN4TcuDnWOGNqyO3Pw6govFUcqGAojOe9Ar+2Dr4UWzVbslVTScw
         lQpw==
X-Gm-Message-State: AOAM532Khb9JrINH/Mfm4GF3XtvnxNz063AE7TZdtq/JIT5Ut3SexjSF
        SEiHMDs+ycZKrGZ8JHY1cw==
X-Google-Smtp-Source: ABdhPJwafnq62npe4dpj+8WaXkzleVIJJ9Y5Xz5INV3jgI1bfcGgLWp/B3v+FGdbPXjjFmcURQaK2g==
X-Received: by 2002:a9d:896:: with SMTP id 22mr19680580otf.55.1604516474734;
        Wed, 04 Nov 2020 11:01:14 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b185sm647365oif.5.2020.11.04.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:01:14 -0800 (PST)
Received: (nullmailer pid 3953219 invoked by uid 1000);
        Wed, 04 Nov 2020 19:01:13 -0000
Date:   Wed, 4 Nov 2020 13:01:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-clk@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: Re: [PATCH v5 09/14] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
Message-ID: <20201104190113.GB3950437@bogus>
References: <1604402306-5348-1-git-send-email-abel.vesa@nxp.com>
 <1604402306-5348-10-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604402306-5348-10-git-send-email-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 13:18:21 +0200, Abel Vesa wrote:
> Document the i.MX BLK_CTL with its devicetree properties.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/fsl,imx-blk-ctl.yaml | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml:23:10: [warning] wrong indentation: expected 10 but found 9 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1392927

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

