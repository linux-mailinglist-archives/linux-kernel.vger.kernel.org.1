Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF7B273AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIVGZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgIVGZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:25:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EFC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:25:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so11494159pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jE8bKNUEYX0p9na0axQtlNwtSFGEl7YB1wgKxWCgUWU=;
        b=VALlm1wyfx0/Cl2qmHG0xEKmtzipNXQAe75b/Wo2/LsRYMsfDfyTMzFPM6K4ZY+Jqz
         BiIJdlrU/iediEjretvq2SRlfeAUWILvGIkhDEd5/fXBXJ7/sf6KxruA5M0sKfkNLONQ
         cLBgryhuaFYe/v4ZHO8nUj5f8bGwHJJHpZhaosUkK8ujell2OJtMf3yII7jdfuFwVko3
         m1T9dEh/fnNVo9KWIGbeq5Lv76HZ81fTqqJjRG0DkyiCLZZF8ULthvmqLJwHSev8WpSn
         PgrPLgXby2GYUJSJUuR71l2/2mdJEAiYb015gdcTRy79KHx+Z5hFjQNftwXgaexMmI5N
         Ab6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jE8bKNUEYX0p9na0axQtlNwtSFGEl7YB1wgKxWCgUWU=;
        b=kgbEB1IcCQT7V/ETU0UknAeyFR8R4F3LFVOxX/i1EXIIOkCcdXsviMnByElGPrmBJO
         ijqq5QcZlPg49gddCyxmsn0Ql++K5P4jqHWXXT6PSylNezm0+jpOTzP5u5N2LiAd/GXr
         JYJUNhd9NM7gUAI2uVChX0atm4+I7btZvoKBBChxI4NQvDJGq5fM1iDhBdij9XUVs0rs
         BZEt0Z6gVG5qXNc54uAUowL4TIMiHdUXU1blrZumzC9O3xQcPj/ydDRVIirTh6kWbPR9
         YP/N4R+S22DcIHkLvV2yejbMu7P7aQ6qfxhr3zaqTr2u71mwAmzmvJEdp0gaviBee2z8
         bfgA==
X-Gm-Message-State: AOAM5314gAX6ADujYq77Lw9ErjRnHwB5it5V91CxFaJnAEOUhsw14joA
        4vxVOmrbbaZR+KpQL5IM8p1X
X-Google-Smtp-Source: ABdhPJxDVgPjzYhXfkavSe0KLHyvdLTNY0mkMoL6BUjVuGvo3IGAtksWco8/leHEmmNKh4vklbmeow==
X-Received: by 2002:aa7:85d4:0:b029:142:4339:42ca with SMTP id z20-20020aa785d40000b0290142433942camr2819944pfn.5.1600755932793;
        Mon, 21 Sep 2020 23:25:32 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id 9sm760747pgx.76.2020.09.21.23.25.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 23:25:32 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:55:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Cc:     afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: Add vendor prefix for Caninos Loucos
Message-ID: <20200922062522.GB29035@Mani-XPS-13-9360>
References: <20200922024302.205062-1-matheus@castello.eng.br>
 <20200922024302.205062-2-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922024302.205062-2-matheus@castello.eng.br>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:42:59PM -0300, Matheus Castello wrote:
> The Caninos Loucos Program develops Single Board Computers with an open
> structure. The Program wants to form a community of developers to use
> IoT technologies and disseminate the learning of embedded systems in
> Brazil.
> 
> It is an initiative of the Technological Integrated Systems Laboratory
> (LSI-TEC) with the support of Polytechnic School of the University of
> São Paulo (Poli-USP) and Jon "Maddog" Hall.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andreas Färber <afaerber@suse.de>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Rob, are you going to take this patch?

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 63996ab03521..aac0dc3caf3b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -179,6 +179,8 @@ patternProperties:
>      description: CALAO Systems SAS
>    "^calxeda,.*":
>      description: Calxeda
> +  "^caninos,.*":
> +    description: Caninos Loucos Program
>    "^capella,.*":
>      description: Capella Microsystems, Inc
>    "^cascoda,.*":
> --
> 2.28.0
> 
