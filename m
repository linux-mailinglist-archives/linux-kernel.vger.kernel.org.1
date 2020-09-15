Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4826AAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 19:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIORqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:46:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40591 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgIOR1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:27:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id j34so2334992pgi.7;
        Tue, 15 Sep 2020 10:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bETQrHlgY+giuYgPl/jo3S5uao6J8l5uzCi3TzZPVZA=;
        b=i3WxXzjABnhsIcJFfeqtuFUa+fPmwUPLSxSXAth3kDqbm20WFBaDiHT2WmhXB3pikZ
         iVqpRwveiWeVNBL6ReU7vAOy9RcRGW48YCLpPfIT9xMd3dkvR8EC+klAKgCOncmgSy2H
         YAUGYVZv7NzgeQBofjudKu6b/6vy5F71lvdjij7lqbHkZl3MGwJvrAWs2nOIrJeXtGBC
         8ff5/S56rKm4Wo1xT4pc/7RWabdSZghG2O7YYc0OePv7CZmEACUBjZgD+j4AupohjLxE
         1yeqkmhTEy2VamuHa64c0zcywuUCHLmU/+H54bTgBZB5OoYf7VQBN/3MpOUb58UwnZhc
         UlBg==
X-Gm-Message-State: AOAM533ZQ6jBDoD2fXsQJbl8sENvizAN0v3VPiVad9OryPOzG90msd0i
        NhdsJ8PwjCYe39P+XDEroa7JueLEM9OVlak=
X-Google-Smtp-Source: ABdhPJzTpqhRYoX0orE95dExGzGsMu6Z+Szq5lkJDUMDgJUa0R1o5rp/mlwEDwerBCCvE+fbcd+OCA==
X-Received: by 2002:a92:db42:: with SMTP id w2mr4824823ilq.247.1600188927677;
        Tue, 15 Sep 2020 09:55:27 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m15sm8983132ild.8.2020.09.15.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 09:55:27 -0700 (PDT)
Received: (nullmailer pid 2115706 invoked by uid 1000);
        Tue, 15 Sep 2020 16:55:24 -0000
Date:   Tue, 15 Sep 2020 10:55:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings:  Correct interrupt flags in examples
Message-ID: <20200915165524.GA2115652@bogus>
References: <20200908145954.4629-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908145954.4629-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Sep 2020 16:59:54 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted some
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_HIGH => IRQ_TYPE_LEVEL_HIGH
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/sound/max98090.txt | 2 +-
>  Documentation/devicetree/bindings/sound/rt5640.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5659.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5665.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5668.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5677.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5682.txt   | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
