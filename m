Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899F727D723
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgI2Tnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:43:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41472 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgI2Tnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:43:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id x69so6799818oia.8;
        Tue, 29 Sep 2020 12:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9gOxkBk6n8kdo+ETunaech3ZF6PmJ4G3bzk+Wi+tL8=;
        b=fL3RTyrCRAa05iBmWE9YI+W7WFFK4Y65xWv994E94ztbevNklYRp4KbXAdMCKI35Wc
         ClryFidFxk7E7FvZH8a2ilMQHTq/x+yTdXD6iLpQvMx7m4Bz434GcbuJKksm7n4v09do
         Ft2udsaN4/IcTIiW5aMLNpg0ErSOGPKjkcSRNz4DIPGxJ/5rWRcQOz+wg9eRIllPMhmU
         cDnM3/6U5Kf2/T5VyiBP6lQr483/PvG3UTElDUL9PId1TwU+jkzh4Zf7BF/POiBzzKHk
         5J9/HTKFE8EY6vI6WFZ+CV/c7SSgxr9KNfSvDLMzQIxlYaX75IqPtGpBCu+yafsPIvs6
         XSDg==
X-Gm-Message-State: AOAM53355cuyujAL2uIf/bt0AGiNJxA4SvXQ6MllQaf07yJR0/qXaU8C
        vQtq3X4+dhxLDQZ6ouKPkzEAn2d6vmEo
X-Google-Smtp-Source: ABdhPJymhNE82M1UsXoHK3kRUrd5SWesFi3N9ZwcJhuYSr7wRsm6AdFXovh4us4f/k8ukKVnUK2jbg==
X-Received: by 2002:aca:fd58:: with SMTP id b85mr3399954oii.20.1601408631669;
        Tue, 29 Sep 2020 12:43:51 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u68sm1294671otb.9.2020.09.29.12.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:43:51 -0700 (PDT)
Received: (nullmailer pid 1038804 invoked by uid 1000);
        Tue, 29 Sep 2020 19:43:50 -0000
Date:   Tue, 29 Sep 2020 14:43:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     jason@lakedaemon.net, robh+dt@kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        devicetree@vger.kernel.org, t-kristo@ti.com,
        linux-arm-kernel@lists.infradead.org, lokeshvutla@ti.com,
        ssantosh@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: irqchip: ti, sci-inta: Update for
 unmapped event handling
Message-ID: <20200929194350.GA1038748@bogus>
References: <20200928063930.12012-1-peter.ujfalusi@ti.com>
 <20200928063930.12012-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928063930.12012-2-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 09:39:29 +0300, Peter Ujfalusi wrote:
> The new DMA architecture introduced with AM64 introduced new event types:
> unampped events.
> 
> These events are mapped within INTA in contrast to other K3 devices where
> the events with similar function was originating from the UDMAP or ringacc.
> 
> The ti,unmapped-event-sources should contain phandle array to the devices
> in the system (typically DMA controllers) from where the unmapped events
> originate.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../bindings/interrupt-controller/ti,sci-inta.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
