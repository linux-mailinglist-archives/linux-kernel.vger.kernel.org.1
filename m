Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540B62DC257
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLPOhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgLPOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:37:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D697C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:36:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y17so23375913wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1+xRvYA1pxFKx0XtDQ31iUMNpTfOzpYfWa3N+b1f36w=;
        b=D9tZo391U+Yk9iuy7EGvkpos9GG2gaP6lh8G8kbYcZbhPLW/ucCrLf5oSkYvVz4jUC
         kMqFUxBTvQCoj3KkuS6V35VGK9KegHusQzeK/hJ5FgEbt6klGf6JYtJ87MA0cuE8vPBP
         z8l0pVPZx/rNU6cfqxJIHMGSCWMAt4kScBC7o59D/2QzFJ7BPLD+jqxiTEIu6flAkXi5
         o6ilk+OtnZ58GRjv3g4aexcHpEoZ7S5WZ56bCKpMVHoCkBGWMhiVGT7U9Q2Mon1Bp0WB
         Fqn4DXcKrjIiKuamW7vmZ0GpkHkyHYFMsDvYschETw0d9ilE1GSKbSyBlhkmqaidaZbu
         h6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1+xRvYA1pxFKx0XtDQ31iUMNpTfOzpYfWa3N+b1f36w=;
        b=JMYwR1onfnGFGTuQpgQUMccpqqCncn1f4VCYOF6QpOvFPU4LZNyfWVZll6Fw8apfer
         vhWURdAlxcWXldoFSRoSAfAN10Ii5ZXd0xTPBLY3BtYvNzh72H7Z6uqSOyMZwTC3lK77
         RmsKpRt/WChqwYapRlXof9ihBEtkMxoObeg2xmA3ccyHIbLeVL7Ow61+POndb/TuGzl9
         Ft+OEJV6X4F4uJQSydNVlZHAgtbU4WUU0ECUj162MwQebXjxjbYg7X4mjFncJijqAbzI
         wQ18434CboZLIehAcNopzdhEWKVfC0uhLx3Y6wctglG1JV6pXYaXipuFWt1wGEMrsQV9
         FgAA==
X-Gm-Message-State: AOAM531SRplbBuvLfI0tcgFGIoqPCa9n7aINuXhwSGjdPFdnF/xOipJJ
        ZopE4HUoohzkocAi/itqN8M4HQ==
X-Google-Smtp-Source: ABdhPJylSqFMc/S45ragP2Y9ol6Qr2fab8KKBxJIm8g8W2JghL0Rj2OlBZ6f2z6RYm4SALaC6v22ig==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr38990021wrw.264.1608129379055;
        Wed, 16 Dec 2020 06:36:19 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id h20sm3675336wrb.21.2020.12.16.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:36:18 -0800 (PST)
Date:   Wed, 16 Dec 2020 14:36:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] backlight: sky81452-backlight: convert comma to
 semicolon
Message-ID: <20201216143616.GF207743@dell>
References: <20201214133458.3729-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201214133458.3729-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020, Zheng Yongjun wrote:

> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/video/backlight/sky81452-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
