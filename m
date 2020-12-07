Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2712D1C5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgLGVvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:51:31 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:43987 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgLGVvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:51:31 -0500
Received: by mail-oo1-f68.google.com with SMTP id h10so3553580ooi.10;
        Mon, 07 Dec 2020 13:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y00t2oYRElieWgTY/6XuDjnfPbdFMkmUpnhoZk4N8+A=;
        b=uGUEH/paCVJYlUZ00TOnTZMhyc3UM6IFaiMMr98BfhCdoaX0gQ9819OfezC6NEGn7a
         bm8LvuX+pkWJh0CA9e0Eo3EPV2gjf2lT5N2JYYX6GluFoHrjywNR8Bmr+IRTOMbsOQND
         5LIozUbmpnNN+vWKPuZLGDNrgME7reMTHqAQRJriG5yhLFYiMmCy43+zbOeDLP5AKOEa
         +0JBly2DDrf6nZmKe7BQCYdyiyhQBqPHZCv5V4Bsgsrv5Vhy5KNc2HDFFzpZ/mYyWte1
         oi7e+91C8GiqpSNgq2J8UCH9i5CcItLHUDQzQPxEvzQMeKN2wkXYGfl2tn3DoAqxlLR2
         v6Xg==
X-Gm-Message-State: AOAM530yyk0cGc4NTGx9IpiqxsXrl/Kd500hVNGsXz87mSqPb/K/KRuQ
        nc1G6VyMZnJN74cdZKeQPmqEFXBM1Q==
X-Google-Smtp-Source: ABdhPJwb2IaEXWi3OMiPgjPWwqgmaaPWBuvmoqhndlGB30/d4e3V6/PtzxNQIRJlhdZ6dIPrh/Z4nw==
X-Received: by 2002:a4a:c4c7:: with SMTP id g7mr14071462ooq.50.1607377850811;
        Mon, 07 Dec 2020 13:50:50 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q3sm2504232ota.53.2020.12.07.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:50:49 -0800 (PST)
Received: (nullmailer pid 894193 invoked by uid 1000);
        Mon, 07 Dec 2020 21:50:49 -0000
Date:   Mon, 7 Dec 2020 15:50:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] dt-bindings: Fix typo on the DesignWare IP reset
 bindings documentation
Message-ID: <20201207215048.GA892840@robh.at.kernel.org>
References: <89719d8d40048e9b7baa0cd984b5bb108d056de4.1605741519.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89719d8d40048e9b7baa0cd984b5bb108d056de4.1605741519.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 00:18:39 +0100, Gustavo Pimentel wrote:
> This patch removes a loose "i" character is present on the current
> documentation.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/devicetree/bindings/reset/snps,dw-reset.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

But really, rather than trivial fixes to txt bindings, convert them to 
schema instead.

Rob
