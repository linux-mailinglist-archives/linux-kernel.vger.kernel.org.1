Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987982AACE9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgKHSp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:45:59 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36856 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgKHSp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:45:58 -0500
Received: by mail-ej1-f66.google.com with SMTP id o21so9157834ejb.3;
        Sun, 08 Nov 2020 10:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ypJHyCJWF+HG7FnMt3TbOQAd6qV1vaj6bcRrg3nAJsk=;
        b=lRZwVzcwvDfHP0kvmsaNMuS+1LZOuMVDm37dNy0bKD6/ZbAXxYvzPqyNorIUrKCNtG
         gsN+ew3BflwC5lX4utIhiBKbdMj8A6M08bngntIqJLSEstT+3TNgKLVH2DJeGv37TggR
         gaDvB11enfXUjHhUWKYKm7Ch++iRU+9NRdiQaDhEIbNZODDXVyH7MqH/J4vrWtiFyEU/
         fuoKi0i2/g3YBZrGS39SnXUzRJRHWOHpGeyknnbrvxrKYeee5pgj9p8v35JesKEt+qq2
         I/fwsssdX8UNCnGV5F5IRg6leDhOnbWY5Ae9ImjNzOELmLbRp7U7voHQKK45fjrGH3qr
         iWow==
X-Gm-Message-State: AOAM533iFFKalGvUdSv/Cz2RYICC7VmnHEx9hu+Yc42PqQ/OkARdvVa4
        Io2dmM3DhQwg0R9JBF0I6vU=
X-Google-Smtp-Source: ABdhPJwIxjwPKd1DKdMBrirMKqTdHxM6M+BihRlNqfx5G7Mr37NlFXLCzCOYWJuV9yopYWJXBU4mBg==
X-Received: by 2002:a17:906:5fd9:: with SMTP id k25mr12524584ejv.166.1604861155308;
        Sun, 08 Nov 2020 10:45:55 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l25sm6636831eds.65.2020.11.08.10.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 10:45:54 -0800 (PST)
Date:   Sun, 8 Nov 2020 19:45:52 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] arm64: dts: imx8mn: Add power-domain reference in
 USB controller
Message-ID: <20201108184552.GC7078@kozik-lap>
References: <20201107140026.1974312-1-aford173@gmail.com>
 <20201107140026.1974312-4-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201107140026.1974312-4-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 08:00:24AM -0600, Adam Ford wrote:
> The USB OTG controller cannot be used until the power-domain is enabled
> unless it was started in the bootloader.
> 
> Adding the power-domain reference to the OTG node allows the OTG
> controller to operate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  No change
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
