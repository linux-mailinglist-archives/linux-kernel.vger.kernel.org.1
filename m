Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1622F8261
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbhAORa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:30:59 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46615 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbhAORa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:30:58 -0500
Received: by mail-ot1-f48.google.com with SMTP id w3so9220235otp.13;
        Fri, 15 Jan 2021 09:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGEC0CKf9loDghM26j7yWmMd6Twn/8a22e286KGpUSY=;
        b=pwzyocKw54hNm/ghY4uhryQT0Dw1xFEge1SnM9ajURUUXYFT7+uAtsNA0ato1QPY4x
         sT2fWHzWznKM0R9M9VQkHxkiXLy7WK0PPECaq2Oc6ZBbjgrozfjdOEpDqNsW1aLvuXlC
         nuMZTjZMEnfUzCIEW6C2HyqIlobhofrpj+2z0XpgvGIlGI/YfJi07zSJg6d/4tSHEies
         A/EFLGf3HJ8rJtJgr2UyRgbSjwM/f33+FAgE5NESs6gZErcfCJ5cwiTEfQZoIfZ8DR87
         fhAUAbzeziZ5A9j/sqNhPPaAKFXvZ0WAP3DfdOwomgCVyi5UugZslKLya46zm4HIDV5a
         27rw==
X-Gm-Message-State: AOAM531mA91Fplq7DijXTORQahLfO0g5thGYO89mMPbFoKHwLR6opCNr
        NJuSvQfj/Nwv6xep2wZqoA==
X-Google-Smtp-Source: ABdhPJxX2uzV1VO/SuoK4R4V6DCOQRmPk8i2cSARu4rXx1BIpp339fhGMLf9NIz5sLKzTf7d2nrMTg==
X-Received: by 2002:a05:6830:150c:: with SMTP id k12mr8883605otp.11.1610731817448;
        Fri, 15 Jan 2021 09:30:17 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h93sm1921259otb.29.2021.01.15.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:30:16 -0800 (PST)
Received: (nullmailer pid 1496161 invoked by uid 1000);
        Fri, 15 Jan 2021 17:30:15 -0000
Date:   Fri, 15 Jan 2021 11:30:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     robh+dt@kernel.org, drinkcat@chromium.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        swboyd@chromium.org, karahmed@amazon.de, kernel-team@android.com,
        frowand.list@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] of/fdt: Make sure no-map does not remove already
 reserved regions
Message-ID: <20210115173015.GA1496104@robh.at.kernel.org>
References: <20210115114544.1830068-1-qperret@google.com>
 <20210115114544.1830068-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115114544.1830068-3-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 11:45:44 +0000, Quentin Perret wrote:
> From: Nicolas Boichat <drinkcat@chromium.org>
> 
> If the device tree is incorrectly configured, and attempts to
> define a "no-map" reserved memory that overlaps with the kernel
> data/code, the kernel would crash quickly after boot, with no
> obvious clue about the nature of the issue.
> 
> For example, this would happen if we have the kernel mapped at
> these addresses (from /proc/iomem):
> 40000000-41ffffff : System RAM
>   40080000-40dfffff : Kernel code
>   40e00000-411fffff : reserved
>   41200000-413e0fff : Kernel data
> 
> And we declare a no-map shared-dma-pool region at a fixed address
> within that range:
> mem_reserved: mem_region {
> 	compatible = "shared-dma-pool";
> 	reg = <0 0x40000000 0 0x01A00000>;
> 	no-map;
> };
> 
> To fix this, when removing memory regions at early boot (which is
> what "no-map" regions do), we need to make sure that the memory
> is not already reserved. If we do, __reserved_mem_reserve_reg
> will throw an error:
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
>    for node 'mem_region': base 0x0000000040000000, size 26 MiB
> and the code that will try to use the region should also fail,
> later on.
> 
> We do not do anything for non-"no-map" regions, as memblock
> explicitly allows reserved regions to overlap, and the commit
> that this fixes removed the check for that precise reason.
> 
> [ qperret: fixed conflicts caused by the usage of memblock_mark_nomap ]
> 
> Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/ regions in the case of partial overlap")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  drivers/of/fdt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Applied, thanks!
