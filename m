Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077802FA6C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405194AbhARQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393212AbhARPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:13:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94579C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:12:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id h17so13714407wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xo4cfkUgfZMwC1kcTh+R01wsHW/timugPtkqWQyq1DI=;
        b=xD37iht/mX4OjCu50q30WVuJw8ug84GNpWeC1JL2TB7xhU5hKbQfiU1vLzwWbzm7ai
         9orgji42XdrU3QnvTDmdjggPxxvglJGnlz95r2S66iBqvQXcz//CAoJsNahRiV7Ll27i
         NobhaxidQcItjvL5pN4Q3cUtYeq1aJyLnZh8cJHs410I/DANGnS6Yzi3ihw8RWy2lu9d
         COgWWo8U8YpgLefjAnZIz2AzXy55VFULwirjd9/QLhowjQbSyqaH7/nQIzgZ9xjXuFDo
         Dz83tFfdL3S4ksJIFGNd6rIIKjpr4y7TOcJzxXa+qegAMg0OaEPbhlaySUHDN1HqgH9e
         /GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xo4cfkUgfZMwC1kcTh+R01wsHW/timugPtkqWQyq1DI=;
        b=A+O7Bf1FNxBDMA6zb6v905ttYHs6drmv+NoY0jwMBBjKhZAgyFZe7bG9BZhZUgxslM
         kA9NCUTec6h7gU4hw8ghotRXDPpN1c33zAmbtkq1y74SbafYyUHX6m2FBQWK7sOCs4gF
         1lonI9GP7pV7eqOWsX2v/g0odUWQVKxg/tyrMywktzAV0JmxWJtdCS6XzeCskzAbZYEG
         bE2Jz3A4zxV4RDv1qqMJcrlTa/YVZn+SWv/w5CkXcyDDwtu+5/0qirYkaN8AH/h8aATx
         YSdyIR8hwcY9qUiFmutwq8Y6nhqJzi+3AwfKsvgSxqWIvOJfamwNqFCRUCgk+oPPeIzC
         /XFg==
X-Gm-Message-State: AOAM531j5G0vecj7LjwaUD8yF8MNF5lMkMmbVxj6NDErCtMPCnpXuAF1
        VCpmy4h98ljEzkEsIADySRDxJg==
X-Google-Smtp-Source: ABdhPJx4wJ3iWN/75//5uN5rSPB596jGvskqnfTUg7OUGpbWugtg2dTzaLAbLvzLzgowUjrEcYT4CQ==
X-Received: by 2002:a1c:483:: with SMTP id 125mr21070988wme.80.1610982749381;
        Mon, 18 Jan 2021 07:12:29 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id u5sm10156512wmg.9.2021.01.18.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:12:28 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:12:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210118151227.GF4903@dell>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
 <8a152819ef89c73dd6afb5c2deb5441402fcd2fa.1610975633.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a152819ef89c73dd6afb5c2deb5441402fcd2fa.1610975633.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Mauro Carvalho Chehab wrote:

> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 133 +++++++
>  MAINTAINERS                                   |   7 +
>  drivers/mfd/Kconfig                           |  15 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/hi6421-spmi-pmic.c                | 342 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  16 -
>  drivers/staging/hikey9xx/Makefile             |   1 -
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 342 ------------------
>  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 133 -------
>  9 files changed, 498 insertions(+), 492 deletions(-)

Could you please resubmit this will the correct flags.

I believe it's the `git format-patch` -M flag that you want.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
