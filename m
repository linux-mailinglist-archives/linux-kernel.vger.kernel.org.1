Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B031527D625
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgI2Su3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:50:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35167 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgI2SuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:50:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id s66so5511608otb.2;
        Tue, 29 Sep 2020 11:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FlY36t0lFmSG/YEvAXZ1c3DWMltvR1kv4E6I0v2DXSI=;
        b=Mo4EhGnRaNaQFJ/A2yhNo/rgz8ptOxjqdL73ikdx20VfILCviD00wvcRU1NLZ06HT5
         pLQCL1tY5riG88Nc70eCfuob4N8wHbyqTGcaghX4Havcidz5zfv7mSGs0JGYX7PHNqWx
         cme8t8nEeTjVS9j0uDHkB3qoWP6hKmyZGn/19SpsqNczSVQWhZZqp+pDSSMYl9nL/m/J
         m2MtBQTYZqhbE4YuzmX8h9SqVyKWcUa5H1InJdg7Rtxc4TUMM2pZTYIzmNcIyX5hv9rd
         2DEhAGLHM56J/wPyYhJcxNsiuiFLVk4XYvESbxdfCDYwsJiUfiP0EpP7/eqDK/W91MNb
         DgOw==
X-Gm-Message-State: AOAM532q34pYun5hA4gPt2TdMXgEievHYU8CvdykCF3hzMKc13sdS91D
        NfWVIoUBFXmLa+UI0yzYmw==
X-Google-Smtp-Source: ABdhPJxeT2mQJ6sjFhni6l8SuAbEzbsIDMANxd+3WvcyMMsKV7IcExTq3d1wBEt9nCzGwCxEEG0+qg==
X-Received: by 2002:a9d:1721:: with SMTP id i33mr3595627ota.366.1601405419948;
        Tue, 29 Sep 2020 11:50:19 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o205sm1183869oig.8.2020.09.29.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:50:19 -0700 (PDT)
Received: (nullmailer pid 950972 invoked by uid 1000);
        Tue, 29 Sep 2020 18:50:18 -0000
Date:   Tue, 29 Sep 2020 13:50:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Jander <david@protonic.nl>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add Protonic WD3 board
Message-ID: <20200929185018.GA950920@bogus>
References: <20200924045706.23496-1-o.rempel@pengutronix.de>
 <20200924045706.23496-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924045706.23496-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 06:57:05 +0200, Oleksij Rempel wrote:
> Add Protonic Holland WD3 iMX6qp based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
