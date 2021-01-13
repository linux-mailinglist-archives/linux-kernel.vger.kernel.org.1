Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AE2F4250
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbhAMDSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:18:22 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40223 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhAMDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:18:21 -0500
Received: by mail-oi1-f177.google.com with SMTP id p5so656648oif.7;
        Tue, 12 Jan 2021 19:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8XjIEVq1PDEbHlvP5xmKOq6KKaZALP9at7Vr2ATfCfI=;
        b=X8EofCIGe23GSuE247pWhc0KQmQZodKupyRCPI3tNnz21AsvYtpIcD3I6rZg7oj4Mr
         Xq99FUn15dYIu3ZFAZQtPM/YSxhPpUDdQFjAxJUzd2Px6ugC7+Gg8zxIr3VVPqTiqwGL
         Jqk8NcuXZbqNWoQLsiLe2BgFCjNzrtQiiTS5EYVUT1CGvcf7AjNUO2+VzHg7Zqc+cx9E
         dcX/0Ln8ZxYedwtvObHmo+WwpXxUY9h7GahBapFjnbfSL2p7YHObqrApsBQ8tzfITnKy
         FGTP/t5D/Wqds6Qc//yuCD6GD5R6/2u7ecm/yK9wgkN0mP0/adtvxEbEwyu+3Wlh8Z6T
         Zqqw==
X-Gm-Message-State: AOAM531px+jaRg1ZwqaNdPTSTKNlhpqrpoSxFbuPt8nurhxnx956f58s
        KERGB2x5+nvi1M0OPlVVDof0j+rdKw==
X-Google-Smtp-Source: ABdhPJwR+eo3qwOt0emHLCkrpwJImnYdb7pB7OokNFKh0ZzXxl9oGaQQoWSHxEfRmq9vPDaCmgJUUQ==
X-Received: by 2002:aca:fc96:: with SMTP id a144mr106723oii.146.1610507861100;
        Tue, 12 Jan 2021 19:17:41 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f145sm163380oob.18.2021.01.12.19.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:17:40 -0800 (PST)
Received: (nullmailer pid 1460825 invoked by uid 1000);
        Wed, 13 Jan 2021 03:17:39 -0000
Date:   Tue, 12 Jan 2021 21:17:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: phy: brcm, brcmstb-usb-phy: convert
 to the json-schema
Message-ID: <20210113031739.GA1460774@robh.at.kernel.org>
References: <20210106205838.10964-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210106205838.10964-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jan 2021 21:58:36 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Changes that require mentioning:
> 1. interrupt-names
>    Name "wakeup" was changed to the "wake". It matches example and what
>    Linux driver looks for in the first place
> 2. brcm,ipp and brcm,ioc
>    Both were described as booleans with 0 / 1 values. In examples they
>    were integers and Linux checks for int as well. Both got uint32.
> 3. Added minimal description
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add Al as maintainer
> V3: Define "reg" and "reg-names" directly in the properties
> V4: additionalProperties: false
>     Fix example to use brcm,syscon-piarbctl (with the prefix)
> ---
>  .../bindings/phy/brcm,brcmstb-usb-phy.txt     |  86 --------
>  .../bindings/phy/brcm,brcmstb-usb-phy.yaml    | 193 ++++++++++++++++++
>  2 files changed, 193 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
