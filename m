Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A72B18D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKMKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:13:43 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A02C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:13:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so7861340wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5mQzlYogPLBFA1hajOVZ1RXKWdd6CHk6EwMF1SaxZUg=;
        b=MiRnWxsHbekeURrx09fXwFZ6xffCTva7JK2cNHIVBmRectDVyPn0D+r7z0R20Pla3C
         NL4kZ8EAjqi/ZdGvmCBSoW9/W3kby2HCsnAhvUNxaobRfgAela8uVWtdnC6XBwxaOn3g
         qJ/tdqnxxNogXeEuzLu4RG9Sm1BDat/u83cNn2oq0L2YbN1nNEoObWiuigRbZtFw2cT5
         AM/NmdC7+2r9LYt33Ol6wg+f38fwHVUhGgfOfuxypiRN1GRvmhFTqHvFIDnHXsobfL1m
         5lhgkRxUTuwlWDf3UmcZQJcHTOVYRquD8SoZ9/UAC1eBBTfdM6qgrCiEcMm8E7Los6r2
         zSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5mQzlYogPLBFA1hajOVZ1RXKWdd6CHk6EwMF1SaxZUg=;
        b=d81L0rGn7Z8mu4nio8Ku2VGzzpOleXITXrrZgZByr1416FwpG2gWTSvUk5qmGo+JQ2
         Bn/zXcYYdbq/9v9MDPevIf9gSdK6yh+sjdaN1YRnKqGW7uLqi3WotqC/YB+W7tsv3Xk9
         Qu0NZeKKvntwso4eqjl46pkkV83GuHFw49ZlWhPKSc0FnOe0Pqz5+sH3ISTiCBvHYSdl
         LcEZ2gvZQrDMo4QSO6u8wKjwOk6rMfV75AiLjiLHVX/39e6oMtpuC1mhWq5OxqIul8Og
         hcfh6hh4fHyO8dfTRoL25PQq3dQymN2jRsQJsoD+n95Y9gMp8DObL/lp1+2vpkmLcAXg
         pexA==
X-Gm-Message-State: AOAM530Mo5UMsTWLPVhBzdSZvA+T8TVui6CW5ExXHMUVKANpilBieaWF
        0GJ0IBl4G9mMiSDwK3TvpNWB+w==
X-Google-Smtp-Source: ABdhPJwrV1ZixxdmiCqntujt5PYv120gMZxmnKnC5GtVGQWdk4Y4AobI24/b7/K/CsarXRa+ZyZGPQ==
X-Received: by 2002:a1c:7c02:: with SMTP id x2mr1674923wmc.64.1605262422247;
        Fri, 13 Nov 2020 02:13:42 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k22sm9473879wmi.34.2020.11.13.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:13:41 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:13:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: MFD_SL28CPLD should depends on ARCH_LAYERSCAPE
Message-ID: <20201113101339.GE3718728@dell>
References: <20201110155727.3287083-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110155727.3287083-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Geert Uytterhoeven wrote:

> Currently the Kontron sl28cpld Board Management Controller is found only
> on Kontron boards equipped with a Freescale Layerscape SoC.  Hence add a
> dependency on ARCH_LAYERSCAPE, to prevent asking the user about a driver
> for this controller when configuring a kernel without Layerscape support.
> 
> Fixes: a538ad229bbee4f8 ("mfd: simple-mfd-i2c: Add sl28cpld support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Michael Walle <michael@walle.cc>
> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
