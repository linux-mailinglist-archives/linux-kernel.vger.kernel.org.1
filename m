Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51262216AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 22:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGOU6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 16:58:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45345 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgGOU6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:58:10 -0400
Received: by mail-io1-f65.google.com with SMTP id e64so3731629iof.12;
        Wed, 15 Jul 2020 13:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q00alp4H8NoDtaELTDIA7qLXG/9bPROO++uuIaCrnXU=;
        b=EGv4qMu5IEgQ8hLuH4xgPn0DL/ak3Ip+UVQJbhSp8TFhlJay35Lb7OICmuh+YX/53Y
         SSwjKMvmyth233d+FrXA624A7kKTPPh9kPZFHCxwHijrJcHTzWLWzLgF4CQBluNcmVGH
         47ifU1tD9syk0kp4SeMQNl1TZjpGVFoMdbJiDkjw2ES3O+2soZgJkT67x1WtWlhFR9Ry
         xN+t3PV7Buee8cd0IJrBMEwFfTtv8T5m9zW3NS3c/2gtssWmu/AzjIlUV/01ZidsWnV1
         9v+FUmUMQrhSSTdjNZOscIdABeM8yrl0/MztdclWlWIArha+pNNiFzz6TD621cn8i7hg
         tRGg==
X-Gm-Message-State: AOAM532V9vVJrBV8OtT+KZulA8dnk4zcqZzIPsnD5/sOm93PEKS79gxj
        MmBhFKBAagXfdR/qTFQCxA==
X-Google-Smtp-Source: ABdhPJx0LRYwvKz6St2wnD2gjzlcrImfz2qeNJTnf16/1y5TiVGZkyD6Xy7hmkDVjlC16PMbUvnCfA==
X-Received: by 2002:a6b:c410:: with SMTP id y16mr1178290ioa.75.1594846689751;
        Wed, 15 Jul 2020 13:58:09 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p124sm1681111iod.32.2020.07.15.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:58:08 -0700 (PDT)
Received: (nullmailer pid 804546 invoked by uid 1000);
        Wed, 15 Jul 2020 20:58:07 -0000
Date:   Wed, 15 Jul 2020 14:58:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jones <rjones@gateworks.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        linux-arm-kernel@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8MM SoMs and
 boards
Message-ID: <20200715205807.GA804345@bogus>
References: <20200702143337.8590-1-frieder.schrempf@kontron.de>
 <20200702143337.8590-3-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702143337.8590-3-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020 16:33:07 +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Add entries for the SoMs and boards based on i.MX8MM from Kontron
> Electronics GmbH.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
