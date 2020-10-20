Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD929390D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393087AbgJTKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:19:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38836 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbgJTKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:19:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id b127so1247386wmb.3;
        Tue, 20 Oct 2020 03:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6OOn5EWOY5szB2ysNgFeKSOMlttS53b9pywoXspcgls=;
        b=FYfdsXzsdN2W6xK5+3h5Tmlr+3jON2mj5HxdMib7MJbkA3LQsELAwZOXNB9qgwlM2J
         2Pm8fZ7WitVlMxj3fnsdhhAN2LwNTy71YkQK/gjyZ5qa0Efmh/CUQNsnCiqkmI0GNZIu
         IOUzoYFVb4BODPtNvTRVyYqVnyYTl2A6dSj/OTezRaPHjIsm8aj9W5/biKfsd8bfVaIb
         S3xNL2j8QpdjJRUI1w21n6/j/33w8EuvvqyuoRu3eK276Ihqoyt69cNPLsN4/4KkjJxz
         MDRzNLwqaJ354rBZO2qNtQ+K0VxDbIZdphK7P7lbIPJksU2415GitOI8Kt/+PQYhOz1J
         svQA==
X-Gm-Message-State: AOAM531K/imYNGynl36WdV7iYsQPI21JahDwBoLCb83SkDB64Hcji7j7
        PpOxrkzomltAGtwHD8vqL+w=
X-Google-Smtp-Source: ABdhPJwZBgIw9mm2L/x+LNSfBZqIkshN8GqbfxWp4iZkM/WikfMeGdYmoWmLv5V1AwU6x4hsNdeQ1w==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr2194659wms.77.1603189170652;
        Tue, 20 Oct 2020 03:19:30 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id j7sm2221497wrn.81.2020.10.20.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 03:19:29 -0700 (PDT)
Date:   Tue, 20 Oct 2020 12:19:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: add Van der Laan LANMCU
 board
Message-ID: <20201020101925.GA118941@kozik-lap>
References: <20201015090924.6185-1-o.rempel@pengutronix.de>
 <20201015090924.6185-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015090924.6185-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:09:23AM +0200, Oleksij Rempel wrote:
> Add Van der Laan LANMCU iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
