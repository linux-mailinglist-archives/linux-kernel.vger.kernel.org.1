Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A00293BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406415AbgJTMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:41:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53367 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406329AbgJTMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:41:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id f21so1623489wml.3;
        Tue, 20 Oct 2020 05:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qCas6k3nYKts6UgIZuFpTZnuVniqrmLVx2xngxj3sQE=;
        b=hpY7ZGJEhIi8fVzF1mxOSUZwMz6r5mIh0LRxsVPe1a9vwYK0xqW1YoQvXLd8R5KieS
         jaVyqbzno7afq9LOxIxl4lh1SXIE8TS1qtfUR7fe8zhn2uxKif22RtJQoXGreLWwslXa
         BBcFjslLrQdGugQbeB194+WFbA/LYLeMZV6zyb353GzfjneHapmO/qTSBjytFR7YSiu8
         kfa4tb1C8fCrvgAfH+WfzpwTVQoZ3U2tqilamcqq8lIuIBqb2vKvX5/RIo62/okJxsKZ
         r5JPOLrLTx3xwJ6lz03c8K0EzVz4YhorEFTWDKIFibSQtNmacR+I6pTMbO1ujTFcj1xm
         WxlQ==
X-Gm-Message-State: AOAM533bSDl7pFuy0+DxPxIlJs5n9e4C2CEQCGwvv41ZfuuczQbyj/H2
        s/xkZxyBErilRR2b4FCwiaw=
X-Google-Smtp-Source: ABdhPJyBrUKaMz6b7z2dTGY8CQ5eEc3FfjRjLJ8iWulMQgaktv+0AdmFNXEWgQ401nU27/N4ViAySw==
X-Received: by 2002:a1c:48c3:: with SMTP id v186mr2969133wma.16.1603197714061;
        Tue, 20 Oct 2020 05:41:54 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id t19sm2759749wmi.26.2020.10.20.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:41:53 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:41:50 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/29] arm: dts: stih407-family: Harmonize DWC USB3 DT
 nodes name
Message-ID: <20201020124150.GR127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-24-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-24-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:53PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
