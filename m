Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABA627D5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgI2SkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:40:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33002 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2SkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:40:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id m7so6607311oie.0;
        Tue, 29 Sep 2020 11:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcKrcybmAaU/WYldiQIWK9aNmaFzFyPZCjIPWTqpK/8=;
        b=TTJ+DomJErCczhIWTKfXcR5bIayhSBo75w0aHL9i7VSfXLLGXBvo2vXkwAjfB4tTAS
         oRqY/EItSkvd7VCa2SC5/79QoZgA/ZZbMZaLB5lIH9BbhMdYy/zkcipRTTvhJB7V04Hp
         pz2L+HiThH5zm2PFK4iQ811WIfS0KdnnixnbRHW8SoMM6w+Wg65n2ypX8BSB5mx/vXYg
         UzkCG7avmktN4xmUrsgJ4RXZ2BXeFhYQabcj9ZxUU3j5/rf15OeBRg1RAKgghaDneV/v
         2IzTBv7h2k9uskdyRPe1DlKu/3k8lu8fKIn0bo0lUn9r9pOI5m1ht7YbUkxt8CODMhd4
         h1IA==
X-Gm-Message-State: AOAM531jEEibdD/Smlk8a1yl/phhWbgO5/tORzlhkUlegHmvZFNXsrHt
        NPhpXuxaeWwuL1ujPrqqmdFik7o3MVme
X-Google-Smtp-Source: ABdhPJz0iWRA2f5mNkbG/Rl6rbl069vPZWH9U5x4wrwDrwuCW+H0BjF8T2Tnmmo7sv/9qNERp8NlWQ==
X-Received: by 2002:a05:6808:8f3:: with SMTP id d19mr3515531oic.34.1601404801676;
        Tue, 29 Sep 2020 11:40:01 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h24sm1176969otj.33.2020.09.29.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:40:01 -0700 (PDT)
Received: (nullmailer pid 933734 invoked by uid 1000);
        Tue, 29 Sep 2020 18:40:00 -0000
Date:   Tue, 29 Sep 2020 13:40:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, trivial@kernel.org,
        linux-kernel@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH] dt-bindings: Add LM81 and DS1780 as trivial devices
Message-ID: <20200929184000.GA933637@bogus>
References: <20200923051637.30464-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923051637.30464-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 17:16:37 +1200, Chris Packham wrote:
> The LM81 and DS1780 are close relatives of the ADM9240 and already
> supported by the same driver. Document them as trivial devices.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> I wasn't sure if I should put the LM81 under "national" or "ti". In the
> end I went with "national" because of all the other existing lm8x variants.
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
