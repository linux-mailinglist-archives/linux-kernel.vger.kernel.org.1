Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8B225A39
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 10:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGTIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:40:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A9C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:40:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z2so16980961wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BlDAyGJ84Q1MRWobMfZ2vz9Jimz7XhVN3a5fTfxyjNs=;
        b=a13MgTJMMzogWZOltIcLHCW2hq/KoC1zE+dDLltAUYUmzQdrJr6tjEV7VvDiZhuwlR
         Yo8nZFNRL38L5Dz8X3OVwcnAstv4WrCyEZHaDPLuhZfmcSQsxB0yh4k+Pe0dq3B8lgom
         a1fVL49DUFm6GOW+EQ7e26z7d3pBDRTjIUH9n9fv1VxnnqvNe7NxWTODXkZ6KoRJ+Ylj
         0+HOSJBs6HCVE4vDY2IN7+CoX41S4wpZ/s2smuQtKTkSdez12xKk3wazc7/uVQ8UGx2M
         RuhaboOxHn15h63TyfYdNKSvO2uY9NF0qNgfmuZY4FZn3R5ymv2GcWg7pRdUAKBHR5t9
         h3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BlDAyGJ84Q1MRWobMfZ2vz9Jimz7XhVN3a5fTfxyjNs=;
        b=A0EggHGf3oAJdUWK8lvHpNKEfa9yiZFi6xwUBERp+hD3AkqWdKkuICceCjM0u7cvkF
         Ty+rYMdzUFyreIJ4VCFdIhYUcjR6cXe5azXiBqOlSl9jUFE/eACD2B1hhGhejDv/jGGJ
         jK1Zi1VD12HALnHH8u+/G+E/0EJZJJdYE8+67GnnmnNaZZ8XMCIp5VZT4UisHiWUU2kd
         3flfJ+wo1RpK88d/0r6EZBxgtqNApUAqukZES5ZtSUqAa0KVNUA8gbi+HGRR6ElENH+z
         9sZkHcMDojLZtmNxw9t2XTyPJugCNUxm7okmuJJMFnLp1TAmKBBGRDWrAUeZPTIQKFtd
         iDZQ==
X-Gm-Message-State: AOAM530jQ6r/yDohiHdYC+S8TIGe0+oY27kAF3BEWbkQPifmiMxXHdBA
        gfSZwzzBxLp0ViQ+tQ3xxIWdAQ==
X-Google-Smtp-Source: ABdhPJxvqyPIo2tbAstdzEdwSSMus8KQtHJorvgTkfjy+Kqv+jAGv/J+zdFKKQEDaZRQHlz2b5jYvw==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr22778978wrp.249.1595234442821;
        Mon, 20 Jul 2020 01:40:42 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id x11sm29153952wmc.26.2020.07.20.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 01:40:42 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:40:40 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: amlogic: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200720084040.GA23952@Red>
References: <20200716090411.13573-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090411.13573-1-miaoqinglang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:04:11PM +0800, Qinglang Miao wrote:
> From: Liu Shixin <liushixin2@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-core.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 

Acked-by: Corentin Labbe <clabbe@baylibre.com>
Tested-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
