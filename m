Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED39C1DD7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgEUUAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 16:00:46 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33592 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgEUUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:00:46 -0400
Received: by mail-il1-f195.google.com with SMTP id y17so6272213ilg.0;
        Thu, 21 May 2020 13:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlH5ZMWcJXqsxFCIRSX97tK4Flrr0jYmclOA4NT0Xj8=;
        b=KLPoyX3YS8pVazb7v4+Yezexg1P9Bb+08Kr9wYr0qvgIG5951jRNQq4AOzzEvk8fBV
         eyoitcCb0aKYBXQH48qwD57KsQndgxAw1yZBkKkZhS1XepcFhegMayH0lsm3my5T8NRk
         EFRuwGplPPZ3gw/UCG29EE3GtMaqUUIR+xqYziWFFL5A0gaOg08f+PZgE9hkn5MEiQNw
         8V6tf2qg8JA1dFQEEnbz0pMHWuQyJRyXPMo4dK05UhaHi49HLdn1FNVUSmhJhjq0x2L4
         OmK+CCbiAimvG6t7VrpmZ0TmSqPVTJCG9XZSpHuoK1KzdkUY5Ygb3uo/eFoeyotUS7Fx
         rqhA==
X-Gm-Message-State: AOAM533xZ3P43A+oNBfD01uY1LSLGWvY8zzNhBvT/zgVQMzs3iAE/n7P
        6yJLeq5RjujWnwr+4BLcFA==
X-Google-Smtp-Source: ABdhPJzO+8vNli6MJWPcPhp4AusITCDDAPwhu7cO7WuDbpzKtQj5Ru8KuWfEvku9pagBIN5SJF0Kiw==
X-Received: by 2002:a05:6e02:544:: with SMTP id i4mr10547846ils.266.1590091245276;
        Thu, 21 May 2020 13:00:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t17sm3353322ilo.60.2020.05.21.13.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 13:00:44 -0700 (PDT)
Received: (nullmailer pid 2802949 invoked by uid 1000);
        Thu, 21 May 2020 20:00:43 -0000
Date:   Thu, 21 May 2020 14:00:43 -0600
From:   robh@kernel.org
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mfd: Add ENE KB3930 Embedded
 Controller binding
Message-ID: <20200521200043.GA2802919@bogus>
References: <20200521115407.2249702-1-lkundrak@v3.sk>
 <20200521115407.2249702-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521115407.2249702-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 13:54:06 +0200, Lubomir Rintel wrote:
> Add binding document for the ENE KB3930 Embedded Controller.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Addressed binding validation failure
> ---
>  .../devicetree/bindings/mfd/ene-kb3930.yaml   | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb3930.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

