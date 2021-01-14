Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DFB2F6AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbhANTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:12:57 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33360 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbhANTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:12:57 -0500
Received: by mail-ot1-f41.google.com with SMTP id b24so6245726otj.0;
        Thu, 14 Jan 2021 11:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IVdz1hVx3JnBSSgi1+SpEmZGlf7gTcnOOfMmJk8O1/8=;
        b=Pzye+PbIUwrhINv4wbpD3GqAkfmyhCnDv0r8FjZ4D5QqA86ySbB0PLNHfQQna4poa4
         xUwpYyCZjibgkyLBJCd39tQXy4wNcA3X++AdUoeqR2uxjTSdwgSEPq/DZnUkcQA/Kn3B
         rqb2stQ58y9ICVuD5XTvCoyS+RkkMryft8FnQy2HKt9GMMC+mIzoSjQa7mGtPEpclrmq
         gl92tG9EUewtHAX7ST7dXsGo3v+3idK7ta3lt09q1WoX8PBqGaRbcLn9oMtsVVeR2Q4R
         1kV8JUR3yZvjlvuujhkOskF3oAqID/xhB/iw7UEOecZAlWo935t96Z2iGlANJscrZLVs
         WHow==
X-Gm-Message-State: AOAM5325FcQ3qj8yZdJuKqPEVMtx6ejXStqn+bp1D+H3LCWBK5vVor3k
        ykq8saqHfJI8O3FD2HIf5w==
X-Google-Smtp-Source: ABdhPJzScgPKmWmraTS71isS3dW3YXauoVatcUH8fiuYHHROUKwjpxeugH3Ow58adzLBbGVkAUnO1A==
X-Received: by 2002:a9d:6c51:: with SMTP id g17mr5626879otq.81.1610651536479;
        Thu, 14 Jan 2021 11:12:16 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c14sm1228287otp.19.2021.01.14.11.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:12:15 -0800 (PST)
Received: (nullmailer pid 3396012 invoked by uid 1000);
        Thu, 14 Jan 2021 19:12:14 -0000
Date:   Thu, 14 Jan 2021 13:12:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add Kontron sl28 variant 1
Message-ID: <20210114191214.GA3395971@robh.at.kernel.org>
References: <20210111082134.24704-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111082134.24704-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 09:21:33 +0100, Michael Walle wrote:
> Add the a new variant for the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - none
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
