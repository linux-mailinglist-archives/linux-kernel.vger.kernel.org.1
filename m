Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5531927AD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgI1ML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgI1ML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:11:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898AFC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:11:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so861505wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7j2hMlME7tc0tEQkSSS8xb1F+KuYkA6Veri3DVF15q4=;
        b=E+zJZI097lrmY3nCoxu4sDiwT3FNXKkjxBIaywF3Lc07KL1z66isdCFxW0xTSa111L
         sCYDHY0mJSJMOMQ0Uz/xhyMItQ5mDfejVfOYLuli9qQbgAQy3PRVLwgZLppGctm7ipuY
         Sn6JBAVLlkAkgdWBqVtU0QHXqvyvEVabweu95ePoPY5CyQvbt6F+IEmg9HAuuKQE2tH0
         VJG/b7iXyYgLlJ3LM6QMzwr68G6H0UJFhv8pUiVXpXA2DLfyuU7NM4MOWHsEJx1KHNEX
         qNblPhsWvXXaQOIVYhCG3S7iNPsyPWuNfNjhJ1OCNdde4NgzJj6fPv4s801o6fr8n1+q
         M0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7j2hMlME7tc0tEQkSSS8xb1F+KuYkA6Veri3DVF15q4=;
        b=WnkjC11ANKjMspb/UByWrucK3Ohd7DOICmKd0IiIlCVAVz0rbZPfJtpUvl9Jc7iu7O
         mtGv+cqf1aDUYypA7VW07xMsNJmWb9PnE/gKhTk5jbEcj91jU4HInJg3izyzI8eUBM7w
         LtV7CdjZQwBDHVVxj+rKIwiBEsHww7PjZcoCfI8ipB0NWo6wzcf6TmNaDBkyO8oxDOth
         hNgJ88gIcrzZ0I1JuQoncIEkHukNnl6ZxYfl56/+L4r7X+N2ylM1vu3S4j/7cccxo1XX
         vN4DkDZrqzdkz2VW/2PnZasfEw2nZUo7lJMRaUlB4nosUZ9cZI7s9zpmT+CLMIdnzBrv
         RDbA==
X-Gm-Message-State: AOAM531yZ7ip8Ka0dNlqTQhQR2rngc0RTHm904MNbH2ueVkfxkDuR7kq
        SY1ySsRVkMwBRaJXochlQUsVrYpoDWQ5xg==
X-Google-Smtp-Source: ABdhPJxFfqR3eEqXbi3H+U8ljl91xjX3UcTfZVavU0Hq94Z1nqVnr59NRTgNIM1pflmJKosPdWlTMg==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr1299532wmi.138.1601295116194;
        Mon, 28 Sep 2020 05:11:56 -0700 (PDT)
Received: from dell ([91.110.221.154])
        by smtp.gmail.com with ESMTPSA id q15sm1219701wrr.8.2020.09.28.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:11:55 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:11:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mfd: add LP87524-Q1
Message-ID: <20200928121153.GE4637@dell>
References: <20200902142259.28349-1-luca@lucaceresoli.net>
 <20200902142259.28349-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902142259.28349-3-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020, Luca Ceresoli wrote:

> Add the LP87524-Q1 to the bindings along with an example. This is a variant
> of the LP87565-Q1 and LP87561-Q1 chips which already have bindings.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v5:
>  - describe the "regulators" node too (Rob)
>  - add 'additionalProperties: false' (Rob)
>  - user patternProperties for supplies
>  - simplify supply description
> 
> Changes in v4:
>  - reformat as a standalone file
> 
> Changes in v3:
>  - fix yaml errors
> 
> Changes in v2:
>  - RFC,v1 was based on the txt file, rewrite for yaml
>  - use uppercase consistently in model names (Lee Jones)
>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>  - replace "dt:" suffix with "dt-bindings:" prefix in subject line
> ---
>  .../bindings/mfd/ti,lp87524-q1.yaml           | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
