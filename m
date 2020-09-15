Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCAF26AB2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgIORw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:52:58 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37429 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgIORdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:33:11 -0400
Received: by mail-il1-f193.google.com with SMTP id q4so3804597ils.4;
        Tue, 15 Sep 2020 10:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uulJ0/uPh+foHiGNPCNz1hwqcPZlO72vLvw5DYaUH18=;
        b=XdKL8HdVqYS++emo3SfB9Lo9ogmaYFhRyxk1Z/b0RBL119R31n2MarDmcfT3fGDEu6
         t9YH3nGsTs4I88TtB/M4gmCHl5+nY+byxmC4BjwJyv4f1bdJW2ePzGwybpuIgA1xUE5Y
         ThW8HpTKY57el8BF9WIaLfePZ9HY9rtMvY68r6go+XATKMtYxof8PLIEXZoUJ7yx8G8k
         dm1b+QN9QznPgnAdZHMce5xKqW3cSedXa0RHlz9nfq+l3/KBe1wEFt52uSTqtCCKalY6
         Lh/q4demj8aj77gOYw6fTXw/HhIr/ncTjVhP+ujf4M9NeYaYRYGQJUbQjTy6yNKDonD/
         e3eA==
X-Gm-Message-State: AOAM532jxtGJW4vYzBe9rDQtjo2KtEWa7CiMYjHuoFjyQIeK84O6Zu54
        nZpyVEQ8rSI+Hq8kNqORX3497JOtb5zeHMM=
X-Google-Smtp-Source: ABdhPJw1Y7mhGsOLEdrqCVwLfhzbJ/8rNa80uaRT0MVEVBVau28or814vSSqDbkIUCKAQEpOQ+MtOg==
X-Received: by 2002:a92:194b:: with SMTP id e11mr17113785ilm.43.1600191170055;
        Tue, 15 Sep 2020 10:32:50 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k2sm7840357ioj.2.2020.09.15.10.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 10:32:49 -0700 (PDT)
Received: (nullmailer pid 2175348 invoked by uid 1000);
        Tue, 15 Sep 2020 17:32:47 -0000
Date:   Tue, 15 Sep 2020 11:32:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, khilman@baylibre.com
Subject: Re: [PATCH 2/5] dt-bindings: usb: amlogic, meson-g12a-usb-ctrl: add
 the Amlogic AXG Families USB Glue Bindings
Message-ID: <20200915173247.GA2175318@bogus>
References: <20200909160409.8678-1-narmstrong@baylibre.com>
 <20200909160409.8678-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909160409.8678-3-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Sep 2020 18:04:06 +0200, Neil Armstrong wrote:
> The Amlogic AXG is close from the GXL Glue but with a single OTG PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
