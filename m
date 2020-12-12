Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40D72D8428
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 04:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438026AbgLLD1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 22:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438004AbgLLD1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 22:27:13 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140ADC0613CF;
        Fri, 11 Dec 2020 19:26:33 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so8504323pgg.13;
        Fri, 11 Dec 2020 19:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4kixbiaTLgJsGXV+ExdUQR9g/IrBTwTuS3aGWFFjfHc=;
        b=XME6BObuwL5AgaFXG/sXy1JEyFlna7R6JGA3umlwGVIR1+smU0wA1VAwEZE3Dg07ED
         0F3QB6KKhEvy39afrK/oNDhc7PR5g12L2/S279nTF22G5X2DnbPRS8bYSjzD7PWWNgdF
         hrLMgN/mICg+IiLoth8NQk0+9kRWCKz1HLhXejnP2TSyrqFjzXZ/kcluPZ6pMu3tlJK4
         SpPkHkKDaCYqXlCef19BURhJHlBDLKKrhfqHgcK8GiLCeLGBAmqqpdCSJDGQ6Skm4L8T
         kM73efpNs6n5q4JIWZ5yVP2c1n6gM5tmjmR/KtwNDVZfk97zENRzm0TXF95HygvN3So8
         jAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4kixbiaTLgJsGXV+ExdUQR9g/IrBTwTuS3aGWFFjfHc=;
        b=qVJV8HhsjlXctYJq8Bp3PSDoc4gzjVb54ohvqQCAtI07GphKH8pZzMb46IRZKJNkki
         0n7hAvuyNLGb6oapiqAsnRZTuPNrnfbqkxLZ8jvuoquT7PpwwsxB77kVkz/6cUr554Te
         oGsGTVfQ/C2JeZhYtEqJ1NgWSnWs3aDEfF8NU2E8611mNGU6G5I8/1CDvDI4C7wQH+Ui
         c2dcY/QTI8yrDdL1jj5Av26uE9ptU9KbzZrT7eb+hBHFlkvn/MolkGyjh4ftoS9Inmgr
         mn+T5QQrhVZsnNOv41A8u9rGIPrm0YMu9uNkc79f/RpIgCNRp7GoHHiRRSAS23MgZG2Y
         BqrQ==
X-Gm-Message-State: AOAM531hCI3biygkH+z5Tr3wlh63Lhp1SgQW4EPxTTk1XNbT7ZTqXJ5n
        3OVLIu+CafMgSKR0laI21ZgHGk8XtSc=
X-Google-Smtp-Source: ABdhPJxJV2c5nM7U4+KWM2CvpWI8X+QiEx9+4aJWCvkBFSAxkCFJFDjD+vcvYpV5FoZ6taaHq1SkeQ==
X-Received: by 2002:aa7:928c:0:b029:19a:de9d:fb11 with SMTP id j12-20020aa7928c0000b029019ade9dfb11mr14797249pfa.21.1607743592541;
        Fri, 11 Dec 2020 19:26:32 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a10sm11822918pfi.168.2020.12.11.19.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 19:26:31 -0800 (PST)
Subject: Re: [PATCH 2/2] soc: bcm: add PM driver for Broadcom's PMB
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201211215942.5726-1-zajec5@gmail.com>
 <20201211215942.5726-3-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4d0bea20-1a3b-24d1-2d27-96f2f4fd48b9@gmail.com>
Date:   Fri, 11 Dec 2020 19:26:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211215942.5726-3-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2020 1:59 PM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> PMB can be found on BCM4908 and many other chipsets (e.g. BCM63138).
> It's needed to power on and off SoC blocks like PCIe, SATA, USB.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

This looks good to me, just a few nipicks below.

[snip]

> +static int bcm_pmb_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct bcm_pmb_pd_data *table;
> +	const struct bcm_pmb_pd_data *e;
> +	struct resource *res;
> +	struct bcm_pmb *pmb;
> +	int max_id;
> +	int err;
> +
> +	dev_info(dev, "START\n");

Stray debugging.

[snip]

> +
> +static const struct bcm_pmb_pd_data bcm_pmb_bcm4908_data[] = {
> +	{ .name = "pcie2", .id = BCM_PMB_PCIE2, .bus = 0, .device = 2, },
> +	{ .name = "pcie0", .id = BCM_PMB_PCIE0, .bus = 1, .device = 14, },
> +	{ .name = "pcie1", .id = BCM_PMB_PCIE1, .bus = 1, .device = 15, },
> +	{ .name = "usb", .id = BCM_PMB_HOST_USB, .bus = 1, .device = 17, },

Do you have to be more specific and spell out whether this is the host
controller (xhci) or device (bdc)? If not, then this looks good to me.
-- 
Florian
