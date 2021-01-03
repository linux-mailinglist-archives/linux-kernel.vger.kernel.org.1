Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61A12E8D17
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 17:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbhACQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 11:24:51 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:42956 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhACQYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 11:24:51 -0500
Received: by mail-il1-f172.google.com with SMTP id 2so23130255ilg.9;
        Sun, 03 Jan 2021 08:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pvYB2hoQir5JYPFRSJfquQtknEnxPr8aWiNEU6638/E=;
        b=EqB8cQjK6CrImNHkDtL0Is9W1NQqnWzYyz7E6m4wDUfg8R9tjfJSCvNcFPkLZEkifn
         LM1dHs7x6cNuEpxosy/CQDcgMnsRaE0v2/dr8Bo0r6LH+ds1q2l67NU9/kRWKZM8LOR4
         Qqes9cLlASN0/Pfk0ZmdldrXV0zqAL6TcEobSaeZcQCHmY+X2Kjl5lcHueHQbRpK/V06
         efRIEup7rp8MZbrb5LMaHk9N41SGkz0HSvVL1/H83mwI2MYwmF+EY9GR5nbaNDNQW4/b
         ZW1bwLXcZfcrqBCQcd1qGKnpkQ1dj1UHvAPJI0rioHu73mNOjt2LCsolBJzycTTuwEtX
         vobQ==
X-Gm-Message-State: AOAM531R7x+zlR9xUke1SEm/54XD5st/ElPcxNFSzw3OyTz0P+j311IA
        nVzvpCmpRwHyzqoILxdmh3MtwQfeqg==
X-Google-Smtp-Source: ABdhPJyTmf8BGsSCHhxV6P1/VNc2U5qsaXzX9iBQnA6ys+QOI5bCFWKL+6uY8m217Len1q7NYg3jGg==
X-Received: by 2002:a92:d1cd:: with SMTP id u13mr50308061ilg.186.1609691050176;
        Sun, 03 Jan 2021 08:24:10 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d5sm38673615ilf.33.2021.01.03.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 08:24:09 -0800 (PST)
Received: (nullmailer pid 3983302 invoked by uid 1000);
        Sun, 03 Jan 2021 16:24:03 -0000
Date:   Sun, 3 Jan 2021 09:24:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Al Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH V2 2/3] dt-bindings: phy: brcm, brcmstb-usb-phy: add
 BCM4908 binding
Message-ID: <20210103162403.GA3983249@robh.at.kernel.org>
References: <20201221052339.10100-1-zajec5@gmail.com>
 <20201221052339.10100-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201221052339.10100-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 06:23:38 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 uses the same PHY and may require just a slightly different
> programming.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml        | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
