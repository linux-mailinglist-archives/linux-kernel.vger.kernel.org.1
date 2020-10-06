Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6E028510C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgJFRlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:41:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38838 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJFRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:41:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id 26so13451076ois.5;
        Tue, 06 Oct 2020 10:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ug2AhAe8+h2ycVxfTr0fWnf2Rz6QdU9raLFCM2GQrLA=;
        b=sP1zaZAkZpeWDVYhiIdmCu/dyF8J+9KaOWyUFsiFuxNz5y/O0a5x3jHSLZcYbj7w7s
         EUwtd2qid+KoZnnjnMFOZ8lVfaR8732MW9IamFTVbo+WDWaJM6DZyxL8+tGW1uPKuFbk
         vSjt7rvmrqqZUxWxVPC3ACmzU2TdmpC0swOl2GSbcwkT7RguH8qUlLD/kHLSM/DCP7ec
         sk6l0b87nG6UrR15eoB6d6FrvSPwOt515lm0qtBUVyo87Lh8akEcUyXM41g5zi7m0W+w
         aSkLLkKfhRAKRm989HLZa+AGhpNk0HxStLR+GZUtNBzvkL/7u7FOciCM9cha7K5HxhNc
         HYGg==
X-Gm-Message-State: AOAM532pRumf4204IuE3S7LXf0EHODrlR+Ix/cr5hPhkgfhn4lSoVO3R
        0xCQifROjZVdTpM+ShxcWg==
X-Google-Smtp-Source: ABdhPJxuK6/8KQ3zsOdcsAxicrrnKN1swqkUr/GQWKhfcy2d6jbZjROdSuwE/aGjrCPa9XCA0j8brw==
X-Received: by 2002:aca:4441:: with SMTP id r62mr3261589oia.153.1602006098637;
        Tue, 06 Oct 2020 10:41:38 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm1364153oie.26.2020.10.06.10.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:41:38 -0700 (PDT)
Received: (nullmailer pid 2511425 invoked by uid 1000);
        Tue, 06 Oct 2020 17:41:36 -0000
Date:   Tue, 6 Oct 2020 12:41:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Robert Jones <rjones@gateworks.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: Re: [PATCH 07/12] dt-bindings: arm: fsl: document i.MX6ULL boards
Message-ID: <20201006174136.GA2511365@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-8-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:54 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6ULL based boards.
> The Armadeus boards use multiple compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
