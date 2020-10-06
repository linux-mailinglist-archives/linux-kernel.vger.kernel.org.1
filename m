Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E232850FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgJFRj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:39:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34986 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:39:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id w141so13447995oia.2;
        Tue, 06 Oct 2020 10:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KrIywMkkj30dni9pYK4OxfODVyuIecBdtl1hvyykMzM=;
        b=PPlpo9zwj2LRJd5p+JxqXXyUe1fhLH3DoZGDfDNCdOpiCYxPR1BmOy6vbdIPnlfzBS
         SFIhOTtKsXN1r07fkgVGmgIVxg+tUj/wjoNbyIO6pbZP1qwWqhnXeCYwN292zaLYPtrV
         wA5GmWO78vznWWp5Vv3BXlYbfv3YossQi40Wc3rV5jVnvQn/qVISnvAxzeGUNnm4/MOO
         SMAiE+/ecxFeJOVL321kcKOOX58WQdUvfbG6KELip2mwc4sq8X/JblWsLJPujEOE+VvW
         dUje4NJfqwhdCOulR5zhLya72yxTckWNQ4NlA42yloREsBwwMT5JTWSCnRDOkgowjGb2
         i28A==
X-Gm-Message-State: AOAM532psixaekkVrZCtS8fDHX9TZBef+daLv2Z4K5N3+MSBuoYXd96/
        Lfj9hRGHuBWX/7KeJ9Nieg==
X-Google-Smtp-Source: ABdhPJwM2uWi8P165b1MuB5ZhzM2cFGoBQYzQASSfCbHsQ6XW1L8QuGAky5qImMhK9DfRSO0yVqYAw==
X-Received: by 2002:aca:d946:: with SMTP id q67mr3399004oig.27.1602005997602;
        Tue, 06 Oct 2020 10:39:57 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h15sm1247436ooe.42.2020.10.06.10.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:39:57 -0700 (PDT)
Received: (nullmailer pid 2508348 invoked by uid 1000);
        Tue, 06 Oct 2020 17:39:55 -0000
Date:   Tue, 6 Oct 2020 12:39:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>,
        Robert Jones <rjones@gateworks.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 03/12] dt-bindings: arm: fsl: document i.MX6QP boards
Message-ID: <20201006173955.GA2508317@bogus>
References: <20201001170759.9592-1-krzk@kernel.org>
 <20201001170759.9592-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001170759.9592-4-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 19:07:50 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6QP based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
