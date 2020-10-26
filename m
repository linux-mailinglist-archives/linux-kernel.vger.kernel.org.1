Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C184298F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781666AbgJZOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:38:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37853 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781581AbgJZOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:38:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id m22so8178436ots.4;
        Mon, 26 Oct 2020 07:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dmc6xs39pOcvaguHHkLHxd4UeG9+n4WiLiCISEFRVvE=;
        b=QNzSufadAIFPypbUPh8FSEdeb3L7uSEbpVO02bmHaeRNdvSfxjxiDZKXs0oEpgWclm
         czcpS6ltZnGaVVXr0Og5OolpG3A/cRV+r5zijcJSb0dNSUvo0HUS5XkUpEFKvC/zcm5+
         GWhNhXmzQCpyznzQ24WlgJrC70CVSDBYO69ImN85+oO1kI6eRZ4J+Bzi5Yr6loGvG2xc
         wmKmfvVN21pyzFOmw45t0/FQXkZZkaGzb+wCjjDJt4PtybHlFKgXv3TRx4gYJIJv1x0/
         UcWJutViWrz3YfzPPD3FGTAjjoyJVUlZv5K/Akt4ulrNXL9OTufvMNKKANYItJoSDOWP
         QaHg==
X-Gm-Message-State: AOAM533WDlPuFWFUn2jhGSDKrL/+89mQ+8GlCLED4cRzRAHpdidlKqaf
        npu8Tm848xWqkNl24qbTwQ==
X-Google-Smtp-Source: ABdhPJxI/8VTP5i/7wxqiKj0bWHUYN05SkqR0BiJs/0nllrZpJVEWuPVO0ce25saT4lDP9QNHLdr9Q==
X-Received: by 2002:a9d:411:: with SMTP id 17mr14374161otc.191.1603723083071;
        Mon, 26 Oct 2020 07:38:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u22sm4032299oor.13.2020.10.26.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:38:01 -0700 (PDT)
Received: (nullmailer pid 123037 invoked by uid 1000);
        Mon, 26 Oct 2020 14:38:01 -0000
Date:   Mon, 26 Oct 2020 09:38:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, catalin.marinas@arm.com,
        jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        hch@lst.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ardb@kernel.org, will@kernel.org,
        guohanjun@huawei.com, robin.murphy@arm.com,
        Frank Rowand <frowand.list@gmail.com>,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v4 4/7] of: unittest: Add test for
 of_dma_get_max_cpu_address()
Message-ID: <20201026143801.GA122988@bogus>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021123437.21538-5-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 14:34:34 +0200, Nicolas Saenz Julienne wrote:
> Introduce a test for of_dma_get_max_cup_address(), it uses the same DT
> data as the rest of dma-ranges unit tests.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> Changes since v3:
>  - Remove HAS_DMA guards
> 
>  drivers/of/unittest.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
