Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90B6274F08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgIWCch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:32:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39380 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:32:37 -0400
Received: by mail-io1-f65.google.com with SMTP id v8so15300185iom.6;
        Tue, 22 Sep 2020 19:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NGynl9EWnOYAjqDciOCA1ZUmBatnlfsqNrenSSV7b/k=;
        b=uJKkaL+IlfYuUzvDs5RBUmLPkBlx3gfdGEgz6oTTLnmFoAbBHPlAh4SYftXzgqsBpQ
         2iI3CkJMhEJoOSEDYEOvzieLRpfo2LaHs6ruzL2Y4fzYp1+vIuDmsOaXS/j95R6moNav
         dS9RikLc6X5Gm3uWb2Z5xg829eIHUx2DIu9msnZHarkAX+2vc5wxWoed1pY/hdDatdVA
         +F5H9PgFLVvgG16NNg1PO56BAZPzizXoExigRZ+Ce1REe9FOPuQLnymRKmHbRGKgXPwf
         6PH5hoyjJpZFjjRF/EwR7py1wgK7uV7Pq6QGFCavWCweZgJkoSA9gALJonluuFONGYbu
         oOeg==
X-Gm-Message-State: AOAM530BeX3TkYW6kLSje0SR8jFNL1jljk3WBCM39Rb5uveoQ5uImZjq
        cpmT6n6HGgA1ZrfziXZodg==
X-Google-Smtp-Source: ABdhPJwDBV73yoy/NurZgFoVlMxMgxpqZZdAPMmS9hFuMK14aR/cjZ35OgXoJnXbYTzujz370Sa9PQ==
X-Received: by 2002:a6b:d606:: with SMTP id w6mr5542172ioa.89.1600828356037;
        Tue, 22 Sep 2020 19:32:36 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j77sm10301353ili.31.2020.09.22.19.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 19:32:35 -0700 (PDT)
Received: (nullmailer pid 3757322 invoked by uid 1000);
        Wed, 23 Sep 2020 02:32:34 -0000
Date:   Tue, 22 Sep 2020 20:32:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH 1/5] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr1-alt-addr' property
Message-ID: <20200923023234.GA3751572@bogus>
References: <20200916081831.24747-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916081831.24747-1-ran.wang_1@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 04:18:27PM +0800, Ran Wang wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The 'fsl,ippdexpcr1-alt-addr' property is used to handle an errata A-008646
> on LS1021A
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> index 5a33619..1be58a3 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -34,6 +34,11 @@ Chassis Version		Example Chips
>  Optional properties:
>   - little-endian : RCPM register block is Little Endian. Without it RCPM
>     will be Big Endian (default case).
> + - fsl,ippdexpcr1-alt-addr : The property is related to a hardware issue
> +   on SoC LS1021A and only needed on SoC LS1021A.
> +   Must include 2 entries:
> +   The first entry must be a link to the SCFG device node.
> +   The 2nd entry must be offset of register IPPDEXPCR1 in SCFG.

You don't need a DT change for this. You can find SCFG node by its 
compatible string and then the offset should be known given this issue 
is only on 1 SoC.

Rob
