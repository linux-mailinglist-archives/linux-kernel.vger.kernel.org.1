Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189512B18B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKMKB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgKMKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:01:55 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444DC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:01:36 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so7830533wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w58OruVFvZaEir64Cdqc3z6Um6BYdUEMJpA4uLf04rE=;
        b=DhgvozdTuMFbf2Qq/nw/6CMQwter5OmfvHU5SrkR8Zd+FmWEAiosRsxbL1oCrSSdHL
         NurkTyKSchUdEaDOyFzYdO4ac4Ffz1rwLzqPggC1xSDBM5UuZi+AuMBmYaTvJ65kbvVy
         Ceex/4hlFwEE7giOTQaOQZ54fPxsEKMQvOkDr9xWLOv6OzpRnizfvS/xK8zT5MJVe+jD
         lhnY+wGKKEfGBSMdMqT7Ytr5wMh3hihthMnEyg3zXPTl5CHd6vKV0TJ+HibPA0zF9yy2
         OP5qivPSwAQ79GQ1syWd6fcXbofFgkHHEUbZG2RWQCj0BMcGEhB/7eCRALVPJrWHkYVP
         qcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w58OruVFvZaEir64Cdqc3z6Um6BYdUEMJpA4uLf04rE=;
        b=U8Iv/P4FRL5yGe/SYJy7XrRr1XKcMHohQaegA2e2yZLKfB7LwBsGmKyjCuAQj5+TlS
         3pvAE6FhUYLCZfaIhTF4Z+zBWeMZJzdK7nKyKqKqHYtNygYTfKdrq5G+a16cq2/rjCkE
         87ijKCuGKlfezi1pJ5kwiHE2d1CGsrePDfJ6fwLO3iKy7Fd+drjAbWFoLLea/XHyK2FD
         nc8dT9ovtZ8jG4XK7vhSQg2pKnEJlIpqfQeUV6+0Ll5b72RY8eocYmZFS7BYndPfAdn3
         WUremqleBqAtXFbG32LZm6cbJpDc6QwO+FZnhK1ZTtdQLe8zEXbEZ7rZUWYHTmwMRdh2
         +rUQ==
X-Gm-Message-State: AOAM532xZhzKNJYXFSbyD3k8yOs0I/cqtClnrQ5XViEjMH+Rot+fMEbo
        OSVir6M0o5aaoxSyPEY/vyo6Ng==
X-Google-Smtp-Source: ABdhPJzo16ZjEH7/M3EW3rY6dkx98RWlSc6fx09X9y+orOylikrKX+LjaU2uwv15YxH0B+m9zJwB7g==
X-Received: by 2002:a1c:97:: with SMTP id 145mr1659512wma.72.1605261695451;
        Fri, 13 Nov 2020 02:01:35 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p3sm4150911wrs.50.2020.11.13.02.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:01:34 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:01:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-binding: mfd: syscon: add Rockchip QoS
 register compatibles
Message-ID: <20201113100133.GB3718728@dell>
References: <20201107170103.25608-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201107170103.25608-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020, Johan Jonker wrote:

> With the conversion of syscon.yaml minItems for compatibles
> was set to 2. Current Rockchip dtsi files only use "syscon" for
> QoS registers. Add Rockchip QoS compatibles to reduce notifications
> produced with:
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
