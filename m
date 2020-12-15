Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A70C2DB396
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgLOSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:19:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37118 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgLOSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:19:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id o11so20312081ote.4;
        Tue, 15 Dec 2020 10:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Za31ObBsxdpTjFd/k1MSNzpI1hhAUb59NU7Vy2qyuM=;
        b=a5vQQGLXbCnytr5LxR9v3+ttlYM0jmUmZpKzqbjBhWa2Z4LOFxJS1+38/1BBCWveE7
         mEtMIEMHGe4ttyn2f5cQgOqs5kZ8Vy83n6iS4Xb8goAbRtCwIQfZjEbhxnpsBSqsxOZt
         uMcWX/HikzxBL0fS6kb42MXKWHCCmqZS/Hr/kGAa4lrPCgXbygidzkY1tDlepODfQIhJ
         ub2nvmqNTmIIARWC+5emwNPy7opTMSON19zoRtgZD5gcx+GzVj4B8tDJ/sNaAH/AHZAn
         YJiXeTX7d3fUrJeN99NEarcjMGUevLSzuqK1bSf4MMFJJEjmV7fpHbIecMp/MDKgbMGZ
         tlMw==
X-Gm-Message-State: AOAM532e0FLtCWcV4bRoAKozUVXBJSnnQB8utNno6vEcQbFL5Cehn+m1
        dk0Of8NIUYO2gi6qDtNIGg==
X-Google-Smtp-Source: ABdhPJyLnlu8EMNR937aY6Yy1rLtfQbCSpj6kIaoagnNiNo1wWWkxaDaJLNyRG2qdJYuwXvPzf4ZRQ==
X-Received: by 2002:a05:6830:12cf:: with SMTP id a15mr24521499otq.217.1608056324303;
        Tue, 15 Dec 2020 10:18:44 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm587583otk.58.2020.12.15.10.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:18:43 -0800 (PST)
Received: (nullmailer pid 4147585 invoked by uid 1000);
        Tue, 15 Dec 2020 18:18:42 -0000
Date:   Tue, 15 Dec 2020 12:18:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v6] dt-bindings: usb: Add new compatible string for AM64
 SoC
Message-ID: <20201215181842.GA4147555@robh.at.kernel.org>
References: <20201215042549.7956-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215042549.7956-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 09:55:49 +0530, Aswath Govindraju wrote:
> Add compatible string in j721e-usb binding file as the same USB subsystem
> is present in AM64.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v5:
>  - Added const as the type for objects in items.
> 
> Changes since v4:
>  - used oneOf instead of enum, as the schema has to convey that the strings
>    ti,j721e-usb and ti,am64-usb can be used combined or seperately in the
>    DT nodes.
> 
> Changes since v3:
>  - used enum instead of anyOf.
> 
> Changes since v2:
>  - added changes done over the versions.
> 
> Changes since v1:
>  - replaced the '\t' at the beginning of the lines with spaces as it was
>   causing the dt_binding_check to fail.
> 
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
