Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF30227FC3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgJAJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:10:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E152C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 02:10:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v12so2203063wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OqYeGnQSQwhZ/e/vDbKe6Z9MFEMvauFkIAR+AyLSu6U=;
        b=o6GrHDlyWQ1Xu8gkqQa6CyxIaNDdJPzX4iaQWbrF4lvI3jIgd/Ga+UQRbb97B44Oz5
         cJnZ58Bhl/7UxizKT9VLi5RQDyPpfn905dnuYhUM66rc313TCq29D3WIpaa0xNkFkD3s
         cjJLTqaVdi3A9bLg0a9A7p77/IB8ELLFLoCYtGket/FUHA3DQcgf1w9RJ05yZ++/iGDX
         33HrBZVKcr6XNk0SVL2lhz5Kdix1N53TaEX6wBbyE9U8gEeNUV3nN/+6BHL4Xi3Kmxsc
         lDQtnkfneM9taTo0nF1HAO0NLPOHQljBZqd69gR0CSCp5YyUBIRLHcm4hXDTDKJ+HZ8X
         ijKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OqYeGnQSQwhZ/e/vDbKe6Z9MFEMvauFkIAR+AyLSu6U=;
        b=pIBuXiPUWi2go/ZuZxR9wPrsCWE9Of3m4rp5lcDYWhan5Rb7f4ju6oSRlRTWAroLyD
         RCYkO6TmwyS091OHRU833JThzp9uJxsJhNUv7QjN+gByG1TUxPS20biYAv01C1PedgHk
         4s8zCA9+wRfJpKWjYnv+tE9qZr1+tn5xitf55l1GrI0GznUiF50tlFyNT875wWu25o3j
         aB3n2641pjuABZIjuNI0rjRhsF/7Io0LM6kZ7SL6QQ/KHIGTut7fEA0glFtfc1p4+ycb
         ZlA9jDrGkruR5mNSla+AcIhjUxjBIsy5hUNUscc59yrRfUMSIi46t7sRpNOerEkieDoT
         TX/w==
X-Gm-Message-State: AOAM5313zJ6+oJ+ZzX3G4bVL7gN6ojtdjpzrwaijTZxMtJ9BQsh+UUAH
        0YX8RoMr8TOFBcLJarTNLTQGNA==
X-Google-Smtp-Source: ABdhPJx1RF21ZOcysPcrco4kHwwwHAg/sHdiRg7TsXuQndvg9yy/CDfpNc0jB7zNS9kDQpLlK6WkJQ==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr7706622wma.32.1601543426714;
        Thu, 01 Oct 2020 02:10:26 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t6sm9431729wre.30.2020.10.01.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 02:10:25 -0700 (PDT)
Date:   Thu, 1 Oct 2020 10:10:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v5 04/10] mfd: mt6360: Combine mt6360 pmic/ldo resources
 into mt6360 regulator resources
Message-ID: <20201001091024.GN6148@dell>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600770019-11585-5-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1600770019-11585-5-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Combine mt6360 pmic/ldo resources into mt6360 regulator resources
> to simplify the similar resources object.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
