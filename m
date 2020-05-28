Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717581E6CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 22:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407316AbgE1Ufg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 16:35:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42497 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407267AbgE1Ufc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:35:32 -0400
Received: by mail-io1-f66.google.com with SMTP id d5so22152665ios.9;
        Thu, 28 May 2020 13:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R1LLM7xnfdvcgFQRKV14YzdSlvQJ4RI+sB1xnpIODbo=;
        b=EADPYqQc+4Y1n4IfWTm1INZXCIljSKNbWg3XP8KFEU7O7H+OLYWlg64TrlsCsNQjZc
         ojhkA5J+/RScb5qkeSWPPa+Es5K5axsC1dtqPC3yySffYVxEgdQsbZ/bfOhe3/uWMqcp
         gr9QOBOkOpvtNcVNyUuk18HAJuYN7u+A3E7T84cSv+a66X1JhnytCb3dG992jNroL4V2
         AXRoKXym3GXdJnmFm2thCaJICzfdlKAUbaJzkoNI8+5FqA6Mn11lrtHH3aDeg+aHxdxA
         szbz5ov4pY7s9wXo/y/dwIygR08xgmBJur3FXV/W6ZPJmLUyT1gDM7M8rsVzMQjNm9m0
         HkfA==
X-Gm-Message-State: AOAM533VXYNvfPlbFS00nku5XE/FpXR1dTqrEBf1633/2ZoefHqGdmY1
        72bnX/l7GI+GMtOkRoM2aQ==
X-Google-Smtp-Source: ABdhPJxLNPfzvPou+nEraMmQPrlQ/n6yBhSboqmWZZKjRfj8axP7upEERZ+wrmhmueCUpUq9OGYxPQ==
X-Received: by 2002:a02:58c3:: with SMTP id f186mr4317387jab.120.1590698131111;
        Thu, 28 May 2020 13:35:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y13sm3007418iob.51.2020.05.28.13.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:35:30 -0700 (PDT)
Received: (nullmailer pid 633109 invoked by uid 1000);
        Thu, 28 May 2020 20:35:29 -0000
Date:   Thu, 28 May 2020 14:35:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, maz@kernel.org,
        jason@lakedaemon.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Linux-imx@nxp.com,
        l.stach@pengutronix.de
Subject: Re: [PATCH V3] dt-bindings: interrupt-controller: Convert imx
 irqsteer to json-schema
Message-ID: <20200528203529.GA633058@bogus>
References: <1589790957-7904-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589790957-7904-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 16:35:57 +0800, Anson Huang wrote:
> Convert the i.MX IRQSTEER binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> Changes since V2:
> 	- Improve the interrupt items description.
> ---
>  .../bindings/interrupt-controller/fsl,irqsteer.txt | 35 ---------
>  .../interrupt-controller/fsl,irqsteer.yaml         | 89 ++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
> 

Applied, thanks!
