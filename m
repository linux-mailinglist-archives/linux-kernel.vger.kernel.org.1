Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838322AA546
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 14:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgKGNLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 08:11:11 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:37878 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 08:11:11 -0500
Received: by mail-ej1-f46.google.com with SMTP id gn41so5811945ejc.4;
        Sat, 07 Nov 2020 05:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGafpp+i4jByhexi5tog7qSIZwdZfavxkpUgKQbiKRg=;
        b=fuxL1yI3vIHiFFKJh5jwVyimpYLfs3OC73mtjqZ/kqzJBpZ3JbUoOfZ/h2dJ08/Ybw
         ICFAl0HycI4tcIqn87jQ9WWC8GwVMwGhBpajTrHut39nWezIhbw3HeadQaiy4dFrmgdL
         0xtYcuzy60QrrO7Fh8RP+0rhDwE4z3drd90W+5B4PlyfH3X3HCkPPBXiGqz58vS1YtRk
         tlUnG34nvb3C5ra9eL4jzTnh+ERhlHXYabPgqF58Y1XYdEVXSDWXiT5vDDVDiOtWxXQp
         vDbk0PXtmN+N0TPBhRjSeCk/l5p0aXdK02MzUe6sXxcnVNhxBj5nuqiMPT6+HLfPvtc+
         EI4Q==
X-Gm-Message-State: AOAM532z6oKcqqZI2otyRLZGrsgz8sMnIaM6M+rHIL3y6/CAQXkWjUks
        pyfqtmn1NfRQ/PfT1ZaRTKk=
X-Google-Smtp-Source: ABdhPJxyL1erdAP+jMIQZGb3iUoLuemsNsq/nYhAyOgNtJ8aP82hlF38S2/XB2NrFjPQjfFNZ/HORQ==
X-Received: by 2002:a17:906:13d4:: with SMTP id g20mr6631766ejc.206.1604754668852;
        Sat, 07 Nov 2020 05:11:08 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k11sm3322728edh.72.2020.11.07.05.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 05:11:07 -0800 (PST)
Date:   Sat, 7 Nov 2020 14:11:05 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] dt-bindings: arm: fsl: Add
 beacon,imx8mn-beacon-kit
Message-ID: <20201107131105.GA4761@kozik-lap>
References: <20201107123334.1868360-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107123334.1868360-1-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 06:33:31AM -0600, Adam Ford wrote:
> Add beacon,imx8mn-beacon-kit to list of compatible options.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Correct Typo and move to Nano section
> V2:  New to series
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
