Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04312D2F20
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgLHQIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:08:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36676 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgLHQIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:08:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id y24so16270622otk.3;
        Tue, 08 Dec 2020 08:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mweAoRAMYtGzuxRv3uHviTPgdKnfEr7b5CEQKG4Rgn8=;
        b=mOcgdrtGRUuVS6v7C2JdZNaq6ZDx1MYDjCDcJ6bTZYuL3GZvZkVC9SyYnN91qLJkD0
         HTdUVSll/r2+yZPApXZI97HlzZSGcJFlZpgLBMlhcE8+1jiKQRVvYNAPmYPPEmfnVTPq
         vCZRhDgdq39LTD2kn7TlmbGUZ7k3oWxIT+W6mztbI6XXmIBBguGSwSy1lD03ZMcveQeZ
         lLcVqpDCTG5VO5+5RLObHzfThKwy+1XUAl8AwDjIj6LcQ1VHdlTXRI48dlL7xl3xkvw3
         wLVxK21mRJIoiEVdRom4kSKDyZtEoJePnRxoxW1BrXapdu95MT2zXku+AZu3d6my/cO7
         EYTQ==
X-Gm-Message-State: AOAM533+cQEEpczP7uFQn+B3JZbtm1k5KgHP54g/yeVwAe6R13nnh40h
        KEgDCxDE4YlG5M1Zhoejnw==
X-Google-Smtp-Source: ABdhPJxnVjacUosb5YctPA7wCq3YhI515oWeUV2l8wXXDI4R4fgyB8WycWyotta9RbO6dfQ4tHVi6g==
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr17388620oth.250.1607443685461;
        Tue, 08 Dec 2020 08:08:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p3sm3472992otf.3.2020.12.08.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:08:04 -0800 (PST)
Received: (nullmailer pid 2618576 invoked by uid 1000);
        Tue, 08 Dec 2020 16:08:02 -0000
Date:   Tue, 8 Dec 2020 10:08:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, paul.walmsley@sifive.com,
        robh+dt@kernel.org, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, sboyd@kernel.org
Subject: Re: [PATCH] dt-bindings: fu740: prci: add YAML documentation for the
 FU740 PRCI
Message-ID: <20201208160802.GA2618546@robh.at.kernel.org>
References: <20201126030043.67390-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126030043.67390-1-zong.li@sifive.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 11:00:43 +0800, Zong Li wrote:
> Add YAML DT binding documentation for the SiFive FU740 PRCI. The
> link of unmatched board as follow, the U740-C000 manual would be present
> in the same page later.
> 
>     https://www.sifive.com/boards/hifive-unmatched
> 
> Passes dt_binding_check.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  .../bindings/clock/sifive/fu740-prci.yaml     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu740-prci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
