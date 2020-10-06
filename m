Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0F2850EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgJFRiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:38:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45772 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:38:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id f37so9497727otf.12;
        Tue, 06 Oct 2020 10:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OZAbUpujZ/aBAQknM6MfbRYB3XE9/uZJ33R/zBy5Js8=;
        b=CwyJ1tjP9a86AbDHn9fpAV7vR69ehJEQADF3Jv6T0/QBDzJk79VTP31lf1gjrchK95
         lrSO34BjbrCA9qu+l+J8Wog1I3VCqSeCaawmsDV4OpSm2h6PGEfIlcRGuNPl5r0MTaUK
         JIvjWYOBC01sRVwpWb5oO+iyY8hAl5Tjgvjyw8BaS5buysuhi6WOGw3u/bjFERBsAov5
         sLAN4VHH/vzyihx+tMEDIr/Dxq88NKdHJYXi2OOrm/kyp7DPUCxwLLTCdhYLWNp+9bhs
         yfF0fBz5t7+opeiYg9I/KyvAMPquEr08p9LY6QM0OZ8iAioCmqdO+qi67UgOB17G3A01
         IV9g==
X-Gm-Message-State: AOAM531fjlnjt51qgounBWRwrcYIgAAkUwQf91twt710jNx7Cka2RSxB
        INiMAYgFUx5HVRBNunIW7g==
X-Google-Smtp-Source: ABdhPJwxnhGE4DuATYns41D4XGZpfOi1RS5mR28Nd3eT2578hSKXngV+1W/Z6ue0fgy7PbGs9Z2dVw==
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr3846492otq.77.1602005887570;
        Tue, 06 Oct 2020 10:38:07 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r62sm1395581oih.12.2020.10.06.10.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:38:06 -0700 (PDT)
Received: (nullmailer pid 2504999 invoked by uid 1000);
        Tue, 06 Oct 2020 17:38:05 -0000
Date:   Tue, 6 Oct 2020 12:38:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Robert Jones <rjones@gateworks.com>,
        linux-arm-kernel@lists.infradead.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Heiko Schocher <hs@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2 09/12] dt-bindings: vendor-prefixes: add ABB
Message-ID: <20201006173805.GA2504964@bogus>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930190143.27032-10-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 21:01:40 +0200, Krzysztof Kozlowski wrote:
> Document binding for ABB.
> 
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Use ABB vendor prefix
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
