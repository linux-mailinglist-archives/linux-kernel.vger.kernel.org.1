Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4825C2C2200
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgKXJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:46:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44892 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgKXJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:46:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id l5so20146249edq.11;
        Tue, 24 Nov 2020 01:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tIHVa6fXvLu9MfrKVTfUO6b7KR8yn2I4/kmdzRonIY4=;
        b=uMbDdkvxakzCUy38HDvGv1HYA0xZunBty+Q438LzrI6trLaeiUKYhEb19GIS00xPjO
         ApOGh0OI4mstoAJXpMU28TdtBh/Fvgn/B93/6aBPno67RYvfA2zf/5ZDPYCJSwhLCjJq
         Cx/CGw9PycV0DqwX/HvqHydvhMgeAzRpm6sgE4Yt3Xo+zq17qYp5q/SzsvTLqc+q4M5z
         4tk9b+BbvmolkHQevUFXfx4jITY7k6fPebOqFJtvUI3jCMy25GOhjKGve2ytqtWUzo1w
         YVVdiir/SK2Abh1FgVGivot/5oWBpFH48iQsRYjJc0BYir+mew0PJdcIP23FwYDjUH9Z
         Nvkw==
X-Gm-Message-State: AOAM532RV5b/cpE5T7Kd0hsY9HClZU2+kgq05I2iwjWNwAh/XLRKJ27i
        zCz6W+eT8Mxtvrl6YqhsnNCEHR8LYVg=
X-Google-Smtp-Source: ABdhPJxrh1crV84cFi+a6KSbhPbnpuo6yjbqX0e2xAsIXPqYRNljalmNBQawbeg2U8dO9DbREiNAOA==
X-Received: by 2002:a05:6402:1777:: with SMTP id da23mr3213568edb.116.1606211162868;
        Tue, 24 Nov 2020 01:46:02 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b9sm6505837ejb.0.2020.11.24.01.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 01:46:01 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:46:00 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201124094600.GA15030@kozik-lap>
References: <20201124015949.29262-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124015949.29262-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 09:59:46AM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

I already reviewed it.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> ---
> 
> v2: remove the subject prefix "LF-2571-1"
> v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml
>     modify the description of nvmem-cells
>     use "make ARCH=arm64 dtbs_check" to test it and fix errors
> v4: use allOf to limit new version DTS files for i.MX8M to include
>     "fsl,imx8mm/n/p/q-soc", nvmem-cells and nvmem-cells-names
> v5: correct the error of using allOf
> v6: none
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
