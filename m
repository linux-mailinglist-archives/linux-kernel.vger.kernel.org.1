Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB3A2C61BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgK0Jbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgK0Jbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:31:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:31:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id u10so1309024wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FC7Pq4N3dwtYWuoZ9YYhaq1NXLAUoypp9vfQBo5Vby8=;
        b=kL0J8D3Tx6bKH48+TC6GYWCz6zwIV8yb++Cj5LmGlZQ7046+Z9vB9W2bLq70/n6fH/
         tBKwR5jtPV7j+N5ogy29iPS0neHYXerPfKZ5dHMqbQDA+g0DDioYHTY/seu4GshNd92f
         Dpze8/0P9MFO6Xp+3uj1JpakpARBAUAcg5yNVwyFIu45In0Wnz+WmFtM1dHlx9o0R+Sp
         oUdOT/8JfPtRAnxmKcU0hPynFIageRSnAezA5rPcRxE5f3QPHlg9w0c2hj5j9Gx1HQlb
         vswtSFazOn4JJKQFoBf+4ogH8EJr5KIv6L72OwNiyZKJRXYA4+EdGN5qkJa6qV9bpUOF
         +2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FC7Pq4N3dwtYWuoZ9YYhaq1NXLAUoypp9vfQBo5Vby8=;
        b=HebbY3cyMXHUAdjYe8XZsiL/daweQswRjl9UeIyE15CJlcscQsvozD0CdYqJZqFnUG
         Vti78aq6IZAketU/FGimjcLbfTqfimSFahSTcJt9LqdpwQdrEV8nfBQy5Ckf6h9p6IHL
         omhiX+cT8axU5qw2gDZ3VWtcGYMcP/fORmGXkP6+azuO2Wv43uZtZ571PYIQg72EVlaM
         bqVrnLcgHwFgJF2WTNlZQqJXN0krL9xYr4H/99IIXM3sWMbciixKq90AdknBPlAhTQAP
         S49MQRzlaV6x+5o+ASD6m18yIppvXKl6huL/hKmpBk6OB2Sh9nGXIVh2XwccA0Ij9Qg+
         LKcg==
X-Gm-Message-State: AOAM532UELsoWjFDQ0RXWDL1wYWG8MSHAV6+16ouid5gf8VyoxH5Lo3M
        zsMcptA49L8auMbgpsk7DaIBwQ==
X-Google-Smtp-Source: ABdhPJwG+brEslAzyJH/4RPY2WTewrHY9/ajxDt5ENdxM/yGPBGpXg1oDc1A/qmESL9lF3mlAsdn0g==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr7917057wmc.130.1606469505048;
        Fri, 27 Nov 2020 01:31:45 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id b73sm20200054wmb.0.2020.11.27.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:31:44 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:31:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2/2] mfd: fix spelling mistakes
Message-ID: <20201127093142.GP2455276@dell>
References: <20201124183730.2250690-1-michael@fossekall.de>
 <20201124183730.2250690-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124183730.2250690-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020, Michael Klein wrote:

The subject line needs to be more forthcoming.

What spelling mistakes are you fixing?

Which files are being changed?

> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  drivers/regulator/da9055-regulator.c | 4 ++--
>  include/linux/mfd/da9055/reg.h       | 4 ++--
>  include/linux/mfd/si476x-core.h      | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Let's have a patch for each of these, with proper subject lines.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
