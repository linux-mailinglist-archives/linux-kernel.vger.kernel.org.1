Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE34F1E5402
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 04:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgE1CfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 22:35:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44905 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1CfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:35:11 -0400
Received: by mail-io1-f66.google.com with SMTP id p20so14943733iop.11;
        Wed, 27 May 2020 19:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u/PpNpDq33wQ8xTbOoeK0ybsgUquiVhQDT9k1mJd3Ww=;
        b=OGuzkBXduGCKBYi8qGmvnOYDPFl0HKOvrI6cUz+P5x0mR3D0thd83cPQ/BVHbjiu1A
         vRBFTIV/Vor5MWwFc8bs7HtkEyUjEpTe9SfXPku/7AirE482XWOkrhsJKUpPvaFsYhKk
         H9paTKmrmBHpDWnsNd7alfuPERh6K/bUsp6/oZAWG/e9wVei6WWSiCwKRdW5/hhNHJAC
         yAKRc9AbmxDcQbLYQHTck2nyy99jgwtH+e+05J2viGo/8mBs7pqlwfZB52rrFV88bCTV
         /fcapsOYnDglhe2CIvgSLExuWJmtf70vWcTUV8Z32o8pIfBxVUFLBMN98mn6VybkW1Ei
         L21g==
X-Gm-Message-State: AOAM533W40xGywxtMFkKedVDTjG5u2GL6MSaP/0A7AahfFYkS+1GfkRO
        m+XI/ZrgeRuSy0Oy1/pNmg==
X-Google-Smtp-Source: ABdhPJyqrqqmOmLOGh+9h8XWMQ5/kD3UO07/QUdxEeNf8swgGrODBM+jiAODXcQp9bhZRn9CeHtJqg==
X-Received: by 2002:a05:6602:2408:: with SMTP id s8mr696349ioa.78.1590633310262;
        Wed, 27 May 2020 19:35:10 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u25sm1931639iob.19.2020.05.27.19.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:35:09 -0700 (PDT)
Received: (nullmailer pid 3251663 invoked by uid 1000);
        Thu, 28 May 2020 02:35:08 -0000
Date:   Wed, 27 May 2020 20:35:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, patches@opensource.cirrus.com,
        linus.walleij@linaro.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        cw00.choi@samsung.com, devicetree@vger.kernel.org,
        broonie@kernel.org, myungjoo.ham@samsung.com
Subject: Re: [PATCH v3 7/7] mfd: madera: Move binding over to dtschema
Message-ID: <20200528023508.GC3251118@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-7-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-7-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 10:57:20 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v2:
>  - Removed some more redundant descriptions
>  - Updated pinctrl node naming in the example
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/mfd/cirrus,madera.yaml     | 311 +++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/madera.txt   | 114 --------
>  MAINTAINERS                                        |   6 +-
>  3 files changed, 314 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
> 

Applied, thanks!
