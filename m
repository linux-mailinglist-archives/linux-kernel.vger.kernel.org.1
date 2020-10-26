Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF17F298D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1776612AbgJZNOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:14:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39878 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1776597AbgJZNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:13:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id u127so10406504oib.6;
        Mon, 26 Oct 2020 06:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rmJekMJIbGl07zxWeiosPnkjYnZ4WMaPaye8OH8Xnfg=;
        b=GCbzwOp0n0zAlvmzAZjU6pBy9vuqhJolO/QhYEW8hyr0LRcGS4p1GQzrvhMCE0PhRT
         1nln8b+Ca7GLKdEIeSPf0z4kPv8DLBgCnmaDaW3wy2vkU/Qr4wBXdWVhnnYzeW4Cf60t
         Dx/4C6zUKbS+0pEhN7HJhBs28Jtn2MWNs7f1bcv+u0jyNAYeQ3eY4MMKX+rOYng37sqG
         WoNvdzKBERuC8fVAo7mtGcwQxStzCmEkJbq6NFp6R/+DhERDhEW4QdtEw3ex5pFRL3ML
         j0ol+Wf93R9ngB8H+mPcrl3fPwzN/fexloH4MVdt7+F91O5WsDtllcjZA4aCCV0tY+Wq
         r51w==
X-Gm-Message-State: AOAM530PqL3rhmtp8m6ikiVNBFQDVA51dctw54ke40YrqfvY0866Ufc5
        qsyilv1tR+ukFUnrmFUcJw==
X-Google-Smtp-Source: ABdhPJxZnw5CrxzzGKl682KAZOV7/6vCSY0bZk6f1XdhhjV5uYq2BaP8QK0LgRi1cGEe7IOnR23wMg==
X-Received: by 2002:aca:d487:: with SMTP id l129mr10305529oig.123.1603718036793;
        Mon, 26 Oct 2020 06:13:56 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm3841301ooi.41.2020.10.26.06.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:13:55 -0700 (PDT)
Received: (nullmailer pid 10906 invoked by uid 1000);
        Mon, 26 Oct 2020 13:13:55 -0000
Date:   Mon, 26 Oct 2020 08:13:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: mtk-efuse: add documentation for
 MT8516 SoC
Message-ID: <20201026131355.GA10697@bogus>
References: <20201016171837.3261310-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016171837.3261310-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 19:18:36 +0200, Fabien Parent wrote:
> Add binding documentation for MT8516 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
