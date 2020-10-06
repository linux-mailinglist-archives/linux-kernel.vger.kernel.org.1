Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1624D285115
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgJFRnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:43:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42219 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:43:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id 16so5836749oix.9;
        Tue, 06 Oct 2020 10:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mwAcsiPg8kwb9a2fJ4IXgeAamkL2NpRZhg1FCasjBn8=;
        b=OkjiSQ6ScBXg5rTOJXkWp1c1aVdWsqUCjXlnYdtKdadz27f1ZpYWz2bSI3yNfeggk5
         90n+/i/n7oClD6OhKxTOVtgYfM3UZfLhIK+tvWULWzUqNfgz2P6ZKxg5qUkSD0r4y+ma
         SfshNEaJWEbJUHHXt66HSXu88/DcNP+mYpJaFaf09Dw5ys0Q+QJM2x3QlhmgtODwJB1E
         NWD3+Q8upmU3KEwvR8EM3iDyB9UHl1JqvAOI7ShPhEiTYRvgdvauW+1hARF/9MIpmKHX
         /AUb7NbQ2oGBZhuXIFaArKINXEQ0xOWNfsZW2uZ7pY66IRdc/+JH4Bc/4HvgYEYl+eRh
         yGZw==
X-Gm-Message-State: AOAM531dYVdYzPbnLdfWOdg/wYVqfzqhh533+0jz38+sIM5BD6TWWYYG
        X+wlbHov9WwcM9eOhIt39A==
X-Google-Smtp-Source: ABdhPJzEAfdu96Dl64sjSquL2WUtdR+miWORqszYxAlQD+J1TOAaB4hdyaGuYoRdcPTfNaLs79EAkg==
X-Received: by 2002:aca:54c3:: with SMTP id i186mr760333oib.35.1602006209056;
        Tue, 06 Oct 2020 10:43:29 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k2sm1354047oiw.20.2020.10.06.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:43:28 -0700 (PDT)
Received: (nullmailer pid 2514544 invoked by uid 1000);
        Tue, 06 Oct 2020 17:43:27 -0000
Date:   Tue, 6 Oct 2020 12:43:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: document i.MX7D boards
Message-ID: <20201006174327.GA2514455@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-10-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:56 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX7D based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
