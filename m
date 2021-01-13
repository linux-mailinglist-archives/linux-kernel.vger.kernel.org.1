Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D116C2F424D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbhAMDQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:16:46 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:38092 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbhAMDQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:16:45 -0500
Received: by mail-oo1-f45.google.com with SMTP id i18so178834ooh.5;
        Tue, 12 Jan 2021 19:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vxk5MOdtzou/F1fb9Y4udKZA5zOP9DO/LQOh+zLeug4=;
        b=WWvBv7y+VEVe4PB6uRq1bnF0d6J9XEoilztp4rHYfzLvgzrLBGk6OtEE2iwWfPxxOp
         T/6qnLcjs1zvnRKxkM//dhx1YY49MgmVPWm60WoqbTUtUM94KZW4hNkrpVPxqOiYbPx8
         Fo2237KLSNcKxWfdSOnWU6PHN5wfVTquteychv9nYhhzTk16uq9pg6Q4zAoelxEGOOs7
         nyWd+DiqMWMPNDotjRAJMstcBUVLsHXR3NgiIDrqjo+KPEFJWb+V8stetzjJk3wwDCv3
         h7TOK8TC4RZuiiBCIMUYHxDwnQeKFvAXXVljZmi9z4DGPz86WVQtyj9tFkuIcQKY1UwA
         uoXA==
X-Gm-Message-State: AOAM5338Ski02CYlIIuF6K2o2oGqbQJJzguZBpXNza7xf0ICGU77pKZS
        i6k/Gh614++GA8bhmiGrQY9JucUSDQ==
X-Google-Smtp-Source: ABdhPJycc1IEtgj1+eyQPcsWs+pizJRNvXrFwG/iiHyFJk0I5S1AKHjVLa37RumE46vQOUc1izoWdw==
X-Received: by 2002:a4a:bf14:: with SMTP id r20mr1401442oop.2.1610507764859;
        Tue, 12 Jan 2021 19:16:04 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 59sm154107oti.69.2021.01.12.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:16:03 -0800 (PST)
Received: (nullmailer pid 1458550 invoked by uid 1000);
        Wed, 13 Jan 2021 03:16:02 -0000
Date:   Tue, 12 Jan 2021 21:16:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk@vger.kernel.org, aford@beaconembedded.com,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] dt-bindings: clk: versaclock5:  Add load capacitance
 properties
Message-ID: <20210113031602.GA1443816@robh.at.kernel.org>
References: <20210106173900.388758-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106173900.388758-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:38:59AM -0600, Adam Ford wrote:
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Update the bindings to support them.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  .../devicetree/bindings/clock/idt,versaclock5.yaml   | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> index 2ac1131fd922..e5e55ffb266e 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> @@ -59,6 +59,18 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  idt,xtal1-load-femtofarads:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Already has a type, so you can drop the $ref.

> +    minimum: 9000
> +    maximum: 25000
> +    description: Optional loading capacitor for XTAL1
> +
> +  idt,xtal2-load-femtofarads:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 9000
> +    maximum: 25000
> +    description: Optional loading capacitor for XTAL2
> +
>  patternProperties:
>    "^OUT[1-4]$":
>      type: object
> -- 
> 2.25.1
> 
