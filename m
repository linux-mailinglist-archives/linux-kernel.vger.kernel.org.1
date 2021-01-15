Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC02F825D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbhAORac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:30:32 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41578 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbhAORab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:30:31 -0500
Received: by mail-oi1-f176.google.com with SMTP id 15so10310212oix.8;
        Fri, 15 Jan 2021 09:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9bNlanUlLIZiV9jMZbmi1S66JbvTJeqySZ2DAtAruDg=;
        b=SNm02dPVhSgCVJMe2zeBAR7V8fCc+jC7/B7Yhfu8xa+kE2M33hpVNqgngkxN7xTldV
         2ajqK2pl/9bV/wWaupW58i7XlGjwyrrPSIWbzbxDlYVy5Q9zwRFf2MknvJEJUfzf4DEu
         GE/ZMFodrvKG1cowh87AFhVEni1ma0uWbBrjI2JakQxb+vtMLK8M9kCGHZxN+iBdpzAA
         gLtuC/wBb25vfcGnvPTmMHe3yi1Mx5mUR8jwrlrUlxy7Vc3+1N16+gH70FbP5L3LL0Lj
         UXB5eJA+PV8sJoWEWBBY/rDCdb8osifSfqRHEi+r9rbONFGXZIrtRML3me3i8hVY9MfC
         W+Vg==
X-Gm-Message-State: AOAM531yQW1v4G5OJ4fznrEQSsc31AzwFg8As6kabLb/E6URgHY+Wtka
        vdjBNQNZGaHD39EnLsyamHM6GLiI9A==
X-Google-Smtp-Source: ABdhPJzoBo4X3FoK2C3WCQP/Cli/G8FN3JUg4u7kBAo4Q8d2jRCB8jJGU0MZjm2ToRWFK3+DGZrvsw==
X-Received: by 2002:aca:3dd6:: with SMTP id k205mr6391840oia.96.1610731790874;
        Fri, 15 Jan 2021 09:29:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y35sm1919098otb.5.2021.01.15.09.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 09:29:50 -0800 (PST)
Received: (nullmailer pid 1495288 invoked by uid 1000);
        Fri, 15 Jan 2021 17:29:49 -0000
Date:   Fri, 15 Jan 2021 11:29:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     robh+dt@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        drinkcat@chromium.org, swboyd@chromium.org, karahmed@amazon.de,
        f.fainelli@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] fdt: Properly handle "no-map" field in the memory
 region
Message-ID: <20210115172949.GA1495225@robh.at.kernel.org>
References: <20210115114544.1830068-1-qperret@google.com>
 <20210115114544.1830068-2-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115114544.1830068-2-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 11:45:43 +0000, Quentin Perret wrote:
> From: KarimAllah Ahmed <karahmed@amazon.de>
> 
> Mark the memory region with NOMAP flag instead of completely removing it
> from the memory blocks. That makes the FDT handling consistent with the EFI
> memory map handling.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
