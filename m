Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6492C6696
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgK0NTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgK0NTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:19:13 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:19:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so5540165wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cUssLBcwrnl4wS0sT7u1HD0EzT2Je15NNYiB1zueAPA=;
        b=e3hd6rbMCkbStlgzWWHksKID1Wt/3RiCeCPnRx8E3TDI0swphfpcVEN9fRe7eJOjnc
         vkcNMM8R6eKzT60PWSsAJcNhCgzr/n1vXy+on8eYLwYchmiGlTMPKFXy2KFvUmzipEoz
         EkRzJJTXPVBkHasL/CZBV+Bx4hjAubRNZzWoNSaqj+JGmpEeFsk9qyEy0nStKIPbNa77
         lWGt8RHFguietSlDluRo/iEdeuxORU1ih/+61/MMsQFTxltXIsYqdOs878VriuB+adf9
         R28kVlzE+LRSTShL/XWOCVRPT3TXxoNutbOstlqtOUEYZGIPh+6nPhKDyEbqbd1I33WT
         35+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cUssLBcwrnl4wS0sT7u1HD0EzT2Je15NNYiB1zueAPA=;
        b=fPLgaOQyBjuL1br5C3iwaJIf2LNGRgAyMcjq39qsf7mtuKEEUi99bL3p1uks9gmQfo
         VD/Ag4rMsgmEW1KMCwsMJszS7P8P2L98IiYcdIG9QMTJNblfOC/qVtHQaTv3LbOqDbqI
         G7fc3Z/mRnSOM3vHdfZoypMkZJdkfxHjqeUqsWbYU1QLDzUVjtBoRz6oCb2N2zPIxele
         0tFGGDJEDzQhjS3PEJapxNQ4y243zF0UD7oS36hr4t5suObD1v24RyUYCyZm5yeu2lD/
         fXG9cpgNJ9NxyExqGVxS7fs8qyKZsRg04V/f9YWFWYhBSwlAiYRmDg+oVLHfmp+vKeas
         Sq6Q==
X-Gm-Message-State: AOAM53101xLVxlG6eLF736qBhUNkUvzi1XzqKjd7k9i1qSjuOeYnBIsp
        BVtwdfz+uiZb50Fgl++KciIrNA==
X-Google-Smtp-Source: ABdhPJx8ccoTTjDG6yUPHYKFJmxXCc/FNOFN7yibNRVN7eMdfUHVq7mod2/HjJ/AgEegjRImUOxItQ==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr10305303wre.383.1606483152098;
        Fri, 27 Nov 2020 05:19:12 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id p4sm14915932wrm.51.2020.11.27.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:19:11 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:19:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH v2 2/3] mfd: si476x-core.h: fix "regulator" spelling in
 comment
Message-ID: <20201127131908.GT2455276@dell>
References: <20201127093142.GP2455276@dell>
 <20201127125202.23917-1-michael@fossekall.de>
 <20201127125202.23917-2-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127125202.23917-2-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020, Michael Klein wrote:

> "regualtor" -> "regulator"
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
> Changes in v2:
>   - split patch
>   - make subject line more forthcoming
> 
>  include/linux/mfd/si476x-core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
