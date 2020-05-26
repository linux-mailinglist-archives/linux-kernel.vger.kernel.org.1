Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91D1DD7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 22:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgEUUAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 16:00:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33957 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:00:06 -0400
Received: by mail-io1-f68.google.com with SMTP id f3so8970040ioj.1;
        Thu, 21 May 2020 13:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/OBbI+6GWlC3oOe3NnwlkfXbsrp49bIWsk0Mjef2X1w=;
        b=mZyB99yA0rfZzYjPKDAlHXwWXzdf71m9ShKRy2RoxBvKBSLTWahDvrxP5dsAxRiFGc
         Vz8ZQBDHtLr4H8ELbKtzzu1mE7SiEGpJWMCFomZ0jUUDznB9S7bBqHmke160+A7OJ1ST
         pJ5yWkCKu//H1bDJFpJTESrv364dxI8h8JrhtBPYjfJKcunzgaO6PtHaVeQG8EU2XLv2
         FXSH/U58mTTOkxg3yUJBn/KA49aLYe7WGTKvu7Sn62lMuP0KrJ6lKQxWHeIu6JcDFtOO
         aeKnp6rRH5v7HzTt7mivNE+yKEkzGuK97bgodToXpx+8xr/t5y4Ah0CQxUxAP+dsglcA
         dWYw==
X-Gm-Message-State: AOAM530vu6Lv3JhHPskPRdSGjyyceln7QtGuHAnpzQ6WLXH69R1jvt8A
        lgiVYtF5Lq3uC4nSO8arEw==
X-Google-Smtp-Source: ABdhPJwzyw5pKWXUrC5O7c3oRIN0AOpnS71xcVe2dTARhkJ5T/JDIfApn3beqjgjWsFowWuLOQ4ZLQ==
X-Received: by 2002:a6b:1cc:: with SMTP id 195mr225126iob.177.1590091205067;
        Thu, 21 May 2020 13:00:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j17sm3239598ilq.79.2020.05.21.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 13:00:03 -0700 (PDT)
Received: (nullmailer pid 2801685 invoked by uid 1000);
        Thu, 21 May 2020 20:00:02 -0000
Date:   Thu, 21 May 2020 14:00:02 -0600
From:   robh@kernel.org
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] dt-bindings: arm: fsl: add different Protonic
 boards
Message-ID: <20200521200002.GA2800876@bogus>
References: <20200520154116.12909-1-o.rempel@pengutronix.de>
 <20200520154116.12909-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520154116.12909-6-o.rempel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 17:41:16 +0200, Oleksij Rempel wrote:
> Add Protonic PRTI6Q, WD2, RVT, VT7 boards.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

