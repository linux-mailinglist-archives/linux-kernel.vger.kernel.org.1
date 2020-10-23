Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265A92974C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbgJWQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:41:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34792 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbgJWQlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:41:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id k3so1362712otp.1;
        Fri, 23 Oct 2020 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDWtMyYSLVePrS01DufFEOfcUdCjtavoaAvC7J8Gwks=;
        b=F0TjQLftHnVCX//1FFLSy5sp5jTXha95YUtNrCokdwPykt+o6XsBKPSoewMKXkp5QG
         JkP6yr4JEH+MAtiLpKdkGjXzJ91BKt7/L2HB/20+fAfv1a0j4JXfakVawpH64NZ2P30C
         nxHaqOXhfTLPY2JaNFZ0LSzjz/jqdVjyY7K+8Ju7PXYRuac+stwSi8IKl9ld3+3zQjOR
         1m+ukTbsMGQZy1ABxIWJtNbIJ8ewo0KB/zkfHz51msTXAj8WIDegWVVqBAZu2IY4edbu
         Tfc79vk19EouRbbAr777S1KeWXvsZy8kkUdFmnKhH6BN5c6HHHH4HaOBSmIkw/EScpWd
         k2vg==
X-Gm-Message-State: AOAM530JhB4tfuS1+PVwg/Iqg16jWJ4+CLzkmw17cZ2Isdp1Z5i2Y3u6
        ITCAjmABE+zs2DznSaudcQ==
X-Google-Smtp-Source: ABdhPJx2fxYbzud+b/OdnVyfZqAZrkhfAmTT58S9MYcyhy1Av6UFaKRLE2gPsxz4PAXSTNSs0fgujg==
X-Received: by 2002:a9d:7502:: with SMTP id r2mr2180159otk.82.1603471263808;
        Fri, 23 Oct 2020 09:41:03 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 8sm577628oii.45.2020.10.23.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:41:03 -0700 (PDT)
Received: (nullmailer pid 2838954 invoked by uid 1000);
        Fri, 23 Oct 2020 16:41:02 -0000
Date:   Fri, 23 Oct 2020 11:41:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        David Jander <david@protonic.nl>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add an entry for
 Van der Laan b.v.
Message-ID: <20201023164102.GA2838572@bogus>
References: <20201022102733.3277-1-o.rempel@pengutronix.de>
 <20201022102733.3277-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022102733.3277-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 12:27:31 +0200, Oleksij Rempel wrote:
> Add "vdl" entry for Van der Laan b.v.: https://www.teamvdl.nl/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

