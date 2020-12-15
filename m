Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3572DB308
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgLORwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:52:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36014 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbgLORwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:52:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id d20so2266478otl.3;
        Tue, 15 Dec 2020 09:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AchNMBWXCgEI6do/DZsWZ45QZMan+IbICzumlWZaLk0=;
        b=Zuo4CIKHMPRLfrV6tRiuj34DgzdVLy5nUjx0ZvLQ9Kr5nUVqqTfit1R736q+Q9SE73
         SWdZmuRBwZzZHU2ouXvR2O6QwgZTWju+rnSVtG9pClt4NfFo1R52/Xuj7YuuMwcx0ptS
         ruoZsNo6FwFX/IqlHXMNG7PM7bUDqcfNwysimfhnVw6eFxKB2XBAUckj8oOWJq8J+Dy7
         fsAnXYI8miWHADomaZl/MjCHG8Y4bPmB5xer4NVIeYQwOpiog7BJcgVQMuGDNe581lNu
         tT5jt+9rLmcG9iVmbd4adLoi+1igmEWkfBkcjF/mUA8XzjRNta+uRCEFsKkWjgO8RXPy
         iouA==
X-Gm-Message-State: AOAM530xTN7J99h1hFa0qhgBU+Kni3g5I8199J1iRnib01UFeu091D9g
        sUX/Xy8tRxiEhJ13A/NPkA==
X-Google-Smtp-Source: ABdhPJwZ3EEAQNFjZQ4a7gJWC8MG/9lX/vjKBVrwMlUMugLEt7uYVIj5O1M0qwfkC2lxbGBUewZo9A==
X-Received: by 2002:a9d:3d06:: with SMTP id a6mr23116466otc.368.1608054714347;
        Tue, 15 Dec 2020 09:51:54 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k63sm5225373oif.12.2020.12.15.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:51:53 -0800 (PST)
Received: (nullmailer pid 4105195 invoked by uid 1000);
        Tue, 15 Dec 2020 17:51:52 -0000
Date:   Tue, 15 Dec 2020 11:51:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: power: document Broadcom's PMB
 binding
Message-ID: <20201215175152.GA4105141@robh.at.kernel.org>
References: <20201214180743.14584-1-zajec5@gmail.com>
 <20201214180743.14584-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201214180743.14584-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 19:07:42 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Broadcom's PMB is power controller used for disabling and enabling SoC
> devices.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/power/brcm,bcm-pmb.yaml          | 50 +++++++++++++++++++
>  include/dt-bindings/soc/bcm-pmb.h             | 11 ++++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
>  create mode 100644 include/dt-bindings/soc/bcm-pmb.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
