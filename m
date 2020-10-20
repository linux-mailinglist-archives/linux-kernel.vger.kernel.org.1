Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1C29420F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgJTSXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389047AbgJTSXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:23:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB75C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:23:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t18so1466450plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CGezKt8+BAuUHnil2rfwxd3Pmi+sSBHeojI9UUx5xrg=;
        b=OAUsMyidsIALp35M4Ul9aaHprY/IoitbkhQMJnLoTxMgoAUvC8SYA403Ml+x0KZYNC
         wsrkfQi8RGqUrEgJ7eJv95KV5fuFTsOv6nTVh7qz2yd3nHH431m4w5VXbHMxkSxRz1S4
         nZEFLMbVrgpVn96sqtaxERVn53hv0FEwKORJFZsW/hxAVdAH/NnWoaHbGzvL1C1xNaIe
         vyQ+WImL69bCtR/Ucn3GmIDZu7T8UZyHwJgzxRh4tf32u2Toquy+UKmexyKtBm7Q0blE
         tO5hS//Ln8XLFANDXI/zFozi3hQ5iVCzwzPTwB+/yMZkB7iGKH/T2JapvERkPTyN0rSW
         2mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CGezKt8+BAuUHnil2rfwxd3Pmi+sSBHeojI9UUx5xrg=;
        b=EvXhaqXETKwk90wfqV3tHdTS+nQH7O4drrU9wY8XCRnjRzk4DnTAf9a4MEaFDowgMN
         UGPr83xxgPmvCsCD5LtcvKbLv1NY6UVihtmaCHa3c4ixDAPTo42PejNy0vhdsf4q9Waz
         La43bSIzv/F5vBOv0+bJCIBPeHfVYiIfXOmBa/52OKVz/8oBPxF8YRa0VXQF4we9RRhz
         b6xVHKudUjRpf02irIAQS4Hmwu+mX5ro6/rxK+Scgdfd6U1a4EFzm+eg+49U7s7i8RGh
         7z/j6fL1rW+KWAaaXwiyqeunjC3u6zNdOyY1jqj8SRfLCr4fld3WxpvltNI9ZkgnbjU5
         GGUw==
X-Gm-Message-State: AOAM53219zA+ntOxUby8ODPe34jYPeFb+h/7MgMag4ZSB+txwkIASkG6
        KvIYY1FxVMmY8uZcWll5Goiafw==
X-Google-Smtp-Source: ABdhPJwJP/QHntOT4Ht2WctrUeVjfJBnner2IqBs3k6WUAjTpDxRuiWt9Ns5DdzA5YrNT1JRsVME0w==
X-Received: by 2002:a17:90a:bb08:: with SMTP id u8mr4090034pjr.227.1603218189255;
        Tue, 20 Oct 2020 11:23:09 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w16sm2860558pfn.148.2020.10.20.11.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:23:08 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, maz@kernel.org
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build as a module
In-Reply-To: <20201020072532.949137-2-narmstrong@baylibre.com>
References: <20201020072532.949137-1-narmstrong@baylibre.com> <20201020072532.949137-2-narmstrong@baylibre.com>
Date:   Tue, 20 Oct 2020 11:23:08 -0700
Message-ID: <7hsga8kb8z.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> In order to reduce the kernel Image size on multi-platform distributions,
> make it possible to build the Amlogic GPIO IRQ controller as a module
> by switching it to a platform driver.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested as a module on meson-sm1-khadas-vim3l where the wired networking
uses GPIO IRQs.

Kevin
