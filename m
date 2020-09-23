Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F568274E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgIWBbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:31:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38576 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgIWBbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:31:52 -0400
Received: by mail-io1-f66.google.com with SMTP id q4so12572360iop.5;
        Tue, 22 Sep 2020 18:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/1uY0ea+dOiIx/gu+uWclu23l4go3q7mcQvxB944Bs=;
        b=t8n/UOx1ERX7oqTUwfTUyXXrLZRTnfsOb1rR0MO7VoExaCL4UPyjphFJBycNZFveEn
         P4vGgnBRc0/t44dwkiKDytJmxCMzlDhXCA1C61aZjPiovKVewAk7yc4okIsvfRy4cquF
         XFFSdJraEwkdafNd4rXduXsCc1ZiwKulOd+6wawY+Et3EgtkNGx4i3LnDyZjPMkFMxp9
         qyKmG7bd5wf+t8AC5my2i/yEvz7V4221JAE06ohji2aii/KwYCUXf2Y+PKxf6AyO6z0a
         pmqyL7zFHWzK0cs4qVsCnM9FKzDfaDw4yVROZbb8/yTFABO+OMZpT35cPGkXuqJhHj/k
         XqBQ==
X-Gm-Message-State: AOAM5316uSet5bGj9i0O/ukkaVKA7p3SFhhKz75vkVimLKmWJEl2i/Bj
        zlc+6Qa16vzPqT7VTSBnF3Ckk7uxgY1H
X-Google-Smtp-Source: ABdhPJyEMaBvP3/ztVLWZkxnsPOXD6uyY/aLBSQHqOpEeXNd393utur8koLDkvfSGNNfKtjceOssNA==
X-Received: by 2002:a05:6638:1316:: with SMTP id r22mr6367491jad.129.1600824711507;
        Tue, 22 Sep 2020 18:31:51 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 64sm10241194ilv.0.2020.09.22.18.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:31:50 -0700 (PDT)
Received: (nullmailer pid 3662119 invoked by uid 1000);
        Wed, 23 Sep 2020 01:31:49 -0000
Date:   Tue, 22 Sep 2020 19:31:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kishon@ti.com, repk@triplefau.lt,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: amlogic,
 meson-axg-mipi-pcie-analog: remove reg attribute
Message-ID: <20200923013149.GA3662065@bogus>
References: <20200915130339.11079-1-narmstrong@baylibre.com>
 <20200915130339.11079-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915130339.11079-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 15:03:37 +0200, Neil Armstrong wrote:
> The PHY registers happens to be at the beginning of a large zone containing
> interleaved system registers (mainly clocks, power management, PHY control..),
> found in all Amlogic SoC so far.
> 
> The goal is to model it the same way as the other "features" of this zone,
> like Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> and Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
> and have a coherent bindings scheme over the Amlogic SoCs.
> 
> This update the description, removed the reg attribute then updates the example
> accordingly.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
