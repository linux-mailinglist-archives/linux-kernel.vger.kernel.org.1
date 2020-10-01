Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2428025C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbgJAPRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:17:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34533 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbgJAPRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:17:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14so6054215edo.1;
        Thu, 01 Oct 2020 08:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SfROAKrPOCPvSx9FFy640qRrgbl3764HXo09vvIU9Jk=;
        b=FnqStRGWFTaPoRWlmt2AVCwV80k6HNA2x9tqRxld/cBIm4CJpHYjlEGkJjNdZD+ipC
         iENKhK11NfYjRy1qqL+9RRUSunGQw7avdtcOOrxZOJFoGndVguvS7TPPf/ABbKYk7b+N
         dvrb52GvTnzDbKy1Z6IrQEeUWjhxYL46e4216yoJwGwGR+hElR7YgbsFA2lQzWpv52bg
         GWfzCvD9za/RBbkZxt6H9NDLk4n+a7biPc66KwiNCKyQayDg6QNbJXHwOy5aGCwik/Kf
         haFvCG0ZLe2R/kr11/CcHzffxWFRuOc3gWNhL/EhjJ8H1J+SQuMR/lac/Cpzcv64JYuQ
         J+lA==
X-Gm-Message-State: AOAM530HBmaAayIyL4oLNVHbtyS2yQXZxe9yGwQ2fPTJOdiSMzouwwyb
        v+xPBPtFPKuP9UOXearBL1o=
X-Google-Smtp-Source: ABdhPJzKqq27FvaeGd8ZWQno57OjAUnHP5YzHlIUwBMucUmpUpNKAnrSDCCwfFKC2VQhX/DWc5Fi1w==
X-Received: by 2002:aa7:d488:: with SMTP id b8mr2404330edr.21.1601565439592;
        Thu, 01 Oct 2020 08:17:19 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id u15sm4251040edq.96.2020.10.01.08.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 08:17:18 -0700 (PDT)
Date:   Thu, 1 Oct 2020 17:17:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?Q?S=C3=A9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8M Mini
 SoMs and boards
Message-ID: <20201001151715.GA14276@kozik-lap>
References: <20201001151422.16028-1-frieder.schrempf@kontron.de>
 <20201001151422.16028-2-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001151422.16028-2-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 05:13:38PM +0200, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Add entries for the SoMs and boards based on i.MX8MM from Kontron
> Electronics GmbH.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v5:
> * None
> 
> Changes for v4:
> * Rebase on next-20201001
> * Enhance SoM and board description
> 
> Changes for v3:
> * None
> 
> Changes for v2:
> * Merge the SoMs and baseboards N8010 and N8011 into a single
>   configuration (N801X).
> * Add Rob's R-b tag
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
