Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F862DA3C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441349AbgLNW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:57:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46681 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441338AbgLNW5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:57:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id w3so17480085otp.13;
        Mon, 14 Dec 2020 14:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNjbVGsJxba9A3pdbcjJuis4jRluWROPs6SRzJDnAiM=;
        b=KEytD3HnAIbXjH4bgjH/fJNtkWtlFAhviojoIeyHAxnadRyk8o438WdyOpZvTDsqff
         svGOAGBv7MjKFtTcU7zMPVw8FBWGZkTP80FS7Gmi+ddXeTSyAhoY/IyYUhvbSJGBX49i
         PR24HMG9ts4Onhl4ElwajTiWDT4ro4DZPdB1vmgLYhZ+D2/x1uu9fOa4UvAhaMvVFlfM
         A3VDYXtQxw6mySabYPRQGMfvHx0D42luqNuvZ/npgKR5ZsvhABidHHu9wIOFuJeF+hAg
         KOoujuLJCRd+jw//iTA3I5mMFN1wJzzdtD6yiKSeYmSNlqLoYyJf+kYNwoyCxvbCulBG
         3chA==
X-Gm-Message-State: AOAM533H/4e05eGTyadDp6lH25pi6yjaWZPKCAlcsHJhGedY1+lnAHR3
        MjkF+LDtiWeUZtH7jW/i3A==
X-Google-Smtp-Source: ABdhPJyVvqrWcs6BRg91Gb3+qyTkUDLgEvyh5I2+/3hC3Iu16580LfsTA7rwDd/BwTwddhZWDdfU+A==
X-Received: by 2002:a9d:506:: with SMTP id 6mr20289543otw.95.1607986591939;
        Mon, 14 Dec 2020 14:56:31 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t3sm4161855oon.14.2020.12.14.14.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:56:31 -0800 (PST)
Received: (nullmailer pid 2536903 invoked by uid 1000);
        Mon, 14 Dec 2020 22:56:29 -0000
Date:   Mon, 14 Dec 2020 16:56:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [PATCH v2 20/21] dt-bindings: arm: sunxi: Add OrangePi Zero 2
 binding
Message-ID: <20201214225629.GA2536874@robh.at.kernel.org>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-21-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211011934.6171-21-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 01:19:33 +0000, Andre Przywara wrote:
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
