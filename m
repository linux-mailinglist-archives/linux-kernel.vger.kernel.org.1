Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5F274E68
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgIWBbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:31:24 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34529 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgIWBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:31:23 -0400
Received: by mail-il1-f193.google.com with SMTP id q5so12717160ilj.1;
        Tue, 22 Sep 2020 18:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RgBQCzMtQmwIMiimJ3o9lxyQbCmVqCdm6KoNh0i+4hs=;
        b=UqIY1AAV0BDtmux3NO+7myGVz13FXPJNRJQvEdG7xlmpAkP8WoqLvF35qOm9vyfP5O
         f6nlPHG2t74G0A7uLv2TWZOs41hGRjsiS0YUx0LYbZ7YFCVZ/N9ztcVCxK37V+abCYSl
         YbroZzgMU4QxkifDMDiMzt9tcKNoBEZeYgyPV60KqFhBiNeGnQKdI67tO35OddJcLdYW
         JrzJkpo5/XEcjik/oCddZ9te0YbYOfN+k+jHToBxnJE26q+FNVVm5LbhNlvix2PfQhw+
         sbNyiNBjjqjUc7f6dM4tqCtz0jobK8824uREIJGHktfgTJzVmwWz177U88Cv6nZdo7VS
         6oXw==
X-Gm-Message-State: AOAM530RbS2hVwn4r4gN90rTej9Lrf3KuBA2jurRtkWdkjAXbt7Q1vtw
        0Sa2Nvo8Vc43FH3t7+do8g==
X-Google-Smtp-Source: ABdhPJwkK9aKoaJcCfiMhweECt8pD8K2e3ZKf7ZMIpCNkj3hN+SJ+lK+lcS4U58qgAFe+INSDKmhmA==
X-Received: by 2002:a92:8501:: with SMTP id f1mr6672836ilh.54.1600824682737;
        Tue, 22 Sep 2020 18:31:22 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g23sm8292465ioe.45.2020.09.22.18.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:31:22 -0700 (PDT)
Received: (nullmailer pid 3661228 invoked by uid 1000);
        Wed, 23 Sep 2020 01:31:21 -0000
Date:   Tue, 22 Sep 2020 19:31:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: clk: axg-clkc: add MIPI DSI Host
 clock binding
Message-ID: <20200923013121.GA3661177@bogus>
References: <20200915124553.8056-1-narmstrong@baylibre.com>
 <20200915124553.8056-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915124553.8056-3-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 14:45:51 +0200, Neil Armstrong wrote:
> Add the clock ID for the MIPI DSI Host clock.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/dt-bindings/clock/axg-clkc.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
