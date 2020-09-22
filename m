Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35002273D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgIVIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIVIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:14:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504B0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 01:14:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l71so11331898pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VvRTHWq9atT0M2ZBSCyp6rDibMZAJDzlcA9mNUPSa1Q=;
        b=UIsiyD65QwMGiOab0ykzjaRHAo1ydlbju+cn5iZoBvahS1pS6vUlqWCapZgjLSeHaN
         PdB9uj3WYuSdOPKVH1nwPcYDHA4EXJU36mVbBnBAAxrSytNZ/81cgPdZdDLOQc6hjVus
         rDX5iZP8/rYc5sX7xUIxbJfIx34Zba5RDrwM3V7zvnTH4z1p3CuJf5sklEocne0UScwE
         Wnug7L2foNRamyKS1UdgsVG8yhMYE2F8yrojPsAOACTpqHxpv9x1VZKO2NjB/H5ocwvI
         7LHCvg0yy/5qXNjHtwtBhzZIG/WI8WpqRDQwvRxepxofyb/4T/44DOpZwkMEukcDfwal
         9FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VvRTHWq9atT0M2ZBSCyp6rDibMZAJDzlcA9mNUPSa1Q=;
        b=ftDkYl/Ydf0ZMmCM82tPs7go8mTnsD1SDSEo9eVBkL4CpHme+4dK7jV8pRA6FKUlbB
         MASJTuJmfCaWT0zH3w9HvhAjMTCkC+UwuN9pzhbLr0xBr2rUyCyMgwzrbePnpkbV58oG
         iuwlsoUeT8L7R/HSrroIKpqvESmTZcARTvYMkh0L4bFUlc0OmyH5z04TQJiAso4EgHKv
         /VS37+DDEQ/qDvGaoiFpePVG/PU0VHD05ZvVnJtAlo5WS6KfH0HPn0Zn8ZucuE1oyhz8
         uxsP9ZnkIlCpcDFIrCXciEVB9WoQO3i7isafGG8U5xrzyr9c6QUVL/L3o7FGZPZOB+sD
         mY5g==
X-Gm-Message-State: AOAM531ljLEMjV0Q32qr11agkcmLW8DF/9zoKnAkOPY4wdxErNqUfgJR
        KA+Q/EqyI3JmdMV9dnaVuxm+
X-Google-Smtp-Source: ABdhPJxXMg3Nn0XGG3SBhoXi4mamnDNcOX3VjcS+UMVk72R8qDISYWh3+KAXOZRb+pZ58Ei82a9m6A==
X-Received: by 2002:a63:d918:: with SMTP id r24mr2597057pgg.158.1600762483807;
        Tue, 22 Sep 2020 01:14:43 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id m25sm13846459pfa.32.2020.09.22.01.14.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Sep 2020 01:14:43 -0700 (PDT)
Date:   Tue, 22 Sep 2020 13:44:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 1/4] dt-bindings: Add vendor prefix for Caninos Loucos
Message-ID: <20200922081432.GK29035@Mani-XPS-13-9360>
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

Applied for v5.10!

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
