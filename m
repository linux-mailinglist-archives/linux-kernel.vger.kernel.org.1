Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EB826AA98
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgIOR2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:28:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41960 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgIOQtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:49:03 -0400
Received: by mail-io1-f68.google.com with SMTP id z13so4816772iom.8;
        Tue, 15 Sep 2020 09:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10MiP67UQcC15r139yrBcHP2KZRLFQ+JBTEWqPfgDh0=;
        b=HNzqTcPJrnlxFdhx2W9e+LZO+j6yWUf+r+7Vq8IDYMu6Woz9u67zk1dXI8QoqUpfZK
         wd4OZjId66M3uOwD2ZO6GjrWQ7kq6ngEidHrjGP+Z3AKPmWhXL8WQbwB5d72TUY1bEgV
         yG1ZNgbSCM4O9GO6HRjz3kqKcG9oVayPJ+0mGwpJlc9XyyKgs6FMsg2L04YGcffIRbx0
         lAOzJp10X9jzohi8F/E87I2+EY5iPFKpqhSFMpeFgc49aZXGWD/Ki9I7OlQRqSczx0qu
         4ib+hyKauuj0iahWXOrDXzFotm1VThhwqjVS9EY1DK/BTaG6DQAS7yMUNBrfxrGYWC0C
         q2/A==
X-Gm-Message-State: AOAM532Ez5NcM7fUXBKyoAOuqs4LKGCzYQWln/Jl2Ypf5XCbrpE527T6
        3KrHyHb+Y9iMmLQ6id/1Nw==
X-Google-Smtp-Source: ABdhPJzJaEWfdKVemkfPY0N5CHuOb5LNBkF6uEBGIPuYAGJHHQSskg7FuYXhHw7+MHQoulC6+kmMuQ==
X-Received: by 2002:a02:7b0d:: with SMTP id q13mr19377885jac.7.1600188465979;
        Tue, 15 Sep 2020 09:47:45 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i9sm5529082ilj.71.2020.09.15.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:47:45 -0700 (PDT)
Received: (nullmailer pid 2103122 invoked by uid 1000);
        Tue, 15 Sep 2020 16:47:42 -0000
Date:   Tue, 15 Sep 2020 10:47:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 09/14] Documentation: bindings: clk: Add bindings for
 i.MX BLK_CTL
Message-ID: <20200915164742.GA2103068@bogus>
References: <1599560691-3763-1-git-send-email-abel.vesa@nxp.com>
 <1599560691-3763-10-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599560691-3763-10-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Sep 2020 13:24:46 +0300, Abel Vesa wrote:
> Document the i.MX BLK_CTL with its devicetree properties.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/clock/fsl,imx-blk-ctl.yaml | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
