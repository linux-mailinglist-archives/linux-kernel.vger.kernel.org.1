Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10C4293BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406360AbgJTMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:41:32 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40235 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394386AbgJTMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:41:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id k18so1700856wmj.5;
        Tue, 20 Oct 2020 05:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuotxU2uOy/cSyO5WyTWT4iQTxKO+yhMTE6ttVAW5VQ=;
        b=K8APP21j/3T/shPZ9On74l9P/Lv9TBWHnh1PoMNG+HF4Xy08b5Bh9zemPdE//ggQQt
         joVZuEimJC/dncLiu7+aLGjWLKRrRJ9cw7hov7YKPGdt43hzYvY9k8B6Oh/VcDruaTdW
         H+RsyYLaCqE90cBPC5nh2DQjI9rKd5J1tAHNB1ea3+uM+RrfJ3yczVrBHHgPPDWD9dzE
         yrVzr9x85PHq84/DhiwJvN7myPeBOCM5ylPbZD5l7vUMunsgwsKj0u/JS01Yy+GnRjC1
         3JEo33Eb1n28pU5fZxD3v22y8ckQSazjJYloYlWOxb4BSJpKCQpUDxbIORRZ6Kyx1F4M
         s8bA==
X-Gm-Message-State: AOAM532+/TjKRLc722GieTbfmy+Pw/CH5ZybnbRUM588z2eHsLIh0JsR
        onZBvcsXumFLEisJXtKCUsKkSQVZld0XQA==
X-Google-Smtp-Source: ABdhPJz3VtI8fkZnCwMyaw6xWfYXqaEysEbmqWZV+4Fw2ShvEervKZxZLCYp3fDoC4BUwGS6nBT0zg==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr2381450wma.3.1603197688466;
        Tue, 20 Oct 2020 05:41:28 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id j7sm2452338wmc.7.2020.10.20.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:41:27 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:41:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/29] arm: dts: keystone: Harmonize DWC USB3 DT nodes
 name
Message-ID: <20201020124124.GQ127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-21-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-21-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:50PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/keystone-k2e.dtsi | 4 ++--
>  arch/arm/boot/dts/keystone.dtsi     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
