Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F7269AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIOBNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:13:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45032 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgIOBNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:13:41 -0400
Received: by mail-io1-f66.google.com with SMTP id g128so2213797iof.11;
        Mon, 14 Sep 2020 18:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJyXEjNhnavm6OGxMGpiglYSRW9Ck9Xx/Oa+d48O33U=;
        b=VBIFD3Iz8vK7tT6EaNUX4wuQ2Z74FpkBB+eS08DaIumQ0X1RGtgmprB71nRYKVeSzU
         D7JrvwT1aICc1c+iHebrKQ4QorimD/7j9NUY1s5iJE+wJoPNi76k6B23qyc3O904tLRq
         7dxMS+tYoHlaQ5x0G75I5p1mksCGbcIjwG09QUgMROGPX8wmidejWHexEzjsUa68F17i
         6S9fowOVaYN4lpmaj/ln7f2EslEXW+hfJxTue/lfsx7Ed2GdniBidiWeGHs8JiwZZt9E
         V4Pmibxlh/vdqogY8QTzC9e+mWW4apTrRRbUFmc7Ye2zoQc74VR5OctnAwA+blLLet2e
         AfnA==
X-Gm-Message-State: AOAM530B1dOutXaVOHvlW2Qb8R8bBi7N2ZVKRs/q2wOk7tohOW2n4KAN
        CNRpXaCEJAyjP9SjdQSBzg==
X-Google-Smtp-Source: ABdhPJzgk7GZMndb5SkzACJ48AJ3+fnaE/Zbts7nxs9Cw9UbOh5yb3KyMFXpIGyMRObsiNbNNvfFTA==
X-Received: by 2002:a6b:e017:: with SMTP id z23mr13494818iog.101.1600132420688;
        Mon, 14 Sep 2020 18:13:40 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t10sm6968130iog.49.2020.09.14.18.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:13:39 -0700 (PDT)
Received: (nullmailer pid 640710 invoked by uid 1000);
        Tue, 15 Sep 2020 01:13:37 -0000
Date:   Mon, 14 Sep 2020 19:13:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
        krzk@kernel.org, owen.chen@mediatek.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        macpaul.lin@mediatek.com, mars.cheng@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: add MT8167 power dt-bindings
Message-ID: <20200915011337.GA640680@bogus>
References: <20200906172337.1052933-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906172337.1052933-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Sep 2020 19:23:36 +0200, Fabien Parent wrote:
> Add the SCPSYS binding documentation for MediaTek MT8167 SoCs.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    |  3 +++
>  include/dt-bindings/power/mt8167-power.h           | 14 ++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8167-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
