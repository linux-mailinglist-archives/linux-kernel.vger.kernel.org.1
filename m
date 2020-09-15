Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893F826B08F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgIOWNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:13:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42920 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbgIOQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:38:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id d6so2248050pfn.9;
        Tue, 15 Sep 2020 09:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9MxfDSVj20FLJkNdG9Fpfa1v8rBz2a5FI6l6n2Vm6w=;
        b=bEES83NTwOSzoALA2hCsG8x3nktGcY9J07hQRP50lgKHQkf5P86KZUTmkE+jyQzbvE
         PZHPRk7N3/F4xNi/QTMEee6h32AyS3hNg1l6iefJQ8iQ654lXhLS00cC9FazBfNuyo1F
         cajsS4ndJ+eIujm+T0TfGy8QxOJfLgFLlEUx5+q33GiDGtFCkiwZsp853JXK3Mme3thE
         0nmoabvCZhTzBdb6YYMTfQXjDzJu9av7fpZKYTh9mROaotVSRl19aXjpBZDweBfggaSX
         g+/jc1NctsaqzZ511n5Iy2z79wl4nRjvkCX4njHFNQJS9KvQhiAxFvYR2uOxjpvkYZ9d
         cRzg==
X-Gm-Message-State: AOAM531y/VLGje74vU3KDvAK+bTvaioAXdEWmMGjXmY/aQ0SIohau5WG
        njfd3ENk5a9I5jUqWk3e7B4zldKP7G1usM4=
X-Google-Smtp-Source: ABdhPJwoqazv6MXGioLiGUJnVEx8NxVuciezDoqT6iHAUsJPnENvpZY0sXdlQqZ3k/GeDupxUnSmTg==
X-Received: by 2002:a92:ca85:: with SMTP id t5mr878635ilo.254.1600183789745;
        Tue, 15 Sep 2020 08:29:49 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m19sm9104553ila.40.2020.09.15.08.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:29:48 -0700 (PDT)
Received: (nullmailer pid 1981801 invoked by uid 1000);
        Tue, 15 Sep 2020 15:29:47 -0000
Date:   Tue, 15 Sep 2020 09:29:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        repk@triplefau.lt, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: phy: amlogic,
 meson-axg-mipi-pcie-analog: remove phy cell parameter
Message-ID: <20200915152947.GA1981749@bogus>
References: <20200907073402.26674-1-narmstrong@baylibre.com>
 <20200907073402.26674-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907073402.26674-3-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Sep 2020 09:34:01 +0200, Neil Armstrong wrote:
> The Amlogic AXG MIPI + PCIe Analog PHY provides function for both PCIe and
> MIPI DSI at the same time, and is not exclusive.
> 
> Thus remove the invalid phy cell parameter.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
