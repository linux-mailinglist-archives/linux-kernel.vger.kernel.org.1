Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223E22A2E53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgKBPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:30:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33733 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:30:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id s21so15070097oij.0;
        Mon, 02 Nov 2020 07:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHb+WHhvKWMEtBp+MT6o822dw6iepfZFOpJAoj7c5gk=;
        b=dUI3j4SeI4Z3I5UNGu4Ud1tlnxjro0DEkEObDD07Kk8ze49llr+GzJS2JR3PJDOMEl
         wt66wAOWF1Y2VzIv5DR2rAAi8navMKREHKIAwZMu5Pa9Fq21rRj1XbahFBWuyR1yQ2xT
         v5rOZp8wzyG+t4tgMHRQ9NBjdQ/RQJBQPu/zysCEnxgB+Obn5HLCO0GxZdLU3zllYPtt
         nQi+1JsKwSaCWfrG2p93l8eNtKUmGYLrAtH3qeO73cx5WJyKF2iK44R9LTbJ55Z/QLIJ
         MOD2KONFggHibM2NzwHEgXYiocSlWkOdSyjNkMDEs4pjlGBwro2EZyVMmIChB4+X5Kuz
         BDNA==
X-Gm-Message-State: AOAM5307foLXwE7WQwTTaQHQkzta025sAfoi/xG6hgugQhpq0bMq8TV/
        JHeazvxxm5NbzrEcgZzKxg==
X-Google-Smtp-Source: ABdhPJwoFUlMHP8KOC6aRUM6dD/5odOuPVhCQuzSUPByJB2maDTMdZ5ll3eee1zbRrGFMJxJ9yMWmw==
X-Received: by 2002:aca:59c3:: with SMTP id n186mr9961060oib.149.1604331036419;
        Mon, 02 Nov 2020 07:30:36 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm3287045oif.43.2020.11.02.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:30:35 -0800 (PST)
Received: (nullmailer pid 3926406 invoked by uid 1000);
        Mon, 02 Nov 2020 15:30:34 -0000
Date:   Mon, 2 Nov 2020 09:30:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kishon@ti.com, yamonkar@cadence.com,
        jsarha@ti.com, mparab@cadence.com, nsekhar@ti.com,
        robh+dt@kernel.org, tomi.valkeinen@ti.com
Subject: Re: [PATCH] dt-bindings: phy: Add Cadence Sierra PHY bindings in
 YAML format
Message-ID: <20201102153034.GA3926372@bogus>
References: <1603898561-5142-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603898561-5142-1-git-send-email-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 16:22:41 +0100, Swapnil Jakhade wrote:
> Add Cadence Sierra PHY bindings in YAML format.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-sierra.txt       |  70 --------
>  .../bindings/phy/phy-cadence-sierra.yaml      | 152 ++++++++++++++++++
>  2 files changed, 152 insertions(+), 70 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
