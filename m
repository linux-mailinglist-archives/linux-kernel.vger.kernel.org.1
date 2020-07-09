Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D6321AB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 01:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGIXTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 19:19:36 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33967 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGIXTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:19:36 -0400
Received: by mail-io1-f67.google.com with SMTP id q74so4170919iod.1;
        Thu, 09 Jul 2020 16:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=420yMXhBf21AgrF9OyTg/NVRUT5NXpwkF7oK2H8zSmE=;
        b=DdfzghdxZ4aZt40WaxYmcGIBrJMmC+WBnC0IPTfOj4+eJ1SLhuNQV0oKIbO5IsgG9H
         0+GVVZBoN2vwz2Mtn0VsuB4uUDFTYhOb4whpkwK58GDJfgPT5Rdy3eIVzD3sTnNuB/2B
         1KG1i1Xb7YKyZyk0ZfiCdl7wsOE+KbmHj5TJbBhAqlP6pwLjEo3/a6qgXAVqL/fNvP+C
         EzMY6K68jY9f/2gCqKx5IRgTrZaoKlYwcu44w7QQu83RHkoP1dWN/KmHgHKf9LSQ0JN2
         ZYsmFuelb0gTYvHZ75LuReLecofFZH5aP7E4eWDXMR8YJ/ZVzf90DIwJKkfuwm3b3NYt
         pShA==
X-Gm-Message-State: AOAM530rdFxuU5rT6W0vyTR8ue8kZfnL7LLiNXkxpd7DuXcs+HcI3+OC
        XnIGrWxZhHlrZJjpVDdg+Q==
X-Google-Smtp-Source: ABdhPJy6SVfqLGFLbMKsYIRFUYjf2S/5bFNmf+t797DpfD0y5B/NUOXz4NHISeqWaPt442qO7JyHTg==
X-Received: by 2002:a05:6602:2555:: with SMTP id j21mr24877145ioe.11.1594336775496;
        Thu, 09 Jul 2020 16:19:35 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id u6sm2489573ilg.32.2020.07.09.16.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:19:35 -0700 (PDT)
Received: (nullmailer pid 1083622 invoked by uid 1000);
        Thu, 09 Jul 2020 23:19:33 -0000
Date:   Thu, 9 Jul 2020 17:19:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, nm@ti.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com
Subject: Re: [PATCH v4 3/6] arm64: dts: ti: k3-j721e-main: Add system
 controller node and SERDES lane mux
Message-ID: <20200709231933.GA1083562@bogus>
References: <20200629125254.28754-1-rogerq@ti.com>
 <20200629125254.28754-4-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629125254.28754-4-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 15:52:51 +0300, Roger Quadros wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> The system controller node manages the CTRL_MMR0 region.
> Add serdes_ln_ctrl node which is used for controlling the SERDES lane mux.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 27 ++++++++++++
>  include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
> 

Acked-by: Rob Herring <robh@kernel.org>
