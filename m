Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1A2D332E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgLHUQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44723 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgLHUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:14:38 -0500
Received: by mail-oi1-f195.google.com with SMTP id y74so20721362oia.11;
        Tue, 08 Dec 2020 12:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wVHhe4QfgigoMpeMvbwhnhUQ/D1/hReELvZGpukDsz0=;
        b=awJ4LU6uHjacAABDlsBWINDTd12LJR44Bf8WhYvELZeP82JOg+DJVAUlfwQhY5Uzf6
         NIJDPFJJfcfH9UO3MjrtAGVEGfsn5ACQ4LclS3/2p6/OzsDpcTsYh8xTGiArdM4uq7ji
         pAIeLMr2hGDhcGEZY3hkAh9StsABKEo105RcAbyOcNuc9iUTlQrJG1nvTaNPKwLI4PQA
         nEmx4VacEb3tUcioWEO/xV8NY2OdnY5PqSBN1cUJqN18PVzM7hxD9RAducXWu8QZVsBA
         EyfY4YToCNz2gLUVIxiUcqSIlIoDzn75dhIYZg/tSTIpbi8tCM6IJrocRBVbhMajXB7N
         gt5Q==
X-Gm-Message-State: AOAM530sWRw4FzI7atp26mThQ+tH0pBWt/qkx722a0t2qA6B6vSteyPw
        +iFrhP5eqtESP4GBjMQRBmWuqAQiuA==
X-Google-Smtp-Source: ABdhPJzeian/q6X1jl4WuIXpOl0br58OZhbGnDQQgq/K3bdVeoYSkvIXQE5HfKzC5iC+FUjlL9Gmvg==
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr1554156oig.55.1607456767681;
        Tue, 08 Dec 2020 11:46:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k30sm3329467ool.34.2020.12.08.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:46:06 -0800 (PST)
Received: (nullmailer pid 2962287 invoked by uid 1000);
        Tue, 08 Dec 2020 19:46:05 -0000
Date:   Tue, 8 Dec 2020 13:46:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 PCIe
 reset binding
Message-ID: <20201208194605.GA2962257@robh.at.kernel.org>
References: <20201127111442.1096-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127111442.1096-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020 12:14:41 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 was built using older PCIe hardware block that requires using
> external reset block controlling PERST# signals.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../reset/brcm,bcm4908-misc-pcie-reset.yaml   | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm4908-misc-pcie-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
