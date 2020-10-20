Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1431D293BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406156AbgJTMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:34:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56143 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405905AbgJTMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:34:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id a72so1602510wme.5;
        Tue, 20 Oct 2020 05:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o05XnIP+Bg3BaL7qnMAypA1wj6djC3Q9AjunxR2fiXE=;
        b=pXV8lgBeQNQSMcM2S4wo39+5MEzS1OpESEUIFFYyhm/HuNj8tt+uxZFjaA5fubhdGE
         CrM1aM9b5V6PvARztzJrtAgLGMD37cDFhdvpOtH9w8eDUol+2IVXlLqeYR2bho5Ds/eh
         IvENOr3BrPtHCg9WLqIT3yA34HyZ+VAYddAsDA4oVNuDOIbG0ozshJy+SuDTNLv5C/ET
         jgv9QM9+xNksL5PxyjfCNvPRMnlmYfwTPIbjjMMx6JVVounDhlB4XUtrVBhwfgHG9bEx
         y440BfK25POcDCZohVirwXTRu8xswrKoMuXrDLZTmYkarDnUilz81Elfh81ATfz79aa8
         T1Hg==
X-Gm-Message-State: AOAM5312UaZHfp1DqUazGKhDw88BvbvU07L8oSFQY5x0drwxModBLfJd
        5BMV50xY0xtwSt1zeXZP/E0=
X-Google-Smtp-Source: ABdhPJwBRAsCi93ZLg6efPLo+MWBmBwBPiFAgJGSZxHN3kxdrnWuhiAWc+LcQZlxoXTxlsITeFwVpw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr2762243wme.116.1603197248325;
        Tue, 20 Oct 2020 05:34:08 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id n9sm2774115wrq.72.2020.10.20.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:34:07 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:34:04 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 05/29] arm64: dts: amlogic: meson-g12: Set FL-adj
 property value
Message-ID: <20201020123404.GC127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-6-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-6-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:35PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the property is supposed to have
> uint32 type. It's erroneous from the DT schema and driver points of view
> to declare it as boolean.

I think the driver uses it as u32, so what do you mean by "declare" in
context of a driver?

Best regards,
Krzysztof
