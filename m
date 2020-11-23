Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A92C1122
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388104AbgKWQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:56:48 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41197 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733040AbgKWQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:56:48 -0500
Received: by mail-ej1-f67.google.com with SMTP id gj5so24310741ejb.8;
        Mon, 23 Nov 2020 08:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hxvf5ckkSe3OXhzX0J+DbLitEVXMZZ90l4Ivr7vuqTA=;
        b=ZewzdnokQsPC7EIxfsmYX8K0HxREH/5hLdupW8/kw+qOojhSRmiX1N/aAXqvQsr3RS
         oSL7JfqmdjzAc5hEhVMx5jo4SN8sIEwH037Ay7jkxwWjUC373ghdXYTk6VIxHFH/I+fL
         hHHtIA2RtKAW4RPAyQg0Z6vy05P9dOx1HsHE9XuOBTQNaURJEglEfKTgEQ1WzbS8pJo5
         S43Qza7CPndabn7zINNsrcrvkfKj1fMt93PDyGRt+bUsX/HTwyYiI390KPRgSEjoVlCh
         DPWMlD91mvH0HbuQoRmOB7NX6ggye2LCgR/2JJHPJMQOTCeBiAOB3Agyv9IJQKZG1wLg
         B/OQ==
X-Gm-Message-State: AOAM531fDNGXN1e22VSp5Yc0cJcsMBdWjhMmbAvpe8zEnJ4K82ufbTOA
        +D6cKm2SuA/cvTGP4PBDxqg=
X-Google-Smtp-Source: ABdhPJxD7dv4JMUU3i8uZZaxsCP/0JysWa2EN2bgDtd+86i0MSVO2XhNPmWGhXwASDU1HLdn3eLlng==
X-Received: by 2002:a17:906:3153:: with SMTP id e19mr473511eje.17.1606150606412;
        Mon, 23 Nov 2020 08:56:46 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h2sm5290943ejx.55.2020.11.23.08.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:56:45 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:56:43 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Message-ID: <20201123165643.GA214677@kozik-lap>
References: <20201123095108.19724-1-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123095108.19724-1-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 05:51:05PM +0800, Alice Guo wrote:
> Add DT Binding doc for the Unique ID of i.MX 8M series.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> v2: remove the subject prefix "LF-2571-1"
> v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml
>     modify the description of nvmem-cells
>     use "make ARCH=arm64 dtbs_check" to test it and fix errors
> v4: use allOf to limit new version DTS files for i.MX8M to include
>     "fsl,imx8mm/n/p/q-soc", nvmem-cells and nvmem-cells-names
> v5: correct the error of using allOf
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
