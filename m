Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3327D6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgI2TTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:19:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40804 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgI2TTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:19:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so6711231oif.7;
        Tue, 29 Sep 2020 12:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P5SdKSW9rKoJcNchoLg84xT0SNGGTFLwlDHeSzV5xxQ=;
        b=cjq5+yO0f+T75hw4RylWFb4Lu18DXUdZ13XJ4iAUsfuHJGrb6XcEu74yxO6DCCFqk6
         esnkfTh6FhyVk50l9guoEQdKSuPXB/7+iInYChp94LnQlO1GuL07BHhEf3MF2MTFD/rZ
         qHyNkQ9NkL8lmkMatRPtKSA7YhqanVPG1fyt6Gvw0V4l0x4fL3wvuybvbw5nT/RR7233
         uzRiwQIO23C/XAAO7KUdyunpNiPmUpLprKmZ3s+RzYR/OhbInUe3vaq4hmnftJoASL6e
         +b6un/yqhykP0JQ53/DUlexvkNnj+TNDe12hJJyL0SuX7dgTLMXkqpGvii6ntajDmatU
         ozAg==
X-Gm-Message-State: AOAM531LIbCEmLLr8c6bo9T26raAnMv2VflwYK3EBiqnP0q96h3WaZ4C
        Ge6yt3Y9AIkv+5to/rlutHidkF2G6w0hNTk=
X-Google-Smtp-Source: ABdhPJxCyzqmf4AYvpnAzlhX1CqiXKTQXqt9FeZpbUb8CYkWyz8SAQPQoNT/bLMZm9t5tEYPnBIINw==
X-Received: by 2002:a54:4413:: with SMTP id k19mr3295692oiw.99.1601407146861;
        Tue, 29 Sep 2020 12:19:06 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm1203711oto.62.2020.09.29.12.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:19:06 -0700 (PDT)
Received: (nullmailer pid 999039 invoked by uid 1000);
        Tue, 29 Sep 2020 19:19:05 -0000
Date:   Tue, 29 Sep 2020 14:19:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 10/14] dt-bindings: arm: fsl: document i.MX6DL boards
Message-ID: <20200929191905.GA998958@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-10-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:07 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for i.MX6DL based boards.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
