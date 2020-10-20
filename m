Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461AB293C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406575AbgJTMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:46:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40109 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406564AbgJTMqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:46:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id h5so1959638wrv.7;
        Tue, 20 Oct 2020 05:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQv+xfCPzc+5PPtvTADPQMWbujtoBLXO+daEeOWggN0=;
        b=Vvrvic+yZQMPQIIFRnNj7tLZV9GtHRSffFb+4EK5IRiN4RaFSXlhPlr488mb2H0hfb
         nc8GHj9HqapMMyhLqzGQ7GrkUKI8zMa8yhsjg1SrEasY30lKN3/4P+TrrXRfLHBE94Bg
         g19r1kQ8rEFiE8rMJyzfl7ZtCH2WNbv1Q9H6eStYA2wjv2dgYeC0ND+fAmDUSI6V1iCb
         s7q4hW6TmvOijgDYCivDnkUv7ouyneM7vicHgFL/aolabnuuXdn/mbVU02ROgFeAHGUk
         cYKR0uE5lv4UllH1nYuvUiN8OBYQM2pZv/omrhNUNGRl5tNL2XC4YwBDKMrV8dhhITZo
         Eyrw==
X-Gm-Message-State: AOAM530IEVsXwNeq2lQkECZhe0MRFoAKDEJyIWXGDhuS5eRjw24yX6TA
        F+ptIhXE9+0a4oZsU1mZjCw=
X-Google-Smtp-Source: ABdhPJyha72lne8TnaP7k5v53bQy65ufRru71LUGlqaTTHIg8jCf7NahCol2zlVqwHOHqZh27XptZA==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr3579603wru.71.1603198009725;
        Tue, 20 Oct 2020 05:46:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id u2sm2563332wme.1.2020.10.20.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 05:46:48 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:46:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/29] arm: dts: ls1021a: Harmonize DWC USB3 DT nodes name
Message-ID: <20201020124646.GZ127386@kozik-lap>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-22-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020115959.2658-22-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 02:59:51PM +0300, Serge Semin wrote:
> In accordance with the DWC USB3 bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
> named.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
