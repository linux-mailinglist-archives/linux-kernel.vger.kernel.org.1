Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF401FFA06
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgFRRTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 13:19:07 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37973 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgFRRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:19:06 -0400
Received: by mail-il1-f193.google.com with SMTP id b5so6560023iln.5;
        Thu, 18 Jun 2020 10:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Db7i8O4GZYzUo4BrwYG9krZWxE26JRhniK91bgJunXc=;
        b=JaT+KhVs65hHvdSWjhIYVNrzqqqs9ObDY8JWUlpd7yJhIPw2tzMceWIP79O9EvcEGx
         OmoMk8XfBGJzUOcnXU3mhtDE1fvzHJC30FRQagkhlfKyFq4frAZBOzJQQh+1FVvqENtH
         fqSOSmg4uHH3cwBTy/023HKxRr5A8u/pBT3Q6UYrSczUA/0HyEslYRE69ZMyqR61xgCC
         +mGqoAwrYmfdZq2bstFgIRYSZGMoADUcdUVJaVcrYFMQoCU5TipT5Kc0dvLOunenZeP/
         92LKTZS3s9k+RW9SYqWHbAEUqzmoDxocvnbqv97rQteHwiAg0myBnZPFMSJFCSvpiVF7
         nNeg==
X-Gm-Message-State: AOAM530XOxZxfmYzOhRLx28A0dSFHz3oq28cNEuRnGAiEwWZy18HyJjk
        Buf5UCY6+x8V7YAh2LZHQ12KXRYizw==
X-Google-Smtp-Source: ABdhPJz3Zg035OcmSJh4DRlnfpp0v68/rA3fvCKm4Bt2OSeRUyPPDg/rT57SAqLcuDxpv3iguKojYg==
X-Received: by 2002:a92:d3c8:: with SMTP id c8mr5114952ilh.57.1592500745724;
        Thu, 18 Jun 2020 10:19:05 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v11sm1804090ile.61.2020.06.18.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 10:19:05 -0700 (PDT)
Received: (nullmailer pid 558701 invoked by uid 1000);
        Thu, 18 Jun 2020 17:19:03 -0000
Date:   Thu, 18 Jun 2020 11:19:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 15/29] dt: fix reference to olpc,xo1.75-ec.txt
Message-ID: <20200618171903.GA558613@bogus>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <d0262854582ee754e4b8bd80677d96b3e098ea5c.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0262854582ee754e4b8bd80677d96b3e098ea5c.1592203542.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 08:46:54 +0200, Mauro Carvalho Chehab wrote:
> This file was converted and renamed.
> 
> Fixes: 7882d822b3f9 ("dt-bindings: spi: Convert spi-pxa2xx to json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
