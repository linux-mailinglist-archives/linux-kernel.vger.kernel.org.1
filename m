Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740C029D429
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgJ1VuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgJ1Vt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:49:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C85C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:49:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j5so285558plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyZXe4UlIiJyEgA29yuKS3oeW8M7zKVy8IBiRsmYAmc=;
        b=onAmLV9juNbP7wo91heam4H8gAMYtfy0venQZrmZZMNDJ8HiSHuuZ+CS/6A/yrwoSy
         ZZNOgWqUW4BH3NZGYK6+7vUXkGUv/DTH/Bfzi6Ln8fRJBp8+Cyb29Ra3Jy4YdefTcDo/
         zGGjvWhGYKGbs1ClJV+Ye7VjWBEJ3XORqgnVA4dlgEbukbSJ7Bcx9oRwo+L6XeApeMcx
         FdZha+HtwNipI11KsEjqoYfnLUDq5xnY3NObfd4sQySAytfwzKMntQM/bYaoqkpDl/Z5
         UzZfGapIufvzWiB4QEkzOuPpfvs+I8KiQ4YFpJ73sM1046oIlPRkgLy7DXNTV7u7ufqC
         jxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyZXe4UlIiJyEgA29yuKS3oeW8M7zKVy8IBiRsmYAmc=;
        b=AUhkBeBCIZIQrA4ewGVhIRL6ABstOVGZiCvQXhCb4RAwxORn/8qiGepjN1My3VqtZH
         RJidFyCcBWQ0UeubSD//pB/T4AzLbcdg6ll8GT++RTz+7ahl82y5VVA5UIKXDJ7H7wxm
         E8pRYiSTjxpa9+T9SK29rom6Ui/++TiPz0J2NJHf7ZE0g/TMYlLT8G0Pgp+Tpt6sCAtL
         kKMoqrOzd5Jl+Y8pkTFQQKkHmwnkI/ekhOpaDh6oo6GQo6yVt/KHuv3N7lT6CzxBljr8
         irg4ZA3uYaLUAxqY3TKvTk7n9WHA8QmrYYfG+ajk9I40Re7Q3ck6hXCaOEJNH2LA/GZz
         lWLw==
X-Gm-Message-State: AOAM5333evVYObRFfXhqd5PxzfRNWX0MxoXkV4ijHVRmjHtwK9oliJW1
        FvYOd9JnsWV8owi6DZJeEGmu+cJAUnSA
X-Google-Smtp-Source: ABdhPJy4wp8FcMTLG82s6NTTpGozSLiiRiD9djXMWJMN+OzFd+L2lYlZ4UuNtdVzO4TBLhilRIP1pA==
X-Received: by 2002:a62:be04:0:b029:15d:7423:e320 with SMTP id l4-20020a62be040000b029015d7423e320mr8247134pff.42.1603904943114;
        Wed, 28 Oct 2020 10:09:03 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e05:4ccd:292c:2726:5b8f:786d])
        by smtp.gmail.com with ESMTPSA id h13sm187608pfk.23.2020.10.28.10.08.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Oct 2020 10:09:02 -0700 (PDT)
Date:   Wed, 28 Oct 2020 22:38:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add GCC and RPMh clock support for SDX55
Message-ID: <20201028170853.GA3191@Mani-XPS-13-9360>
References: <20201028074232.22922-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028074232.22922-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 01:12:28PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds Global Clock Controller (GCC) and RPMh clock support
> for SDX55 SoC from Qualcomm with relevant DT bindings.
> 
> This series has been tested on SDX55 MTP board. The dts patches for this
> SoC/board will be posted later.
> 
> Thanks,
> Mani
> 
> Manivannan Sadhasivam (1):
>   clk: qcom: Add support for SDX55 RPMh clocks
> 
> Naveen Yadav (1):
>   clk: qcom: Add SDX55 GCC support

Bjorn, I've inherited the gcc driver from downstream and did some modification.
But I'm not sure if I can take the authorship of this patch hence kept it to the
downstream author.

In my point of view, the downstream author wrote the driver so I should keep
the copyright and even list them as MODULE_AUTHOR. But I don't think I should
give the patch authorship to them because I haven't received the patch anyhow.
I usually keep the authorship if I take the patch from a source like LKML and
repost it. But in this case, I authored the patch using someone's code!

What is your view on this?

Thanks,
Mani

> 
> Vinod Koul (2):
>   dt-bindings: clock: Add SDX55 GCC clock bindings
>   dt-bindings: clock: Introduce RPMHCC bindings for SDX55
> 
>  .../bindings/clock/qcom,gcc-sdx55.yaml        |   71 +
>  .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
>  drivers/clk/qcom/Kconfig                      |    8 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/clk-rpmh.c                   |   20 +
>  drivers/clk/qcom/gcc-sdx55.c                  | 1667 +++++++++++++++++
>  include/dt-bindings/clock/qcom,gcc-sdx55.h    |  112 ++
>  include/dt-bindings/clock/qcom,rpmh.h         |    1 +
>  8 files changed, 1881 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml
>  create mode 100644 drivers/clk/qcom/gcc-sdx55.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx55.h
> 
> -- 
> 2.17.1
> 
