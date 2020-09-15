Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7446926AC62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgIOSox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:44:53 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33858 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgIORcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:32:19 -0400
Received: by mail-il1-f194.google.com with SMTP id a8so3820710ilk.1;
        Tue, 15 Sep 2020 10:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frFFMJ3Z3B3UaKwbid0/RrGkT/BahZj6LxQeVuYq3XQ=;
        b=LSWHa0O7r2Wup4kJHu/2+HJdO8s5eELckJ2fpBzZzQpfjCcpta/Za8Uft+buAy/g7Z
         DRFpirUzF89lrN0J4WQjNDJRz+JxsioIsq7H4cTqdu4UkWKN7/e1m4kyGg6nNX+By6cJ
         gdL0NkIn1GI6gptQLLJtM2n/aJnbFgTFhs4vLKaFgkhkpJqt9JUJoioXYOrIz9d17qni
         gJNHg7nXemqbP+eI63QQwqZuT1QfD77Z+M/Bf821fXIdvxxEgAO4SwrfR+IqiNJ0ODUd
         GvwggIuolPW6UEORYxyccnIwGBNFt7SOo92t3QKa0QEMPmq3BpnLA+HiHhRvemYUei1f
         Xb+Q==
X-Gm-Message-State: AOAM530q7pQFuOOqw7SdT6vEI3/ZH2mpHlqJ+LNsGmSayL0c5fFMeb92
        QJba3klbje/ilA/ifWvF8w==
X-Google-Smtp-Source: ABdhPJxXbXGTnaORsXEdhvEv5PnM9NDeew6jEv7xOkE2izK1Ih7By9AaUvcVt6EleEiLs0p/dp5qYA==
X-Received: by 2002:a92:8501:: with SMTP id f1mr13864759ilh.54.1600191138903;
        Tue, 15 Sep 2020 10:32:18 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w8sm9412336ilc.85.2020.09.15.10.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:32:18 -0700 (PDT)
Received: (nullmailer pid 2174489 invoked by uid 1000);
        Tue, 15 Sep 2020 17:32:17 -0000
Date:   Tue, 15 Sep 2020 11:32:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: Add binding for Variscite
 Symphony board with VAR-SOM-MX8MN
Message-ID: <20200915173217.GA2174436@bogus>
References: <20200909152434.18643-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909152434.18643-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Sep 2020 17:24:32 +0200, Krzysztof Kozlowski wrote:
> Add a binding for the Variscite Symphony evaluation kit board with
> VAR-SOM-MX8MN System on Module.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
