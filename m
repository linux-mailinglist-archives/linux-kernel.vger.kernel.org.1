Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126FD2562BF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 00:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgH1WA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 18:00:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36033 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1WA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:00:58 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so574756iow.3;
        Fri, 28 Aug 2020 15:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lr2PFn2vwVHM7+fNWOqX9WEJkm7KqjK2HFWWG2PzYWI=;
        b=ujU6xApffE/27kdt0eqg0ErVn0VFlWU3FJ2uTl/8bqvAXOyld74nfKfVAisVU1fXD5
         H4NsG0ArQQWoNjFrdx/b/s/+scF8SQjhzUtFSv7+oOpDgEszo4zdML6xLd9GDyygGT+O
         HvdVfj+GqHUMfEz+KgTFf04zO5FNBBOAcLWuT4eIW3EWn0O1ZVuViOFVCkEg4vsUXJ7U
         6s/DATCts/RnXysydigPe9GGBp9uQHqimJl3QRZBDzL/4nV105G8y680sCgu7W0ZiVrx
         S2Ed0nGGKidmGDTjgpEV7sfTTUfucDaqnLn9xC9XLGQNNHKbzXe+dyk7S/qjUEAJAOuU
         /PcQ==
X-Gm-Message-State: AOAM531KiYOUMnodfkRxLQN1yXRrf/MlfHJLPnaXCQanxZLRij4yf3Ci
        U+0BQU20C8Y5NwsXNKlPhQ==
X-Google-Smtp-Source: ABdhPJwUajkb1x4SMJ2q/35pgpO3PXguDCOOu/bVYvf01Vqr7eCAnPU1vl13/MZXhiRa5Qke1/RNlg==
X-Received: by 2002:a5d:80cb:: with SMTP id h11mr616301ior.189.1598652057793;
        Fri, 28 Aug 2020 15:00:57 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id r2sm312215ila.22.2020.08.28.15.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:00:57 -0700 (PDT)
Received: (nullmailer pid 3480425 invoked by uid 1000);
        Fri, 28 Aug 2020 22:00:55 -0000
Date:   Fri, 28 Aug 2020 16:00:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: fsl: Add binding for Variscite
 VAR-SOM-MX8MM module
Message-ID: <20200828220055.GA3480329@bogus>
References: <20200824191819.11057-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824191819.11057-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 21:18:16 +0200, Krzysztof Kozlowski wrote:
> Add a binding for the Variscite VAR-SOM-MX8MM System on Module.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Based on top of:
> https://lore.kernel.org/linux-arm-kernel/20200823172019.18606-1-krzk@kernel.org/
> 
> Changes since v1:
> 1. None
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
