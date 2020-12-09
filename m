Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4982D46E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbgLIQhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:37:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34309 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbgLIQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:37:14 -0500
Received: by mail-ot1-f67.google.com with SMTP id a109so1961595otc.1;
        Wed, 09 Dec 2020 08:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Nrvk3PUoM6SzdFghQZEGJk8ahD1T69zwk8JW2tlVaQ=;
        b=nGVVnbSE9vkUAX9uHmMkyMPGVfVznWfaD3iD/VE7wRlhGHGa+h07DqGWG67qYtsuOh
         nMDVP9G3rZNLO9S3r/6CtG6cO5jiUDTASTs8vFdHVTLRawCJtFh9zdcm3N0AsPaEtUu1
         TiSUT9JZkqo5IF+jCDUNpuniKO0X/QFaBEP6xFGf6agnMcj7OTtE8HnMi+o4H3G2twTz
         15JcD1Vw3FdjtoJh9lIq7/zva6dGBW1kWRKBT+hfbX4eHrxH5ES/tipSxKtGgYf6x6m+
         +QfbxEfN9vxHt0Yf1DTw1qHhmxdCt6aOAOdhZLVJx8myQmJrvINNy04VrAXxd1NYahf+
         7dWg==
X-Gm-Message-State: AOAM531qZHTs8IdoVOdBIH0vAV1sMFKxzIKrRm6NDAeVQpJxv3ukxGM6
        yG4iVC9yjF2+mFFQdQVoGw==
X-Google-Smtp-Source: ABdhPJyESP95Acad+YcdIIO2pMEpSKBJsfzgBnAA2l+p3gk8d9NrU8YIa9Fq2cFt2jMoPuJAz8jHKQ==
X-Received: by 2002:a9d:3b36:: with SMTP id z51mr2500260otb.272.1607531793795;
        Wed, 09 Dec 2020 08:36:33 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b25sm447323ooe.18.2020.12.09.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:36:31 -0800 (PST)
Received: (nullmailer pid 570767 invoked by uid 1000);
        Wed, 09 Dec 2020 16:36:30 -0000
Date:   Wed, 9 Dec 2020 10:36:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-kernel@vger.kernel.org, w@1wt.eu, olof@lixom.net,
        devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de
Subject: Re: [PATCH v2 03/10] dt-bindings: mstar: Add Honestar SSD201_HT_V2
 to mstar boards
Message-ID: <20201209163630.GA570737@robh.at.kernel.org>
References: <20201201134330.3037007-1-daniel@0x0f.com>
 <20201201134330.3037007-4-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201134330.3037007-4-daniel@0x0f.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Dec 2020 22:43:23 +0900, Daniel Palmer wrote:
> The Honestar SSD201_HT_V2 is a full size devkit for the SigmaStar
> SSD201 or SSD202D (they are pin compatible).
> 
> Currently only the SSD202D version is supported as that's the one
> I have.
> 
> Link: https://linux-chenxing.org/infinity2/ssd201_ht_v2/
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/arm/mstar/mstar.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
