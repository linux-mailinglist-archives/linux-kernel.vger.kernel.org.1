Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8902F7E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbhAOOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAOOmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:42:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:41:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d13so9488012wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 06:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b1a2K9NoOIzcPI+2Z+x6S9t4pqcr2xwGE88bWHnXgcQ=;
        b=axxIY+OfqmEIm1BX2dM8JwMeoF2YzxfNaRhfpskILn9N4YGE3hlYpbhFvyklSNacgB
         7H5CPHeq8n5HJybix8I3QiLEzY6jecmamH5z38f9LjIEMxApJQXfm6DUDZOqThlAhmi/
         JCZt6GBE+sA/dlfeE2QB1bAk9IgtZREHahVkHLa+0BJG59tVIobYgBtup9RyGCLwFFOK
         YJ8T4n7JGTK7Co9QKbfBQXPo3yKg/axTE2E7L5E98/QhNIRzhfp3NhA/Xhc0QljkR5WM
         RLmQpx9Ofp06oIxIEaCHSGiiRwdb8iRfez9q4CPbN9ikmpRC6n2d28E32gUQzMvgBQgl
         xW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b1a2K9NoOIzcPI+2Z+x6S9t4pqcr2xwGE88bWHnXgcQ=;
        b=XkoSy1m1ET7rUKXAqXDm1Gj5SPmp6+TQAJQSMtBdMof2/HM1hCLM30rMyWRN6NC8t+
         DRSMU9Thoa5sPJYWsxyu7lSPtENGMpiReRudKGX0dbh7Tzorv9tHD3z+f4PM1131wqIC
         UPwjJEriTAE+sZ6TKYUQ6bj5I9FM5Zi0gpMxqW4pFRxbfcxa1ZRFL5ZtoBspF8LJBtZQ
         caFNfhqxUoABYIJlLxzH5emJeGA6q+POxO6GIuDl2K9NhEgBiFvaemaviPhxgpR6Fr7n
         sCFJVyVQAl5J5h417Tbpckcmpvl2bbyiqD02W/TTK0VA7EB0Wj5viBcFEq/StXiUafGz
         fcNQ==
X-Gm-Message-State: AOAM533FM3m+616oi6IrB+SrDP2F0zLNBOimJu6zlTfTTxHnfTyBv47K
        SIST4p5BxSfnDyLbwIYalz+NaA==
X-Google-Smtp-Source: ABdhPJwJX3QAttN03UsnU2yl39vAx5s7+MfY45HApEEA/49i7KPkjri2lPq4vo2Y7Jxivfy05fYFsw==
X-Received: by 2002:a5d:470d:: with SMTP id y13mr13498157wrq.309.1610721695771;
        Fri, 15 Jan 2021 06:41:35 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id f14sm15362239wre.69.2021.01.15.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 06:41:34 -0800 (PST)
Date:   Fri, 15 Jan 2021 14:41:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Message-ID: <20210115144132.GP3975472@dell>
References: <20210115143332.GA721433@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115143332.GA721433@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021, Matti Vaittinen wrote:

> The ROHM BD718x7 and BD71828 drivers support setting HW state
> specific voltages from device-tree. This is used also by various
> in-tree DTS files.
> 
> These drivers do incorrectly try to compose bit-map using enum
> values. By a chance this works for first two valid levels having
> values 1 and 2 - but setting values for the rest of the levels
> do indicate capbility of setting values for first levels as
> well. Luckily the regulators which support settin values for
> SUSPEND/LPSR do usually also support setting values for RUN
> and IDLE too - thus this has not been such a fatal issue.
> 
> Fix this by defining the old enum values as bits and using
> new enum in parsing code. This allows keeping existing IC
> specific drivers intact and only adding the defines and
> slightly changing the rohm-regulator.c
> 
> Fixes: 21b72156ede8b ("regulator: bd718x7: Split driver to common and bd718x7 specific parts")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> One more attempt today. I did test the driver is not causing a crash
> when load but no further tests concluded as I don't have BD71837/47/50
> at home. This looks now trivial though so I decided to give it a go.
> Sorry for all the trouble this far - and also for the mistakes to come.

Why don't you wait until next week when you can run this on real h/w
with some pretty debug to ensure it does the right thing?

>  drivers/regulator/rohm-regulator.c |  9 ++++++---
>  include/linux/mfd/rohm-generic.h   | 14 ++++++--------
>  2 files changed, 12 insertions(+), 11 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
