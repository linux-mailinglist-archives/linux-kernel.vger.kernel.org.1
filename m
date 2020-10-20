Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84E293B99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406043AbgJTMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:30:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37153 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394305AbgJTMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:30:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so1914055wre.4;
        Tue, 20 Oct 2020 05:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJl+AiUpWbWHhQwkH43f+rbVBpzmF/gZcp0PBstKDZU=;
        b=eFEbVbvBQIfJEm9yV7rYZ8Si3M/I/NL63p6g9n1b9uHdy3dYNd+vWOJEUvp0YjnyTP
         fYDPW2/4Zn2zhKWnQL+P239jz5nlYj0sBM6wQYSURmGVxuIVpRUOcRPjjdB5J+3hwNPT
         jJK7SUfFZIINMx1LQP7Y+h/7cAe5K9M2CVpteTcD30q1avdbiW5hc9XcM7YzB+u6b2tL
         4WT3mcdEupRQATTFgSY3Cdkevj7bvY/J3GzoxFTGVcc80n0KnGczGukgQ1OHymjLXlPq
         2hfnbzqrmnRvEN7Nma8bPGa9AeKuLJqEwbEzkslgpQBUhJVhuomBRQC7aaQ86vNIzxnv
         0UWg==
X-Gm-Message-State: AOAM530PYZZR90oVMXyZSakWcikRxqNlwqkWTTuly9rJS/Qy5G8nRzbs
        dNg+ATGurqxV6iSSHguKPbA=
X-Google-Smtp-Source: ABdhPJwKNDKl6CRLJWAC73Y04jNh6zO26UNFGMP90alUq9Ls3NRxSCHVkbUjdbcjnjzLbU41DdRaFA==
X-Received: by 2002:adf:92e4:: with SMTP id 91mr3264604wrn.230.1603197056104;
        Tue, 20 Oct 2020 05:30:56 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id y5sm2901290wrw.52.2020.10.20.05.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:30:54 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:30:52 +0200
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
Subject: Re: [PATCH 02/29] arm: dts: keystone: Correct DWC USB3 compatible
 string
Message-ID: <20201020123052.GA127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-3-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:32PM +0300, Serge Semin wrote:
> Syonpsys IP cores are supposed to be defined with "snps" vendor-prefix.
> Use it instead of the deprecated "synopsys" one.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/keystone-k2e.dtsi | 2 +-
>  arch/arm/boot/dts/keystone.dtsi     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
