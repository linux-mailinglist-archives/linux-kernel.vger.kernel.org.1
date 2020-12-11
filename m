Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DB02D6EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395142AbgLKDdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733054AbgLKDce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:32:34 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8998BC061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:31:48 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so6204552pgi.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y91nmoJ33/DVuxYypisPMf8rbIWy+AIDH8dAhBZDQ1w=;
        b=y0Z8hdWuCcPWIHLD8nGhmLjl6sgFkiiAFpbnABd9ffPeWvaMhXWC0lWy8trhgt50dA
         DDTlwlH4cox4K8dcvzh01RT0bobVAiT/PCmyBMD66caOcSZU8R92/MQzTUyBSfAW/P9s
         b/MCI+0Et5/G+5amGgv9s0VThc8NllwSn0Pya3Ox6q/9QuZHFUzfibQXEglI7tmjlcKd
         eerpJEoIoI2pcENH65KJm30+qVK0DAJgjOTA1CmCmz/E+mipY63Ek5OMjMY5sE94Cl5l
         HVvz2fb0MmZkaOMc8O3vY/yl+jTOLTFxx5J1uamQ/cIKMc3/Eoo0MDAoeLC+4MH9vA1a
         TtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y91nmoJ33/DVuxYypisPMf8rbIWy+AIDH8dAhBZDQ1w=;
        b=Jnb+4bmqPpI0YRBUm2DXYTOkDjT1ucnE166rylLmQnuBtp+QzJbuoOwppmU+ViCHs9
         /Y6V/JteZhzZdhxPsp0VLx+RRdya+/yYwJKlyEUxQgQWumslH6zaE+8LjAFQmqT+RnBM
         ouSaeAfE1PumSSq4/cV+oT4rc7GwK0RyeEgTphSlOSeINwmBhLwHMaP1akxmtWgeLXLM
         RAKSJ95S+V/jWJcO8C09JYn5F8bcLMZaIM4KyLm7XyFke2BF5yMvIUYc3238HPhHleRq
         SXrbksVK2ZUi+AErlM1n8EnPD5YoXN2llHk2xO5p9/ya59eplwJsCPDUpAh1dXHlKVtz
         NRAw==
X-Gm-Message-State: AOAM531W4QININxyfSD0q9UkpnDWHjy30uAgKZvIdmA6jcTHjedYTSeU
        QvDkqrrLvTy0OTN9wj6M6F3t
X-Google-Smtp-Source: ABdhPJwmYGB3znEkW5I/5BDEVH4lhxpW/+DkHztLxFxfiyIPh59HV8+xUCkDoBKyNFuQVWgaUsWBQg==
X-Received: by 2002:a65:6253:: with SMTP id q19mr9559894pgv.412.1607657507999;
        Thu, 10 Dec 2020 19:31:47 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v19sm8455043pjg.50.2020.12.10.19.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Dec 2020 19:31:46 -0800 (PST)
Date:   Fri, 11 Dec 2020 09:01:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bjorn.andersson@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: mtd: partitions: Add binding for
 Qcom SMEM parser
Message-ID: <20201211033140.GA4222@work>
References: <20201119071308.9292-1-manivannan.sadhasivam@linaro.org>
 <20201119071308.9292-2-manivannan.sadhasivam@linaro.org>
 <20201207215236.GB892840@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207215236.GB892840@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 03:52:36PM -0600, Rob Herring wrote:
> On Thu, Nov 19, 2020 at 12:43:05PM +0530, Manivannan Sadhasivam wrote:
> > Add YAML binding for Qualcomm Shared Memory (SMEM) Flash partition
> > parser.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../mtd/partitions/qcom,smem-part.yaml        | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > new file mode 100644
> > index 000000000000..cf3f8c1e035d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/qcom,smem-part.yaml
> > @@ -0,0 +1,33 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/qcom,smem-part.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm SMEM NAND flash partition parser binding
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +
> > +description: |
> > +  The Qualcomm SoCs supporting the NAND controller interface features a Shared
> > +  Memory (SMEM) based partition table scheme. The maximum partitions supported
> > +  varies between partition table revisions. V3 supports maximum 16 partitions
> > +  and V4 supports 48 partitions.
> 
> V3 vs. V4 (and any other version for that matter) is discoverable?
> 

Yes, it is discoverable based on the partition header and we do that in
the parser.

Thanks,
Mani

> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,smem-part
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    flash {
> > +        partitions {
> > +            compatible = "qcom,smem-part";
> > +        };
> > +    };
> > -- 
> > 2.17.1
> > 
