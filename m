Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF02D1965
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLGTWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:22:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43231 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:22:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id q25so1771746otn.10;
        Mon, 07 Dec 2020 11:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UZgORA5KR4d2Ulyzhg3uaqqusHH2ln4StUCf3f0D5pc=;
        b=H5OOu+3CoZCdCs+R+wOOwTkM58R+rmeCCKWX+0/cuyQ1N5RScTrKQdvzGNcu6nFBtu
         7cQZuz4fOvh+Tv+Os5jrJ8O7iV1gKI/u9W/qnE25vKqNFsBc3wq9yGsKjbP2tkWaxvoh
         jTDAaFXF/0qMA7f/Wac4gafEp8TTnH9t5NwW5awVTJVQtf9GvyD+19f0lG81gj4kpqgk
         dunSc+kux743yixWtdc47NvvUxGpcDglv+szqidsZoeelEzLTCZipzMcqNGPkL32Q7vv
         dql1/gSVJDNuvYE8pdS2VLPJZpq6iPrDUEQlWeV7Bb2UTvzxJp5adG0jolGi+sSvRAQK
         AXNA==
X-Gm-Message-State: AOAM533w1TBugX81aWOLa23oOTz29UWB/hw/FF5FflA79FNqq0HB6z5M
        AY/2JuWy+erCbNhB9kMjgQ==
X-Google-Smtp-Source: ABdhPJzqTplc21iPoj/nP2BP0XxA54gpXMwd82ge1pBBTIaiH5hFCOE2KPQ2ZQTVk+CCxOuLMJ9ViA==
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr13935119oti.34.1607368875973;
        Mon, 07 Dec 2020 11:21:15 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm2799830oob.26.2020.12.07.11.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:21:14 -0800 (PST)
Received: (nullmailer pid 657194 invoked by uid 1000);
        Mon, 07 Dec 2020 19:21:13 -0000
Date:   Mon, 7 Dec 2020 13:21:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        bcm-kernel-feedback-list@broadcom.com,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb2-phy: convert to yaml
Message-ID: <20201207192113.GA657118@robh.at.kernel.org>
References: <20201116074650.16070-1-zajec5@gmail.com>
 <20201116074650.16070-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116074650.16070-2-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 08:46:50 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Convert from txt to yaml
> 2. Drop "Driver for" from the title
> 3. Document "#phy-cells"
> 4. Fix example node name (noticed by dt_binding_check)
> 5. Add #include to example (noticed by dt_binding_check)
> 6. Specify license
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> I think this should go through linux-phy tree. Kishon, Vinod, can you
> take this patch?
> 
> This patch generates a false positive checkpatch.pl warning [0].
> Please ignore:
> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
> 
> [0] https://lkml.org/lkml/2020/2/18/1084
> ---
>  .../bindings/phy/bcm-ns-usb2-phy.txt          | 21 -------
>  .../bindings/phy/bcm-ns-usb2-phy.yaml         | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb2-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
