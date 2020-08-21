Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3119D24E35B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 00:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgHUW2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 18:28:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41267 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgHUW2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:28:06 -0400
Received: by mail-io1-f66.google.com with SMTP id m23so2653142iol.8;
        Fri, 21 Aug 2020 15:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzaI9sAfILdFuQlpBeNIrRuh+tzXLS66g4kfINbIeTc=;
        b=q2rweMEQmzYPVWzvPAfZS7IH7uKSZhUSFZw43A83w7SKVaYG0sqYjgoqDA2tXJNsrA
         zgNEm93P+DCpcQUzRqpL32ow1ONA8eZqTaYWmtXUHw8xy8DXTcmVR9aHM7F5J3hdthDE
         TlFF7anIdaX//NkoCxWkf+SmBpl83W+7wsGIeeBoFlPcAm7WpoRSTHpvpuBYI11m+FPf
         MBO5F9Bqc+3RpqJwlhxO24VDQcRjaoKdXw+KrULmB4QmskBfufHi7vfT1Z9R50D5CVLu
         w57CywtS9m+5b9vMd9RPgRh6n6b0rto3aDbzti2dOHZPm9VB7gXx7tGarzK6M3RFu46i
         wrrQ==
X-Gm-Message-State: AOAM530lr2Y8CbuqF912vx47zfhmvk4d9TWmOgzP5RN3sAUrjLz60dkt
        /9jC+/rluc9KycANwS/IUw==
X-Google-Smtp-Source: ABdhPJxMNUycBKYVIrQkrb7DSHaYpXi7X7D27/OGPkK+s7+NskTrfg6aPBxmpAd9eaq2f16bIJmYPw==
X-Received: by 2002:a05:6638:214d:: with SMTP id z13mr4643568jaj.7.1598048885479;
        Fri, 21 Aug 2020 15:28:05 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 3sm2102716ily.31.2020.08.21.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:28:04 -0700 (PDT)
Received: (nullmailer pid 1829396 invoked by uid 1000);
        Fri, 21 Aug 2020 22:28:04 -0000
Date:   Fri, 21 Aug 2020 16:28:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Remove trailing whitespace
Message-ID: <20200821222804.GA1829240@bogus>
References: <20200819092058.1526-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819092058.1526-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 11:20:58 +0200, Geert Uytterhoeven wrote:
> Fixes: f516fb704d02fff2 ("dt-bindings: Whitespace clean-ups in schema files")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
