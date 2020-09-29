Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533A27D540
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgI2R5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:57:19 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:46883 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2R5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:57:19 -0400
Received: by mail-oo1-f68.google.com with SMTP id b12so1505905oop.13;
        Tue, 29 Sep 2020 10:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qp7SS2T14cd3C/5H7OFBLuz8PZLS14HzIh2NjdUhVbs=;
        b=TMQIBn17HDu2TzliOQyuqSCSoj+5DybJtWAKfbofE1ylss2GoFP1KkoiVIKigs/IT2
         9GyA+IQX5nE+8/Eq8oBFjsa77fUX4D2o0CqZbcqk14MeFEKDkdhc4iBxaaZksoq1Til/
         I3KgJu/ba2DG5RLe98LhbP3bpOWQAjUof3hGgNSDkK5bV3aBRY4jJxV2o1ErxMZg2OTI
         u1m0RcrhmodeRl+xe0YHoPsHdZH6kuMC8cuBKMa2qzqeXjSykwn7E87OTf4/HTwXVO2u
         8WTNHtOz1wGcdz2Y6Gin89YtKw6xFLWYtcz3iT9AazWrKbMUkCP51EE2Bf3vAsOm+mqk
         do8g==
X-Gm-Message-State: AOAM531k/wmnS09TVQVVMwJTA9fcCeyr2m6OTTbEKVgtVE/9JO7xkROZ
        YKOLTTwSMgw1qhN+WqpiJw==
X-Google-Smtp-Source: ABdhPJyPPPR5zaH4ylWdewg8PL0HYyp+Im2DPtn2yqLeUBi4x5F0YYGe8L3UwiWAoA/LhAtVQgTj8A==
X-Received: by 2002:a4a:751a:: with SMTP id j26mr5523657ooc.14.1601402238285;
        Tue, 29 Sep 2020 10:57:18 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm3092247ood.31.2020.09.29.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:57:17 -0700 (PDT)
Received: (nullmailer pid 865499 invoked by uid 1000);
        Tue, 29 Sep 2020 17:57:16 -0000
Date:   Tue, 29 Sep 2020 12:57:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: fsl: add Plymovent M2M board
Message-ID: <20200929175716.GA865448@bogus>
References: <20200922051454.30878-1-o.rempel@pengutronix.de>
 <20200922051454.30878-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922051454.30878-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 07:14:53 +0200, Oleksij Rempel wrote:
> Add Plymovent Group BV M2M iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
