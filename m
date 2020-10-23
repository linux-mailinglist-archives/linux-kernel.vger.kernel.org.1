Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819D32974E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbgJWQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:49:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41271 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464780AbgJWQth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:49:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id k65so1993892oih.8;
        Fri, 23 Oct 2020 09:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNWKGn3DDIoyEpIxZv2Re159Qqhhyn1QhElnu+a7Lmc=;
        b=RgC0opqi5tSHkrxuW5dPLnGw7tqKgd7DuU2TzhlOe3yG0bwCJeBHm0PJKDk4z8tHjh
         Pv8/GI9uo3kEI11qAsAnKjOIMF28OFKFt5I/8e+/G34B7eOvMjqxs2D0kKxOX8IAGXwZ
         wH95CyrmxclTNgokWllNuxXgHjqse8ui19nSEk513dV4tHAc5grSGQ9wZUiaD1ZH8pJt
         k8zCSce3qQOzUiTgJgynRN5Wg7nF+oQyRSenZ5zBWQyEiEeQ1fGiFiPxcG1QQ12Gq+T8
         ErHW8nVFqLQxqcbYRzs2n5MucO5PNqax33o/Lw5bIIiv6vJwl4wt2XY0YTxTBAMn6doa
         Z7Zw==
X-Gm-Message-State: AOAM53334pOWbdQtmVUo6W5D+RUq145UDGgQ9sHD7I+9QlYx7lSMauKH
        SPOyHOFfMWjl5F2u2uxqxA==
X-Google-Smtp-Source: ABdhPJw+inBHwHbjguZV3WazG0/oY/ETAyqQeaGUd3GD5InJ8OviJOAS4DVeUgezdEFSV2ZlJjHWEw==
X-Received: by 2002:a54:4812:: with SMTP id j18mr2536886oij.70.1603471775270;
        Fri, 23 Oct 2020 09:49:35 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f124sm595217oia.27.2020.10.23.09.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:49:34 -0700 (PDT)
Received: (nullmailer pid 2851617 invoked by uid 1000);
        Fri, 23 Oct 2020 16:49:33 -0000
Date:   Fri, 23 Oct 2020 11:49:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dennis-yc.hsieh@mediatek.com,
        bibby.hsieh@mediatek.com, ck.hu@mediatek.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        jaswinder.singh@linaro.org
Subject: Re: [PATCH] dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells
 value
Message-ID: <20201023164933.GA2851393@bogus>
References: <20201018193016.3339045-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018193016.3339045-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Oct 2020 21:30:16 +0200, Fabien Parent wrote:
> As the binding documentation says, #mbox-cells must have a value of 2,
> but the example use a value 3. The MT8173 device tree correctly use
> mbox-cells = <2>. This commit fixes the example.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
