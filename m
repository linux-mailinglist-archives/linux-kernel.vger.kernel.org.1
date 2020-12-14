Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0779C2DA3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439147AbgLNWzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:55:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46593 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgLNWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:55:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id w3so17475365otp.13;
        Mon, 14 Dec 2020 14:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ut1HVPfxFOmF1kHVSLkpJ8rWOwr6YvEtHr1rA6tOms=;
        b=qk/PBbmLxBTCk1G0RlISH78PuB22LT6K5Z+Z2I89QaQTOGS9bWinV5aM8pKZBS0zVB
         jvfrrcWu7NISB5lfxocIiPGSbHqyPNvKymPxkRs/VnALZ1gdOIMQe6jKSZOEvFaCOQfI
         9kq8EjIni9k9+wfL8SyPw6HcrakgGjCXtsF6pLBGX570PKIjcqgk9nxaQc+AxU0xZdCX
         gl1M9ZY5V3Yo76nzvLpTxpXqyXSPsEBAv74sSkGGCj0TM4KLqlgUzNIYiIiQXMN4ioi2
         lTh25JAqjJgCRylHm1AGbUc2oY75c2FbWMWD7cYRLYQ4wm7BoHQsZUkb1r+eqvpBr6OO
         2enA==
X-Gm-Message-State: AOAM5332MVd8NEV51rB10jUDQERkWg2kjL04AQLym4G+KeCnCOUCC/N/
        AxzvWyuUftCvUwx9YOfhjw==
X-Google-Smtp-Source: ABdhPJy9rlqlL3LdQVGCXeYNExhK8vF0KeUrCXlvt2WtgTl82VL9MOdcvL5gHeL71L0XKnGOtGb9aw==
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr21720551otl.37.1607986470679;
        Mon, 14 Dec 2020 14:54:30 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a15sm4605369oii.50.2020.12.14.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:54:29 -0800 (PST)
Received: (nullmailer pid 2534026 invoked by uid 1000);
        Mon, 14 Dec 2020 22:54:28 -0000
Date:   Mon, 14 Dec 2020 16:54:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>, devicetree@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: Re: [PATCH v2 08/21] dt-bindings: mmc: sunxi: Add Allwinner A100 and
 H616 compatibles
Message-ID: <20201214225428.GA2533994@robh.at.kernel.org>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-9-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211011934.6171-9-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 01:19:21 +0000, Andre Przywara wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add binding for A100's and H616's mmc and emmc controller.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml  | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
