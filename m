Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FD52665ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgIKRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:18:24 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42916 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgIKO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 10:58:24 -0400
Received: by mail-ej1-f67.google.com with SMTP id q13so14173313ejo.9;
        Fri, 11 Sep 2020 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aOEss69u0HOf22P48MgZ3tBTFDKG/yZuI7WmzKdffDM=;
        b=Mc7WmOKq6RABd27aP1BNSWyYX0knNsC94lERFeHULZ+9qQ5J6qwnslaHyKlRildW3x
         6oLE5hVP/d0Q2aXNGabJLWn7yFbbMK3SDQEQsozb6F595d1mEA2Mijw/tIgTdLuJ8xY5
         I5vmguW//SsDdykcoFG+FJhYZG1cnnFrEdCN3diCcJLgUh+bk8/2g/t2XrAtz9TBDFft
         Eqm6TxRMvXwrCYLbXJSaVOHNS0GDzG1s8XmUKlmKmNMgZpGe+OUXZ0Zdtvnc8U3F+QyM
         FCKaVojoi/bT54A1FwqLbDFLUENq1A5As6otf6RHgDChWuPtfjEL3wwsLFfvVeuyh1Xl
         QS1Q==
X-Gm-Message-State: AOAM532SrqqkuDkCCyh2g1eOOc36KZEj5638MF6cIlQkJZnK4fTtZD6p
        UZXZUI70HeuCUS2yXg+pYWg=
X-Google-Smtp-Source: ABdhPJwuI4pGTArYk3AIoPmW73BVQfttNnu3/IOhNJnwaeSyTKJzti6CLpR1dy2frjoSivz3v0G8TQ==
X-Received: by 2002:a17:906:4993:: with SMTP id p19mr2504434eju.277.1599836063629;
        Fri, 11 Sep 2020 07:54:23 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id e15sm1851929eds.5.2020.09.11.07.54.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 07:54:22 -0700 (PDT)
Date:   Fri, 11 Sep 2020 16:54:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH v3 3/3] ARM: dts: exynos: Add clocks sound node in
 Exynos5422 Odroid XU4
Message-ID: <20200911145420.GD15290@kozik-lap>
References: <20200906142146.21266-1-krzk@kernel.org>
 <20200906142146.21266-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906142146.21266-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 04:21:46PM +0200, Krzysztof Kozlowski wrote:
> The dtschema expects "clocks" property if "assigned-clocks" are used.
> Add reference to all parent clocks to silence the dtbs_check warnings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Move clock properties to i2s, just like Sylwester Nawrocki did for
>    Odroid XU3.
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu4.dts | 60 ++++++++++------------

Applied with reworked commit msg.

Best regards,
Krzysztof

