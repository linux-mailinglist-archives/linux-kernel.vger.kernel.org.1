Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6981E222668
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGPPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:03:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC391C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:03:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so10624089wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JPLGKYvPWiqpNYuL3GvYJBLgtiIfcJFyxLc31xTCZqE=;
        b=aSTygcvFj3BM54yPG1naF6qqQYQffYWkUlzNJeZjJoT68o5aTeAkMH4qxtE4XY9iTP
         sCarUxAtzrCroS/IcCStbCyqbjDMVzEfsS2lD4VAuEVR3O5U1JpbV8ibh7uN+3hJaced
         QOt4aXYuXURjbfkOWEIISm8Av4Y9cMSK9zv63agg5fZ7mRkCa3IovGYroVkETwCoyWZ5
         JN7+H3TWn28e+ExIdKksmWuYJfZr7VFsinUOrzrgQfxbgVMAqloOV5HJkLGdxsVfVXvo
         Y9ttM8CNSF2iSP/Qh4BbgeZ2OxMsqU74mW/qwAMhnrRIu0PNlbCrVaGFuVZaEPPVpWgc
         loow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JPLGKYvPWiqpNYuL3GvYJBLgtiIfcJFyxLc31xTCZqE=;
        b=IFRqvQ7rYyDoc5vibb1zQ68Ow2RCUCq6AFsp7tw1bF3/d1jWZnJQ005sGNBKz0pwNs
         BOa1tdCtJ7BpOqadR34i0KQ5KhLL9f9nLw1QHvdnpyTAAKTNMoPnuqDJdKgw1LBOZOJC
         4KJR1jKLIBOPDK8hFIgmzTq4AxbF9YmoDkbVL/Jcl2lvkgBy/aDGWNuTED+gDJQDIm3m
         svGZ8ICQnSQsO3aTp6cP12g30kBLHjiZr9+CnvR0wo1c3o8rbQz93S7ZXYTUdJZgRaKN
         4qQE24SDKRK3htOsUPO6DiFL0NOmv2Q+XXDDQklRTfhHBsTFV7T734fKELQCdpX4cdnj
         PPwA==
X-Gm-Message-State: AOAM5301zULmzvWqv0ptdiacUl1PUv2twBUCUOMYp5JCmJ4Nw/Yk5xV3
        +B0RbboBMvTg64Eb3rAStfXjqA==
X-Google-Smtp-Source: ABdhPJyvPJlcY1vqSxNpRYbkqjpGZyDiWc2jjZwif8snElap0J5LYNE0q0SFG1TJcIqCFSWkqk+aVA==
X-Received: by 2002:a1c:6354:: with SMTP id x81mr4586411wmb.98.1594911835282;
        Thu, 16 Jul 2020 08:03:55 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 133sm9452438wme.5.2020.07.16.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:03:54 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:03:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benjamin.gaignard@st.com
Subject: Re: [PATCH] dt-bindings: mfd: st,stmfx: Remove I2C unit name
Message-ID: <20200716150352.GV3165313@dell>
References: <20200702113233.5327-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200702113233.5327-1-festevam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020, Fabio Estevam wrote:

> Remove the I2C unit name to fix the following build warning with
> 'make dt_binding_check':
> 
> Warning (unit_address_vs_reg): /example-0/i2c@0: node has a unit name, but no reg or ranges property
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/st,stmfx.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
