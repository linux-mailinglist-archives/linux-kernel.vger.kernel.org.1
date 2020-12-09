Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40F92D45B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgLIPo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:44:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45211 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbgLIPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:44:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id f132so2118775oib.12;
        Wed, 09 Dec 2020 07:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m1flZRqwtV16UKiiPgrDN8UjiBKmf/noQhKDqDLPAEc=;
        b=OFrzfeIUeyeMX20klxJasUehnm3p4tQ8WiYWKFmsJ7QsUdCi2JyPWbRr3auxoymJ5C
         n/roj23Yg8+4hI5cw6f7CpkCRL1Dvcl3Cjm+RonHqogdVvCtWl1qaCiXX4/Cs9RTLiSD
         ZNY8AHyJw5V9SD2sxCH1jNa+KqPVNlW2QnB0Or9bqamuTFJqQtHkLrKxqd3ADdr6jjZT
         fp5CfD35bfPcdsFw+n3tYc6ANQKzqDuLETvvm9Wm0+sDT9KTym2wAs0ELDdriZHDx41g
         U8XXnoPWvsxOiShe0vByT9Wjgz02PZJzPzylQYeD4tQJChnRa/VKX2BsqMkgcdIcoCVR
         H4bQ==
X-Gm-Message-State: AOAM530S6x4ilJP7KVxJ/l1sPCUvQERXaSZo7qMSax25HeMP4uB+2bDn
        xoHctcZ1UZDBXt4DaR3NrQ==
X-Google-Smtp-Source: ABdhPJwwcQCtDGG8BT4kb+/n5LFbL+U2xgj7Dgy8swg/aKy5un7Z4ImYBlpzfEhTZhwJ8Z/Lybw/kg==
X-Received: by 2002:aca:75c7:: with SMTP id q190mr2145096oic.129.1607528615183;
        Wed, 09 Dec 2020 07:43:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z38sm5511ooi.34.2020.12.09.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:43:34 -0800 (PST)
Received: (nullmailer pid 500750 invoked by uid 1000);
        Wed, 09 Dec 2020 15:43:32 -0000
Date:   Wed, 9 Dec 2020 09:43:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: arm: fsl: add Kverneland TGO board
Message-ID: <20201209154332.GA500701@robh.at.kernel.org>
References: <20201201072449.28600-1-o.rempel@pengutronix.de>
 <20201201072449.28600-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201072449.28600-5-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Dec 2020 08:24:47 +0100, Oleksij Rempel wrote:
> Add Kverneland TGO imx6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
