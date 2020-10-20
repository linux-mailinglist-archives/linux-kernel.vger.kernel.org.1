Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC08293BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406280AbgJTMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:36:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38828 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbgJTMgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:36:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id b127so1688454wmb.3;
        Tue, 20 Oct 2020 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZT6SDytHpO7DGpkTiOwibYwxTZFwFaW7El5ykM8wnY=;
        b=VwtWBk4HHxfGYpJ8s601kvM2tXmNldZRDRIgEMxdec+fnrQOMXL6+MySRP/WyQIGAM
         8ZBwA1m5+a0kE59BQncX36gz6Xbv2dOM8DFCFADCfEmNIABnERgKSVYR72LJPrL2Rkx8
         PorRQNvIjIhyWjbS8WWCI8dIE4JLnFexoj+v8NVk9kWbrCTkAFzdo9atxZqX9D7j0Ywk
         pO781/NJw+Wgm7vzUmvKUlNc9AiSwetJKw4vJrgqrqp8AyG6St8MFTlHc0cu2ypwCYGX
         4O85ToXNdbMlUlhQFxWjoHca63tEgxnvq+ic8ByViQG4aV+GSMNDgrpkheFlc+AA44m2
         a+pA==
X-Gm-Message-State: AOAM530Rw4PeQSsP8HqJo6EstZAA/gj/251+XKSpNeLIWRFRawOynI7r
        SheqfbLyfPwmB8hgTcVAyhA=
X-Google-Smtp-Source: ABdhPJzYE6B+XxW9YePpnbxMHhrg1CwdVx0jKkcaQZC7Cj5YXknMvDzQnk99i/PHhsRT6HnmrBmL9w==
X-Received: by 2002:a1c:2096:: with SMTP id g144mr2816224wmg.79.1603197410633;
        Tue, 20 Oct 2020 05:36:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id q5sm3079620wrs.54.2020.10.20.05.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:36:49 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:36:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/29] arm: dts: hisi-x5hd2: Harmonize EHCI/OHCI DT nodes
 name
Message-ID: <20201020123647.GG127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-10-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-10-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:39PM +0300, Serge Semin wrote:
> In accordance with the Generic EHCI/OHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
> nodes are correctly named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/hisi-x5hd2.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
