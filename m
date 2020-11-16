Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1AEA2B4C04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbgKPRB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:01:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41199 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgKPRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:01:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id m13so19522084oih.8;
        Mon, 16 Nov 2020 09:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+JXrZYifKdUs7FbxLSzL5FeCPiKddkCqanejgp6YUk=;
        b=Pi2fDs/d1SwyUhQyyYgliVpIVHVJX2+HKMwZ5M8l/Hb9Z63isJ14a8Yz8+2vGTZysT
         gLMrW7rm+BEGGWv2aX1qxxrKbChqs2iY8+xOhjmW/baR9zi91ip4mEe/lfscQ+ybxb0A
         UB5Xs2yoz+gdgEmxQVnztbwFWD0x3mPNIwDkxJDIvXeKLKrWYKSnEYSsltzkq37/xtzZ
         CWlycqw7oXbaxXjlIQzz9FBWwqDsuDDO01fUbTTORsbMjlkEQI1rLsBytvmpu6FCmQeV
         EUTInl/1XpC1Ervr1oGlgUOxgSYxsAL6Q9fPyfxGuQqGfzJp+EfhTvurw+G0de+beIpD
         3Czw==
X-Gm-Message-State: AOAM533ycTdRug10UDh73LDEHBYjTN3aqsJzdlQLilSffJLYRC+PqfnJ
        TSPawdRhHWrTmDjVBPBOcg==
X-Google-Smtp-Source: ABdhPJxfIngqPIPPFq6gc+SDNZG2oWmf4zFtDxQiQMoBenm1qbDm6a92Xa7UhiT2+YDtpgUuD0aGRg==
X-Received: by 2002:aca:5110:: with SMTP id f16mr290638oib.94.1605546116505;
        Mon, 16 Nov 2020 09:01:56 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s131sm4819187oie.58.2020.11.16.09.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:01:55 -0800 (PST)
Received: (nullmailer pid 1808233 invoked by uid 1000);
        Mon, 16 Nov 2020 17:01:54 -0000
Date:   Mon, 16 Nov 2020 11:01:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        kernel@pengutronix.de, Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: stm32: add extra SiP compatible
 for lxa, stm32mp157c-mc1
Message-ID: <20201116170154.GA1808177@bogus>
References: <20201110102552.7270-1-a.fatoum@pengutronix.de>
 <20201110102552.7270-2-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110102552.7270-2-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 11:25:50 +0100, Ahmad Fatoum wrote:
> The Linux Automation MC-1 is built around an OSD32MP15x SiP with CPU,
> RAM, PMIC, Oscillator and EEPROM. Adjust the binding, so the SiP
> compatible is contained as well. This allows boot firmware to match
> against it to apply fixups if necessary.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>  - split up binding and device tree change
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
