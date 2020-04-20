Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191801B1585
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 21:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDTTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 15:12:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41437 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgDTTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:12:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so9821515oia.8;
        Mon, 20 Apr 2020 12:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEdiyEyzF5/3OIaRLc3gV3pkykIsXa9nKV2IZYxgel4=;
        b=krljELPBzUPq/IuOV0ijUpU0pHszIi6qAr5nxiuXGsCJUHfh3Q4A4Z3qckDfm/mOgv
         oRw/RgYpXBre75uMZV8eV/6/b3HbnqasAnYIlJ0/wFusxNzFzAXnDsclzl0GmBC1vbOw
         u1jV/LrhqTdQP+KjI01NWuTYVDEFmfu5iQwHnBG4qKdHqVPQ/2pvYjs3Oci9YPZEFDN9
         t8JD8qrZBs2WosiaF9GkHNuf41aHiO7jh+g5o3SP8lqhfTzAr8M8CTOVfWiVEq4OIvlO
         S0jq1R8jILf+vWx5ucBWPlK1rxkrvF1+hh6u4446Lm6yGASQd81tHhfWja8ygB0/IAaH
         dDVw==
X-Gm-Message-State: AGi0PuZEmULNMO6NIoQ/X20CD3yMMClQQQww0Qp2/d/Q5qzqlKBJ1vLh
        X4DIUvSlbmDoZEQMttySDA==
X-Google-Smtp-Source: APiQypIOTpxeJOVA9/QpCyaMB4NuAAYY4PvbIbTNDLbFynkqVjNurgkpjmad0ZzFxNEnYm/RIpvAMg==
X-Received: by 2002:aca:6042:: with SMTP id u63mr688459oib.179.1587409965183;
        Mon, 20 Apr 2020 12:12:45 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p5sm81101ooa.14.2020.04.20.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:12:44 -0700 (PDT)
Received: (nullmailer pid 31561 invoked by uid 1000);
        Mon, 20 Apr 2020 19:12:43 -0000
Date:   Mon, 20 Apr 2020 14:12:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: sram: convert rockchip-pmu-sram bindings
 to yaml
Message-ID: <20200420191243.GA31486@bogus>
References: <20200411122507.4040-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411122507.4040-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 14:25:07 +0200, Johan Jonker wrote:
> Current dts files with 'rockchip-pmu-sram' compatible nodes
> are now verified with sram.yaml, although the original
> text document still exists. Merge rockchip-pmu-sram.txt
> with sram.yaml by adding it as description with an example.
> Make #address-cells, #size-cells and ranges optional
> if there are no child nodes to prevent yaml warnings.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changes v4:
>   Make some properties optional
> 
> Changes v3:
>   Document the compatible
> 
> Changed v2:
>   Merge with sram.yaml
> ---
>  .../devicetree/bindings/sram/rockchip-pmu-sram.txt | 16 -------------
>  Documentation/devicetree/bindings/sram/sram.yaml   | 26 +++++++++++++++++++---
>  2 files changed, 23 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
> 

Applied, thanks.

Rob
