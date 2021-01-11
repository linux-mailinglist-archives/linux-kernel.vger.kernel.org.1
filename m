Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC802F22F4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbhAKWkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:40:33 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33435 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbhAKWkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:40:32 -0500
Received: by mail-oi1-f169.google.com with SMTP id d203so352150oia.0;
        Mon, 11 Jan 2021 14:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OGa/l2jJYoY5GgRVS4CJNgnmY7MLFON8bENGc4FBO+o=;
        b=EVFpTZFulBq7edkSo/CZHTep3ZMl2fYF3Z5uM0BVitFKxQPsBSwXLPvAqjvGBBrPPx
         iScQa+fRtwd96Y38IBCx+agD0Tq3brsphkqJSdsqUdmfKh9MExydvdE5lP+lnpA56/ab
         fPXflnkM9AJ1PYy0juktkkL70J/GC3q2K+7ZDEtDo7Zf/S0CooKGNPp8/4V6MZ5w1lr1
         KbR5ei6hV2cNH1m0avCj+aAZVLxEtK2Nwc9Lf6AB289pLrQ8wvWksVqoxLa5Lrbq/eZA
         R3uJOOZlCFxmSFyjk86sxjqRRP27Bw1nSZuBg1dKxaoXc5gtO4Rkf/PPHFgWvd7m9o7u
         PMVQ==
X-Gm-Message-State: AOAM530ogx2M9/g54paVei+3f4N6UyQvJ9mr3WmYTKRZBzlNmd0+ASSM
        VCj8rJw5O/WaYvksJGH1ZA==
X-Google-Smtp-Source: ABdhPJwEhGFMFZwjuW6fhm6a6OIkYBhybEZH9+vyWRgWcjO4HOXxL5FopEtJgLWJQws2Ww1Z1rVtwg==
X-Received: by 2002:aca:30cf:: with SMTP id w198mr630768oiw.118.1610404791458;
        Mon, 11 Jan 2021 14:39:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c18sm255549oib.31.2021.01.11.14.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:39:50 -0800 (PST)
Received: (nullmailer pid 3188580 invoked by uid 1000);
        Mon, 11 Jan 2021 22:39:49 -0000
Date:   Mon, 11 Jan 2021 16:39:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: ti,pruss: add ti,am1806-pruss
Message-ID: <20210111223949.GA3188532@robh.at.kernel.org>
References: <20210104183021.330112-1-david@lechnology.com>
 <20210104183021.330112-2-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104183021.330112-2-david@lechnology.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jan 2021 12:30:20 -0600, David Lechner wrote:
> This adds a "ti,am1806-pruss" compatible type for the PRUSS found in
> TI AM18xx/OMAP-L138 SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
