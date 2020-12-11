Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE48B2D6EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405228AbgLKDbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:31:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40605 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405226AbgLKDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:30:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id j12so7058991ota.7;
        Thu, 10 Dec 2020 19:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7k4vXfJBn4y3OY/+yHuhF96zAMCYyUkpRpI2p6x+YA=;
        b=OdC6DJEzo1YxcpSHQrTPFvzq+9uGgppw7Xsd+b2+AEtcFaVmBY9wVA/6YV8JjCnpA8
         Xgzm+oNgDOMMgJuz8p/vISIly9fV6FeQUQfVYjPgm0aC6zDO3bbRABPNvY8ROAqsxnIY
         GX/uWCiUPfivRDZfoO9vcAzZSebDcsdsfo4yzGDQbfoacF3FQZE+YoME+FRFSZOOgXps
         Kr0yPAhtv17/0+FSm4jLVzVc7I4sskE1beWfYS9p+juD7WjPcYjDR+O05FE9vQh7Z4zK
         dZ3/2cRLn5fFAoLJIh7tYtts1fpTvWbgnhlKeGob0JSEaZgkHXUH/oRYOXt48EgF9zj+
         U0mQ==
X-Gm-Message-State: AOAM532xlbJkRnHymG1gRGFx7polHQbHuHPZ8fHHlEeOzYqPVoRQbMoP
        woBR/URwk9f+XaHb+E2HTg==
X-Google-Smtp-Source: ABdhPJzPuB0aV5BPZHFyL3PqONSvn97TrtwHbAaJWqyt4VFlBuK0g/hmO8O6Lc74G8axDPciGCWqEg==
X-Received: by 2002:a9d:6b10:: with SMTP id g16mr8239666otp.301.1607657385175;
        Thu, 10 Dec 2020 19:29:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7sm1447318oou.11.2020.12.10.19.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:29:44 -0800 (PST)
Received: (nullmailer pid 3579485 invoked by uid 1000);
        Fri, 11 Dec 2020 03:29:43 -0000
Date:   Thu, 10 Dec 2020 21:29:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        David Jander <david@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: fsl: add Protonic PRTI6G board
Message-ID: <20201211032943.GA3579435@robh.at.kernel.org>
References: <20201209130016.10431-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209130016.10431-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 14:00:15 +0100, Oleksij Rempel wrote:
> Add Protonic Holland PRTI6G, iMX6UL based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
