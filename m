Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAD29D5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgJ1WJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:09:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41922 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbgJ1WJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:09:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id n15so571695otl.8;
        Wed, 28 Oct 2020 15:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KdqXDK4M/5ZEV294fuZhX7Y5VXRQ8lO6npUgDUtHCo=;
        b=ohKKonLNUrvLzSsdaIdqXfQX4K5xdcoXNlVCi+i8P4Hz0/F4Q2z1L04TRIFAc++dIX
         Yej9J5C7RjV4d1s+s7c+ws3Mw2p2yJo0xRsW0kD5yHs0p2c2GoPBl+cECeVAaKMt11pq
         MgZprqGd75BXp8pSeRe//DDa66SKyek6/lNa5YqjRHneL6duRnVWW6BMixRsO6PHvjnq
         kmukS4kTlXawyeXZoLeIMIaoX/nI8iBNyX8sbD9cyykoKu7Q7C9puaXI10AJoaxQI4VO
         g21JUvQXZ115+eCgYQkXLmwtGs4JccUdcssprqZ52bHXGvx8bvIoyRdFcYhQTfJSnh6L
         U8sQ==
X-Gm-Message-State: AOAM5326E0I59oorgHKjSMiaxB8VVd3Ov3NvClSHM/rToQJ7o+NS6xZB
        wtPvLRXZV/jF89V0NjcDUs6cqXrQgA==
X-Google-Smtp-Source: ABdhPJzKJ5XeHqQoJzEDcWmzSMiRturBprI3oV8B8fgDO4tHsUo5qjbS+NPLdGrci0BNyCk5/JUZoQ==
X-Received: by 2002:a9d:7315:: with SMTP id e21mr5341300otk.372.1603899117315;
        Wed, 28 Oct 2020 08:31:57 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j4sm2235193ota.17.2020.10.28.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:31:56 -0700 (PDT)
Received: (nullmailer pid 4062647 invoked by uid 1000);
        Wed, 28 Oct 2020 15:31:55 -0000
Date:   Wed, 28 Oct 2020 10:31:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        David Jander <david@protonic.nl>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 4/5] dt-bindings: arm: fsl: add Plymovent BAS board
Message-ID: <20201028153155.GA4062454@bogus>
References: <20201022104022.13149-1-o.rempel@pengutronix.de>
 <20201022104022.13149-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022104022.13149-5-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 12:40:21 +0200, Oleksij Rempel wrote:
> Add Plymovent Group BV BAS iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
