Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AA827493F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIVTfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:35:38 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40697 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVTfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:35:37 -0400
Received: by mail-il1-f194.google.com with SMTP id x18so16032392ila.7;
        Tue, 22 Sep 2020 12:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPBD0XmzIV/W0iZGo3u7QE8dbhQcu1GYPOKQ4Uj0YkA=;
        b=H7TS5gyhTzI1GRYtp1iMLia9n75dX+G8dpIYYqhZRl7cW2YEY+8sH4JK3/RPD2bkav
         ELkTtB3G+piZCRN7PfsmW7O0lPMLBpmKc/RUEvrrCOLjZsZ//ixWlXPiR/NGYF/KqFBL
         QmXjmY3eA5+l0dQP09k6sw2c9alMMmqhrw8KwS79FTNAyxdK8tOiDP/OKokwYsL6uCom
         kaUu+V3fjirnUWLLVM8qHiE5wnLEbBfKoL+BVkmlla5tnFXZNqTrrfZ4evI2d2LxXrAF
         aPcea0jUytZWWquhwQvgG8Kz8Nmno/GdZleTQRCpEHMd4rBk4OPjsfAz+sWiUixbycYg
         xUVQ==
X-Gm-Message-State: AOAM5336MCvwGwtIAYJ/EV2iHnAntUg4CsbtU52hONETtdYVPAPzumP/
        s7Ud+zC8TS3hSdadt+EUZw==
X-Google-Smtp-Source: ABdhPJzNqdROL+jdJ3dVRE9aodQED8gpbXyKrtUeG8JK3C/kXVBgCpAfcjl4U3P55eEquDFbPiY9lw==
X-Received: by 2002:a92:d34f:: with SMTP id a15mr5920759ilh.226.1600803337012;
        Tue, 22 Sep 2020 12:35:37 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q2sm6502219ils.81.2020.09.22.12.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:35:36 -0700 (PDT)
Received: (nullmailer pid 3100940 invoked by uid 1000);
        Tue, 22 Sep 2020 19:35:34 -0000
Date:   Tue, 22 Sep 2020 13:35:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     repk@triplefau.lt, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kishon@ti.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: phy: amlogic,
 meson-axg-mipi-pcie-analog: remove phy cell parameter
Message-ID: <20200922193534.GA3100774@bogus>
References: <20200915130339.11079-1-narmstrong@baylibre.com>
 <20200915130339.11079-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915130339.11079-3-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 15:03:38 +0200, Neil Armstrong wrote:
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
