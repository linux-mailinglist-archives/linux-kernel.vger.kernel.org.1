Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7167269736
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgINUzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:55:18 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45619 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgINUzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:55:12 -0400
Received: by mail-il1-f194.google.com with SMTP id h2so886015ilo.12;
        Mon, 14 Sep 2020 13:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8WvvHg/kvJW2DjU6P7WmQQLcibKWeIA0fxQbTLFuTE=;
        b=Ef5wCpyAsIwbeQFHZJOEISAywx5c2f/awu6GuEE6u334FXVfKt/SfVRINd96NlJDyJ
         +E0dMZhqTrPZJMATxgV4NGAzriE97I1geIviF1cPgpqZIY1JcuKzRHiKf1R6kbH14G0k
         lkQRrVOoTIgXHHGb8elbR/zQ+QQxjdqsUPnxW5eL3GRi14XoaKgGgUxP00AbHth62s0K
         kBF9VKofW9u5THxAF0AjyfmNyA+kxnkkR1xRc/YvCDzMDRFYp9BVz5v0XTkJKnC1BM7a
         8iPQfn1g28nCPjQp2J+xJfF0PmSfGNTpLhNxVhY3QzO0JgX1OjQt+v593+WJ6iWHgFJn
         1PoQ==
X-Gm-Message-State: AOAM533ruL9dhUrbT/Qjahhm7oyo7XKQGojTu3COYKg3AAVKUl5+cMyj
        0olFHmJBOOVBRwrjzrgmaPBdU1pOwQpM
X-Google-Smtp-Source: ABdhPJyVOBYVcJ/dRq+qliVh0c2x5WDjsOiwxSYHrI+PLmIkewqJzPvgYlLu2PqoR8D45NlU62qleQ==
X-Received: by 2002:a05:6e02:4a1:: with SMTP id e1mr14281680ils.113.1600116911730;
        Mon, 14 Sep 2020 13:55:11 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 9sm7250394ilj.83.2020.09.14.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:55:11 -0700 (PDT)
Received: (nullmailer pid 230439 invoked by uid 1000);
        Mon, 14 Sep 2020 20:55:08 -0000
Date:   Mon, 14 Sep 2020 14:55:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        devicetree@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mailbox: fsl,mu: Fix i.MX 8QXP
 compatible matching
Message-ID: <20200914205508.GA230359@bogus>
References: <20200903195325.5394-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903195325.5394-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Sep 2020 21:53:23 +0200, Krzysztof Kozlowski wrote:
> The Mailbox on i.MX 8QXP (fsl,imx8qxp-mu) can also be compatible with
> fsl,imx8-mu-scu (for fast IPC) so adjust the compatibles to fix
> dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: mailbox@5d1f0000:
>     compatible: ['fsl,imx8-mu-scu', 'fsl,imx8qxp-mu', 'fsl,imx6sx-mu']
>     is not valid under any of the given schemas (Possible causes of the failure):
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: mailbox@5d1f0000:
>     compatible: ['fsl,imx8-mu-scu', 'fsl,imx8qxp-mu', 'fsl,imx6sx-mu'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!
