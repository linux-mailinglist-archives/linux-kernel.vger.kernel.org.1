Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24772E08D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 11:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgLVKbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgLVKbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:31:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2527C061793
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:31:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g25so1337147wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yjWsKgpIrIMHJTkgfV3AITTW3X6hZ0tmorI+J4SlgHk=;
        b=gSAX6vAp7rwGjwVr9KdZect0S7ffhHvL1frAWrbGRR/GIDButiKcd2wUo2svR67hsR
         uRNYfkJswpDCN6kY8KVcoVxdapcpleB9lZPz1eEHcp8ec7/4q8a/i56kwP2DeegVsire
         wXgZYHlmRvQP26en5WetBRRGrnmpnW39HajIpmljUANcMDtzc3++StWR2XK/8mgfG9+p
         drlkAL33KQEKUd27DJmhfLlrPsGeqU6JRVMuM4Pv5UA2u47hhoWU5Gna425XQ15rQaL3
         /a5tnvrJAue5thRnjUctDGyi9czxBXoIAKE+ziZjBaJ+UVD5k/jXdzJBJGgd7S8pQLEh
         C5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yjWsKgpIrIMHJTkgfV3AITTW3X6hZ0tmorI+J4SlgHk=;
        b=VJHxPLkWZVjEPVIbf71QdLF6PwvbDmdJjDGIdlKrIf1rd689eCEfamKO6C01wFixT3
         UuVSTFEWsk+7AnhQkDijXDVns9ZVqjn1VDeyhkriEOP+NTt3LiAIyQLAXfvV4Yqwm/Zj
         9u5g/9NkATn4HAhaRCzUGi48DQSnOD2nl4/KTzg3z2CDq8UYJlJ9fTjTRfMTy4pNt9Fk
         IsEs8NPyCQ8afBhFYuNayRpLXw6dAxvxazy/AGw7LGUaF123mOdk+/1J4NFz3HrypAMv
         E5WH+qMlwyjiGQnFZt4V6yLh95+XK1piuVJKmn/8iJODeMONcf207xv+KzD10el5uq8X
         WiBQ==
X-Gm-Message-State: AOAM530ltOOOgrzJE1Gjl6fvxUX6L/GptGNf3E/F382Sdw/YXoxGGQeI
        RxO0RO6mxUuLINZlJaEC20xoWg==
X-Google-Smtp-Source: ABdhPJzXGpcJch3T0AHE5uG0+3OFzMr8Axaigdjj7H1XYyRyA28dVfzU/ffnNHOMoQnte5ehH+AC8Q==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr20665428wmd.39.1608633059562;
        Tue, 22 Dec 2020 02:30:59 -0800 (PST)
Received: from dell ([91.110.221.175])
        by smtp.gmail.com with ESMTPSA id w13sm29959833wrt.52.2020.12.22.02.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 02:30:58 -0800 (PST)
Date:   Tue, 22 Dec 2020 10:30:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH] dt-bindings: mfd: mediatek: Add bindings for MT6360 PMIC
Message-ID: <20201222103056.GF53991@dell>
References: <1597912530-5374-1-git-send-email-gene.chen.richtek@gmail.com>
 <CAE+NS37_YY1aVYv-MBsxoBXCkvj7+fBK+vZke9yG7eY1aMHLKQ@mail.gmail.com>
 <CAE+NS36_HCJvk4_f_8G=5Lke87jCgHO-i0HJ-Q27vhDkacFGEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36_HCJvk4_f_8G=5Lke87jCgHO-i0HJ-Q27vhDkacFGEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020, Gene Chen wrote:

> Dear Reviewers,
> 
>     Should I wait for all sub-devices dt-binding review done, then
> send the integral binding document?

Please re-send whatever you have.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
