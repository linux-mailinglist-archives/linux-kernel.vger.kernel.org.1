Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1728A2AC7F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbgKIWDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:03:14 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36794 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKIWDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:03:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so10549698otm.3;
        Mon, 09 Nov 2020 14:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EePEy4ijH1/6uTZdSxjulsoqmXlf9L9kEMCID3IAUL8=;
        b=QbrQBqc1eydW2VKdjy4tGTTEbWBIqnSB/uH+wy/gpZXpesU2v3SvHI58RrDIL7pR4m
         /hMJt3pfcOniBvyhkTcDB232aPNkkhEplvdVF96gzK8sKfsxBGsz7Ltw3TXF8IfGLGr3
         iLg22fZ8skd21UnQ8hEaaf2J1PY+nA1QV5w0Dccbo/dmpxOioNDnPdZqUxMDYxeNmst6
         kUMCC1p/jqXmyWbc/R98n2RmgO3ZGqmSxi0WR9opqLdI2YNFEEv0tzKM49y+1reur2oO
         nkeay6uqhavq9wnIO5FuPEe91YIsP9fmkE/2p14QtzJowuotmk2vLG9z7lXa9evv9QEM
         Q6wQ==
X-Gm-Message-State: AOAM530ng/2wbTUeN5IRg90YuCdxz8RpUfnQa3tm7XbQooIpV7tK5UzX
        Bx91Cj/lZ0Wwh2Wga1nEsA==
X-Google-Smtp-Source: ABdhPJwtpN9Gi5e6MyNFObgMW4csuzD+Wm7XSMgWvgC3pf396MEOHK4Kea5bevGbVXkGwMaxU6bTwg==
X-Received: by 2002:a9d:4b0a:: with SMTP id q10mr11845542otf.271.1604959393936;
        Mon, 09 Nov 2020 14:03:13 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm776153oim.36.2020.11.09.14.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:03:13 -0800 (PST)
Received: (nullmailer pid 1835486 invoked by uid 1000);
        Mon, 09 Nov 2020 22:03:12 -0000
Date:   Mon, 9 Nov 2020 16:03:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v1 1/5] dt-binding: mfd: syscon: add Rockchip QoS
 register compatibles
Message-ID: <20201109220312.GA1835439@bogus>
References: <20201107170103.25608-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107170103.25608-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020 18:00:59 +0100, Johan Jonker wrote:
> With the conversion of syscon.yaml minItems for compatibles
> was set to 2. Current Rockchip dtsi files only use "syscon" for
> QoS registers. Add Rockchip QoS compatibles to reduce notifications
> produced with:
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
