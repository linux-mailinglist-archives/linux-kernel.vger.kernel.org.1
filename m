Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376561FD6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgFQVQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 17:16:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45685 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:16:53 -0400
Received: by mail-io1-f67.google.com with SMTP id y5so4581022iob.12;
        Wed, 17 Jun 2020 14:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j8CHgerKh+kCi8teLN3sFICipYAv2LGJo9hWRjpOE2w=;
        b=LVhoXB2H0KQRHdIYezkyVYOfYuoqTZ129CmCXa47vCln+2NvKbnjNGfncha2RFZ54s
         pFRdPeAfV3Ezlh1LF4NJ2KIoTrV2nmsVIVpyCqELOqPMMSyTjSkZsU589sB9LA8awqWR
         RmCowH/zXJ16mXpaZ9nzbsPUqDNaNuXJ1JXDykjnlxKYGUS6mEKlpoIdH4fXwwztqkhC
         sBNkorxbT25kYa8TzmFOEte8RQIoAWG4Rvl7AAhmPtW84cGh3wKGSl8LrzrxUFmzqUYO
         nY30K3gqLYDCm2FIxootwMIm9NKW3geDj3lhzK+XOgThWZzD1b2VU6VcP9pMtpOSbCou
         yYcg==
X-Gm-Message-State: AOAM530vKO+CjWJx3FjnhMcvfSUKR/cnJd0pwbNH+5H6nlzqFlORkt9b
        jx++0/5FA9yg/olXfxw+dw==
X-Google-Smtp-Source: ABdhPJz4vmd5HW/ld1MMrmvl7UPaTLl7RJ4RvzL8jISwi+1GHLhCRTRT9B1g3Vta6QmIHKFwG4d3QQ==
X-Received: by 2002:a6b:3805:: with SMTP id f5mr1450731ioa.41.1592428612080;
        Wed, 17 Jun 2020 14:16:52 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b73sm570734iof.13.2020.06.17.14.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:16:51 -0700 (PDT)
Received: (nullmailer pid 2837249 invoked by uid 1000);
        Wed, 17 Jun 2020 21:16:49 -0000
Date:   Wed, 17 Jun 2020 15:16:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andre.przywara@arm.com,
        vkoul@kernel.org, linux-actions@lists.infradead.org,
        cristian.ciocaltea@gmail.com, dan.j.williams@intel.com,
        robh+dt@kernel.org, afaerber@suse.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 05/10] dt-bindings: dmaengine: convert Actions Semi
 Owl SoCs bindings to yaml
Message-ID: <20200617211649.GA2837196@bogus>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-6-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591697830-16311-6-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020 15:47:05 +0530, Amit Singh Tomar wrote:
> Converts the device tree bindings for the Actions Semi Owl SoCs DMA
> Controller over to YAML schemas.
> 
> It also adds new compatible string "actions,s700-dma".
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since v3:
> 	* No change.
> Changes since v2:
>         * Addressed Rob's comments:
>            - removed unnecessary description.
>            - added unevaluatedProperties
>            - added relevant information about
>              dma-channels and dma-request
>         * Added power-domain property.
> Change since v1:
>         * Updated the description field to reflect
>           only the necessary information.
>         * replaced the maxItems field with description for each
>           controller attribute(except interrupts).
>         * Replaced the clock macro with number to keep the example
>           as independent as possible.
> 
>  New patch, was not there in RFC.
> ---
>  Documentation/devicetree/bindings/dma/owl-dma.txt  | 47 -------------
>  Documentation/devicetree/bindings/dma/owl-dma.yaml | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
