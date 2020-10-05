Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEC283194
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgJEINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:13:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2FC0613A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:13:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so8427450wrw.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4j4QvxQFPIdjM0NymHg9aDCccSJMx3lPNQ3ZZsRnW9c=;
        b=lOBcNVcbkKoNhgnYx2j3l/8/rE1EovMe0uiEZoQ3F3dBUYXZn1FRWR0+sD9F31Sdxn
         wgGbBYdiv3YOJT0OrzMBN+7iN71myGFfaDWdq8WcJE6RRZ40jkQFPTlnTClarl+i+eVr
         80nH6zYU/mPYfHx44fEn2fHOqDGt9eUiVHMWmUV3LJLJm+Lry0UUlOSZPJ2XeydzvK9e
         SKdPBcU8jWbnaNUGfwBPqejrTVx1GGA0HtAilj3c9zmlkMfheaNSunMB0SF46FA2cPLp
         SkaMQ+wClu9c78EsJXC9Jsva+Cs/BiRV57lTf1EvcQJhg+lF6Ja6XNlnFGT0XezhOZhI
         0eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4j4QvxQFPIdjM0NymHg9aDCccSJMx3lPNQ3ZZsRnW9c=;
        b=buHPKjPq08DJc1GaONp9KP0rPSvYVhnmrnMUEt4oUdZrjykKWoQ4pogt8Heb9Eitwb
         88pxn/MBNwa2m0gEYW8RXqdw+8kqLCwxb3+NNIVn5NZ1J60xZVujj+Tnp7RarXuuBYM5
         RxBUFJ06XwUT6q+2ztWbf+9r+6lYKiZOMzGmObV7evKvWtuzeyu5TxwFICFXMz/XTNmg
         zrr8iElFdZc7a9cwmIqO+K2EHeb7cOPpgnO1BghqBqzzjlJ008UlCDbFRxjtEEaWFGjk
         PRmY6d64Q3D6QnMjCtCK2qBVQbowA0ay5/VCIB9UqGEVZGTzU2Qf49c3XvwaX7PVJvN3
         3a/g==
X-Gm-Message-State: AOAM533TWCvrj7y1vGvV/JQMJAXDudkqYKOZNqPucyjPGmEAeQM5gu/B
        3ze6DQJ7q3cTcjXpXUeBSRRXhw==
X-Google-Smtp-Source: ABdhPJzcn3WGwQ6Bxl5YytCol9Xo+JbY5VHHuchADF6kmbtqN8Zjz20jZ4GTcwvZM4G/vSHHCWsqww==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr11023195wrs.153.1601885586773;
        Mon, 05 Oct 2020 01:13:06 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d30sm4972548wrc.19.2020.10.05.01.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:13:06 -0700 (PDT)
Date:   Mon, 5 Oct 2020 09:13:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Message-ID: <20201005081304.GV6148@dell>
References: <20200917193754.542-1-krzk@kernel.org>
 <20201002161334.GC4542@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002161334.GC4542@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Oct 2020, Krzysztof Kozlowski wrote:

> On Thu, Sep 17, 2020 at 09:37:54PM +0200, Krzysztof Kozlowski wrote:
> > Add common properties appearing in DTSes (clock-names,
> > clock-output-names) with the common values (actually used in DTSes) to
> > fix dtbs_check warnings like:
> > 
> >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
> >     pmic@4b: 'clock-names', 'clock-output-names', do not match any of the regexes: 'pinctrl-[0-9]+'
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Define the names, as used in existing DTS files.
> > ---
> >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Dear Lee,
> 
> Could you take it via MFD tree? There is a review from Rob and ack from
> author (Matti).

I don't usually take patches this late in the cycle.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
