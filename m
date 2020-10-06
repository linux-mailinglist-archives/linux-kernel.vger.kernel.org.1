Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77BD285104
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgJFRlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:41:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39830 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:41:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id c13so13462204oiy.6;
        Tue, 06 Oct 2020 10:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vExb7c7KjrT9+OOEUQoPKUdnD3na5MZSwBuAw9CBJ30=;
        b=m7aQGpkTSJhW2lFxLOeERzzYedATdJk/MG7bpHZAXKkRpmuIBl9HXUL+LNL5OEifYQ
         LgTG4ljLFUNpFNftAOhuyDFgMUl+y6svWkJCa4rhTIgm+mq5LuuC0NV2AIZfw7ki87XT
         XwUZRWMMz67hfORGG6NDWtaBXlgA4qcVs2rMTUVJLzNigGSqcXOrnnwa9ZuZApfCOANG
         dOVjFGIFvxCuf6QFXe0ahta7lVzrCOrWagx04/T38a01UcswAmPllUfS6JcjIvUOZqjm
         MfKGao1PtN9d+myCIdhuccvBZG1pno8hR/P3UVyjtZkb70vjU8RmQLSC7/IegKOvVer6
         dytw==
X-Gm-Message-State: AOAM531DX29jn8gHES42YFVgB+rXhgMHngTVDKFEqzkExIKj7yWda7VN
        KE7jfhg3hC5MtoPFR9BQOg==
X-Google-Smtp-Source: ABdhPJwzob3b/m/CNS9FFEI/581fuBwIdvALVsw8JcOYpQo3osIjbEyDzBYM98hWMbNXX66khhUUiw==
X-Received: by 2002:aca:d444:: with SMTP id l65mr3325166oig.29.1602006062207;
        Tue, 06 Oct 2020 10:41:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f26sm1263468otq.50.2020.10.06.10.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:41:01 -0700 (PDT)
Received: (nullmailer pid 2510360 invoked by uid 1000);
        Tue, 06 Oct 2020 17:41:00 -0000
Date:   Tue, 6 Oct 2020 12:41:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-kernel@lists.infradead.org,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 06/12] dt-bindings: arm: fsl: document i.MX6UL boards
Message-ID: <20201006174100.GA2510304@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-7-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:53 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6UL based boards.
> The Armadeus boards use multiple compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 25 +++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
