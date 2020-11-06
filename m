Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255C12A9953
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgKFQSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:18:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46805 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKFQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:18:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id q206so1825235oif.13;
        Fri, 06 Nov 2020 08:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EhTQGSWV8qbX17WJo7QniDym+nWP2AwIPm4714YKi5Y=;
        b=fL/RltQB3hwi0DJJrdCqebGD2kz8Nsb4l7Y9c7SDgL2HwZMZ9llDlLeu78YLf8Kx15
         QywQ6J5rtIcZgicI7jApTs2j0b7jdqGiRIWcObLLkBmUKRKxK/4iE8cKuLIZP2C3ZSWg
         5JevUHB1jV44SM4GR+1Hbzde9C1XdF0rWzCLy7PRwR1eydBLOFeCdv4XP/wkWac8H9vx
         6vkzjZ3e6R8RdtQUZD+J8XpOybhHtcFQ63hkQI3NptnZc6mZh9WITjdnJ3ybgfIemoTF
         J8iyX3hfa+RcWBdrk+21a3uADnUCRIWUJValIHn71bUQNDJGoMsrSsmG2dNkaGdzLQp6
         dVVg==
X-Gm-Message-State: AOAM533py8Pw2bxvzxMLgMwFCGtk3xyehMD+q76x+gm1zinaEOmVHciU
        +G9g7D9EgDgOXXR9yg00uQ==
X-Google-Smtp-Source: ABdhPJxTiSHPR5JU7ZoVX5mdpgmgKljpYTZlTZNcltn2K72QbZgWbvi4iGHr/mqfgeiswapHZf+l/g==
X-Received: by 2002:a54:4016:: with SMTP id x22mr1553027oie.28.1604679487775;
        Fri, 06 Nov 2020 08:18:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm346854otg.52.2020.11.06.08.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:18:06 -0800 (PST)
Received: (nullmailer pid 3299624 invoked by uid 1000);
        Fri, 06 Nov 2020 16:18:05 -0000
Date:   Fri, 6 Nov 2020 10:18:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        aford@beaconembedded.com, Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 1/5] dt-bindings: soc: imx: Add binding doc for spba
 bus
Message-ID: <20201106161805.GA3299281@bogus>
References: <20201106111543.1806809-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106111543.1806809-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020 05:15:39 -0600, Adam Ford wrote:
> Add binding doc for fsl,spba-bus.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  New to series
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml: duplicate '$id' value 'http://devicetree.org/schemas/bus/simple-pm-bus.yaml#'


See https://patchwork.ozlabs.org/patch/1395626

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

