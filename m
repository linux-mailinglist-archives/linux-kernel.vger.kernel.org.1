Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3D62D195B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLGTVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:21:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38989 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:21:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id v85so6076195oia.6;
        Mon, 07 Dec 2020 11:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JSsF2fMn6gn09wqsZvVS/trYqwZ/I/Qd8YAVDUbBcNE=;
        b=RDymnVUcej2tGnin61A5vy3QHaeQg3Lzc/UfHLgnZF2/+2X8x6ehFkJtb3MYoWjp8j
         v2ZSFhGQiSN0TuVZAJlxc3qBp/m9RvAEUXt2+Uf8Hf6xoy9f7qC45FlUcAHbPrqwChyU
         u7XVZtFVUUJoZRtZz/HHpoQkU3TcbjINhScMiQTJHO2eACqHnJkmqYU7PSXh8tX10DL+
         hf+j+Cta83KYSm4mXIu7KWISiUfEhdgwqoiyNnMIrvPrmw2BAy+1uV1VwO43iK1I/vBp
         23j5/TIVOIzKWGPFHO0MYk79/OuWrypjA7DYmsoDQbNt4k2zt1qDjLxkHaCoJgZ1CfXA
         hqmg==
X-Gm-Message-State: AOAM532sPaJ/v3KtlVkoba72Q/C5mo/8KXUQdTYnlozjP/RwaNFKZcR0
        UW0yt48iHu4a1/D2knZ7mDfZ0JM4xw==
X-Google-Smtp-Source: ABdhPJxtGn1GTYrqSbd6F1ZwM1v5EHysU70rmtwWsFbcCL1ba54BQcwubDafDwpgaQunlLQXPRXirw==
X-Received: by 2002:aca:518c:: with SMTP id f134mr288203oib.108.1607368841091;
        Mon, 07 Dec 2020 11:20:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j2sm112031otq.78.2020.12.07.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:20:40 -0800 (PST)
Received: (nullmailer pid 656175 invoked by uid 1000);
        Mon, 07 Dec 2020 19:20:39 -0000
Date:   Mon, 7 Dec 2020 13:20:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] dt-bindings: phy: bcm-ns-usb3-phy: convert to yaml
Message-ID: <20201207192039.GA656120@robh.at.kernel.org>
References: <20201116074650.16070-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116074650.16070-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 08:46:49 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Change syntax from txt to yaml
> 2. Drop "Driver for" from the title
> 3. Drop "reg = <0x0>;" from example (noticed by dt_binding_check)
> 4. Specify license
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
>  .../bindings/phy/bcm-ns-usb3-phy.txt          | 34 ----------
>  .../bindings/phy/bcm-ns-usb3-phy.yaml         | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/bcm-ns-usb3-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
