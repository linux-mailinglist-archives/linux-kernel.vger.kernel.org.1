Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC62D45B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgLIPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:44:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36954 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgLIPod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:44:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id o11so1763800ote.4;
        Wed, 09 Dec 2020 07:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zcGcVsxIiI9hodbdc2AAWPzpVhPj/YsdgMaqJc66cSM=;
        b=oCfC47fBIlB7aZpISOPSWsIXqVQBDzyKwppVmkHrZtAQJkxN8xbEVxb3w9cm5h6goI
         NdDWD8aWMFAkui1LqZ0+EXrlVRPPv0emGwatxP1m5pnBe4uu14+PcPsXfC59IUQBQGGY
         Gg7z4H8EAb//mhTeGDrEMUjhw9+uuEBVPzIFt3XjcSQvSVQJLbbzF3PCshH4wyF7ajd5
         mSxnvVa0pFyRkJuicV0PnmVmRBUz5gsDVmw3UFuso07ZMRGcBy7coPWeoLqcSpdyBR90
         tsUw7/WdBIMtMDW/9zfC/Sb4e7Y9Ze913WRFNZW0vhU85TC86xGdBhv9z8KsXYjHlbjt
         6dRA==
X-Gm-Message-State: AOAM531REP2Qsi2/fkyT6PcEQPQ79WvWZS4M7Vcmav1ximLbTWToaxNM
        fFijSu/tWr4cKcMXVVenTg==
X-Google-Smtp-Source: ABdhPJy0c0hrjctbbcOPvOYisd2yCo+/X2EAU9BABx1eTO4blOeTarRIsb9ltlmTf1yOCgp1rpzqJw==
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr2349827otm.231.1607528632800;
        Wed, 09 Dec 2020 07:43:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a24sm376932oop.40.2020.12.09.07.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:43:52 -0800 (PST)
Received: (nullmailer pid 501262 invoked by uid 1000);
        Wed, 09 Dec 2020 15:43:50 -0000
Date:   Wed, 9 Dec 2020 09:43:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Jander <david@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add Protonic MVT board
Message-ID: <20201209154350.GA501215@robh.at.kernel.org>
References: <20201201074125.11806-1-o.rempel@pengutronix.de>
 <20201201074125.11806-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201074125.11806-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Dec 2020 08:41:24 +0100, Oleksij Rempel wrote:
> Add Protonic MVT imx6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
