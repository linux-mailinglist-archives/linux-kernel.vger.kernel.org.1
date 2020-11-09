Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B12AC64C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgKIUuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgKIUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:50:04 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33274C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:50:03 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h6so8173758pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKhVM4NUHmcm6H7xPx49n/ZxgPOgimRMEfPA5U/h4i0=;
        b=CSwyQgoc35NGUreMQWvGSPoB9vNasHgboPOgk51nBJroaY9p+6x55qvuSEukwclJS3
         XPOicRxq9oI9X8BytyWmlzQ+YpoAk2aL0xJwxbmvIgRyq0C6PeGS+xZUa0cuC+yeUkIJ
         3n+GsIkQUsMVTBc5S8K8sfvDchWmlF3aIaKYBtTJ/XSwKfAGsyAhdWELSNwulerDkG5z
         ZvMvK42DPhe4Q98AX6Y9hHkgIuhk/TMd3vtPXE/jW6hV2H64U3bRBKfqFlx8CTdwjMes
         KTPAsV9ra7l/y3rIAzLLXM9KlMMzTi+rDpr64VZQjr8nhvHL5r6NYOsD9sCevoEbBnnc
         nfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKhVM4NUHmcm6H7xPx49n/ZxgPOgimRMEfPA5U/h4i0=;
        b=EYgEsEXIDmFbsGt0aBghYYKy1hA4qQG4l1uP9rEmRCh8ek2HiSeuMgP1brHfoOXQEF
         +JgtAwqmT5BjlQ/9gbw7fOSdEJ0RljReUhVRLFu3voqSGVkC0D5pa5FMUr5u5k5P3kO5
         geSIphdKPLNbdazbV0y9T7z5DDIzPwBU4eqKuxAjSQmlCUycC+lqCBBSqtr3gYZ3rNxE
         +70Eox/TMtBxKGQNdNp2d2F4KA+cFJ2FGM/qnEWSfKIJwytOC41ZRIGa+krKieE6WBkL
         yObpoPGeCbEsnHP9+v1SKZoxzGhqD4LE7CX/hYdW2wh2wEIX1F/xZgj7578PJ+CmeRd9
         p4Dw==
X-Gm-Message-State: AOAM530aoRyAStZml5hv6IDDXhtMMOA/MF80vwva50T2eWFrrrYUJK2X
        SYsXVLhf3zMHZHG5MpSJpk3idA==
X-Google-Smtp-Source: ABdhPJzF+apqzraZ7smZ2Ggz1Ue8cGC/n+Vsd99uNMr5AkS+QmaehTdmxa47iUXKb8vFWC9KSR1bqA==
X-Received: by 2002:aa7:8a97:0:b029:160:c0b:671a with SMTP id a23-20020aa78a970000b02901600c0b671amr15025126pfc.16.1604955002602;
        Mon, 09 Nov 2020 12:50:02 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c2sm11669670pfb.196.2020.11.09.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:50:02 -0800 (PST)
Date:   Mon, 9 Nov 2020 13:50:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 26/26] dts: bindings: coresight: ETM system register
 access only units
Message-ID: <20201109205000.GE3396611@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-28-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-28-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:45PM +0000, Suzuki K Poulose wrote:
> Document the bindings for ETMs with system register accesses.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index d711676b4a51..bff96a550102 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -34,9 +34,12 @@ its hardware characteristcs.
>  					Program Flow Trace Macrocell:
>  			"arm,coresight-etm3x", "arm,primecell";
>  
> -		- Embedded Trace Macrocell (version 4.x):
> +		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
>  			"arm,coresight-etm4x", "arm,primecell";
>  
> +		- Embedded Trace Macrocell with system register access only.
> +			"arm,coresight-etm-sysreg";

Please make this "arm,coresight-etm4x-sysreg".  Up to now all reference of
"etm" without a version related to ETMv3/PTM1.1.  If we start mixing things it
will be come insanely confusing.

Thanks,
Mathieu

> +
>  		- Coresight programmable Replicator :
>  			"arm,coresight-dynamic-replicator", "arm,primecell";
>  
> -- 
> 2.24.1
> 
