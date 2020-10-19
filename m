Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9979C292D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgJSRwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:52:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47020 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJSRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:52:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id n6so642427wrm.13;
        Mon, 19 Oct 2020 10:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uiRkzJgi3CVhIwkoj5j0f2670fIouTIIM2Ekju3oUWg=;
        b=cDVurNos6hQ2Zkw3gWhnpiUGn1sTmJbNEg8iyjeScXLdzPpG8PPGecyqKJ5q4pLQ8V
         JbYOag4wlr0ByMcBZbHyTiz1t4Zo98GZo+/NiRH5HEHkGEzVOS1c7cJCdPBc79hOMWLw
         PLXORPlotswbl3R+FTuu61mPWmFKo3sd6VFSpGw9IZR7o5xr7zX3D4VlEWnOHWwskNBr
         RpNAuOS3A5dO920y+c1it9Uin8DV5zMz3Cgr8XJ2v2T4VMi3Z6GL1JDDOzDLOca/xdRA
         f1J0aMRXxQmarmVvVNM3vOpOfg5L1sZGBwY3RDZk/gRAOHJFRcM+dAPknJQhcu+My/4F
         xIsg==
X-Gm-Message-State: AOAM530jhGqhvToDqIHBxLQpkMyG9zpPkBfVT/PGaEu0EjkupRIhzGnH
        Wyo4D9P6GC07U1pxZJG/Sfs=
X-Google-Smtp-Source: ABdhPJzwNizhoOV7B5EsJdpy/l9lx2s2CWw/Tabf7C51UFTGAAn1ukIB7RYwSStDxssE4ld1TMq40A==
X-Received: by 2002:a5d:4311:: with SMTP id h17mr446792wrq.398.1603129924511;
        Mon, 19 Oct 2020 10:52:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id f8sm572541wrw.85.2020.10.19.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:52:03 -0700 (PDT)
Date:   Mon, 19 Oct 2020 19:51:55 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/3] arm64: defconfig: Enable additional sound drivers
 on i.MX8M Mini
Message-ID: <20201019175155.GB94694@kozik-lap>
References: <20201019165038.274164-1-aford173@gmail.com>
 <20201019165038.274164-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019165038.274164-3-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:50:38AM -0500, Adam Ford wrote:
> The i.MX8M Mini has micfil and SPDIF support but the drivers
> are not being loaded.
> 
> This patch updates the defconfig to add support for these drivers.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  No Change

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
