Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962032837FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJEOjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:39:36 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44439 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEOjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:39:35 -0400
Received: by mail-ot1-f54.google.com with SMTP id a2so8788586otr.11;
        Mon, 05 Oct 2020 07:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qIXT7WClacYeS5hCA5PsMCUuZTSd+RNZHy9vJfPAUzg=;
        b=KgcSCovbevs80blJdIoKMn3Q2RfAt70XpbuZG8W3T8izcUIjxFNxA5WlO2ibXM1BHJ
         oH8lJ/MdP5OQMz/ZYPUpfs+sHPxGyubohT4+c482EThFkWq7QK3duKLV4ZJqzjsEnPmD
         wTQJJQJujLAjkoFke8baaFDQPbqzypAADxfKmNLFGvVR6eEzgs9sjKljpHY6k7olAiK/
         /WatYoiZsQ1KZf3o3+XW/Cv7282ayIpFcL3Ah6PYIbFE5qTEe77CIRFE925Yx1oO/tL/
         gXIe2GkFafu8Nhng+htwBIibMx2bEzOzwKbhV0vYsRmeTq+NgCsRVB/m65Lf6Pr4hMph
         NNKg==
X-Gm-Message-State: AOAM533bkpR7u1QnRpxvto3GTxdsX2kuPv6YET+E9v8GmPSvZEGuYaWA
        H+WYuUuwVVmUMK/DvBC+WA==
X-Google-Smtp-Source: ABdhPJyX1Fga/vVFA89iL3Rs9UhqoIlXgpR6PuyCL41L9UG2c+BC/1ulhpOCP/+0QaBgWfkLHBT1RA==
X-Received: by 2002:a9d:6a55:: with SMTP id h21mr4849014otn.297.1601908773319;
        Mon, 05 Oct 2020 07:39:33 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m20sm39276oof.23.2020.10.05.07.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:39:32 -0700 (PDT)
Received: (nullmailer pid 151138 invoked by uid 1000);
        Mon, 05 Oct 2020 14:39:32 -0000
Date:   Mon, 5 Oct 2020 09:39:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RESEND v3] dt-bindings: mailbox: fsl,mu: Add missing
 power-domains
Message-ID: <20201005143932.GA150931@bogus>
References: <20201002161837.5784-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002161837.5784-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Oct 2020 18:18:37 +0200, Krzysztof Kozlowski wrote:
> Add quite common property - power-domains - to fix dtbs_check warnings
> like:
> 
>   arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml:
>     mailbox@5d280000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> 
> Hi Rob,
> 
> You previously reviewed this patch. Can you pick it up to your tree?
> 
> Best regards,
> Krzysztof
> 
> Changes since v2:
> 1. Set maxItems to power domains to 1
> 
> Changes since v1:
> 1. Add missing properties instead of unevaluatedProperties
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
