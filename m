Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C448627D814
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgI2U3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:29:30 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:39067 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbgI2U31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:29:27 -0400
Received: by mail-oo1-f67.google.com with SMTP id c4so1633298oou.6;
        Tue, 29 Sep 2020 13:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVznSS/MHfUrzpl6hvRLAxLDzFZqn6idbGU4ctIRvfQ=;
        b=GHBI1a1JjurWnImvwTlHLKt5dgJsC2tNTmDJXXMJZldaJiVyPgyca0pxt3ItgniG9L
         nLO9bY3Xmi18DRtQkDPX7lpYGLYfRdtsPECr5H6+Gokqsuwxr755/Up3a1yPlxgDRPB/
         t5zEA6wJQ9d9F8N1BYN35WaTk3CI3Gzp93EQY10gwFsfoIc0g+qhxk1Gb9eMH1MQ6Tn4
         hbEz5Pgb2NFv0vObEhMqp6pHxizLIcfuzNmIejAijlNQfOT1/F1QmBalT9Ma4cbHOLx7
         S2qfahUSrouTpq9oNdew2SlOpe70lO5bzW2D4Si24ZzTGDTkd21gLILLBeu1P1x3Txtn
         p7aw==
X-Gm-Message-State: AOAM533+uU59Ii+H9Oq7ZoEFRvWb5FzYVGuADVjDTqo9ZBSlD9cxJMVP
        dPMpACurtr1o7HpFne+Czw==
X-Google-Smtp-Source: ABdhPJz/DTVFRX3Typ1ykNzwK8nlqvC+wmU1hpeRgwvfWqRGN42HpQM5KhuaXIx3ik6S+uL/U21BHw==
X-Received: by 2002:a4a:b443:: with SMTP id h3mr5902570ooo.45.1601411366950;
        Tue, 29 Sep 2020 13:29:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c124sm1251260oib.22.2020.09.29.13.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:29:26 -0700 (PDT)
Received: (nullmailer pid 1113194 invoked by uid 1000);
        Tue, 29 Sep 2020 20:29:25 -0000
Date:   Tue, 29 Sep 2020 15:29:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>, Libin <huawei.libin@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v5 05/17] dt-bindings: arm: hisilicon: add binding for
 SD5203 SoC
Message-ID: <20200929202925.GA1113164@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-6-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:42 +0800, Zhen Lei wrote:
> Add devicetree binding for Hisilicon SD5203 SoC.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!
