Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563CB285305
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgJFUV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:21:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46049 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:21:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id f37so9999862otf.12;
        Tue, 06 Oct 2020 13:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ujTRQgLhFlaA0guIPLKbfPjdF6Mj7DpzagyROHx0puA=;
        b=KAOmjLsOiz8Zh+WZ+o0jB+06WBYpw+h9fcB5MjhAwB23HBq2YHJhxPN0iPQyhPZ6Fs
         4pYk26rKZkL2eNkGok+QepYBEfJt/DmFDvAvhxwGlJyEBfuIGVl8U8ewOTreL+DHtqzq
         jAwpfLwH3IePn2d3y/qGQFnMF7JsLpTQaitw+zyP1p7luPsEkIjegI8oV10ls8N3ltAo
         prL4z/Gi5F6TAcCwyA7MGrHCKGxNRH1JbfUm7M/cYbCXxux6y/EhIvBSxVHBCV5C9/ZN
         IxXBhAKFrKNbIkv0jWB+aTG7P5uMSUWcWTrErl3YkvPSBnoHZLzVzYvKfq/foKJgxq+l
         F35Q==
X-Gm-Message-State: AOAM5312pgof+G5kc8toSsa+2JSMXrUmnRjBHZxsBx4z3pxCnInVx1XY
        f46sw9D2e2xqFIP2X8465Q==
X-Google-Smtp-Source: ABdhPJyGEGNZNGnhUSBgHrhz39iCD8BurNeQ2LW+WNv8Mvwown0qQRHbfAjkBYwsoWLSgZICGmKQFg==
X-Received: by 2002:a9d:1e86:: with SMTP id n6mr4143817otn.94.1602015688799;
        Tue, 06 Oct 2020 13:21:28 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm1727206ooe.20.2020.10.06.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:21:27 -0700 (PDT)
Received: (nullmailer pid 2769098 invoked by uid 1000);
        Tue, 06 Oct 2020 20:21:27 -0000
Date:   Tue, 6 Oct 2020 15:21:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Allow defining the SATA AFE TX
 amplitude
Message-ID: <20201006202127.GA2769064@bogus>
References: <20201001031916.411999-1-f.fainelli@gmail.com>
 <20201001031916.411999-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001031916.411999-2-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 20:19:15 -0700, Florian Fainelli wrote:
> Document a new property which allows the selection of the SATA AFE TX
> amplitude in milli Volts. Possible values are 400, 500, 600 and 800mV.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/phy/brcm-sata-phy.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
