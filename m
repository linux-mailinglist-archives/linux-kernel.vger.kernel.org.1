Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569822A3692
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgKBWfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKBWfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:35:01 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4DC061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 14:35:00 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id k3so2318206otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 14:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=giKh0EftA82tuJhV/2S7wBVQ3F/DRKViWRoogNmdeAs=;
        b=bMjC70YDFNzxoYlzw3H4miSI+md12fBuXXRV+rwrxZNgxWyRnMyTM+RWdzZ6Ttz749
         qIIdxenAT6JyLXCwFjJitCGNE6NtAlVOcEEtfTUjNVkaVwsAoeI3RaqPS4D/rQ41mRK8
         z3nwRyBpd8Ml+jwQDxOK/7nlBFt0Djs9ILL65ZgnvMynhhR27O398RD3vR5DnLjyu/Ie
         0deUipDZvLwmfe+gEyooVVrypE5oA2lbHsfTFWrWkiEIJWAq+v5z3MAKaUgfd1hrZSN1
         bHZcEhtLfdvM6dOu16hu7EtkxCguPo4OJbabmtS2AIJDZ6yMJDWAD2EOTlApdxVN4KJz
         5jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=giKh0EftA82tuJhV/2S7wBVQ3F/DRKViWRoogNmdeAs=;
        b=a0JXvRnAHL+TVTLZ2CSleAam44uSNLtpBhZga4DGYyJvTKSP9/eESwbQARmpLJqjGx
         2PXcYk8jHt+FzE0VcxfG8YZQsSRB71ypb7+dooja0ctbAr0mrY4jCBoiNl8izwbWWd89
         Z7dtRkrxmOELjpI8Eww4oEANvrmIghD5I6E4OlVaioZrL6emfulR9KtL79NbSrQBz3Pi
         xpIkz8LOfpU/n6xXGuHb874xj8SeMBdBeVYabyG/kZHSr69ox00k8xK+PTPezDOiyrli
         X9f1vjfQKR/NxRBNuNnxB84wS3GhELiXW5O4wpewRBsINboLu+rWm5qO+pjasrtFglvY
         vDRA==
X-Gm-Message-State: AOAM532gIsogSVbPEUB7A0pvQid5QVaB8EN3Wm3mmInqkjpBck5F5csb
        7WI6FcI5bBmVhzZoddWgj91DxQ==
X-Google-Smtp-Source: ABdhPJwkR59N/fd3voUgFTNORY4EDE77itPKKZtqgX4oFS6zefiiLytSDfijNYsgP9sr1OFQXdN3CA==
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr13973004oti.25.1604356499596;
        Mon, 02 Nov 2020 14:34:59 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b16sm3929519oti.4.2020.11.02.14.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 14:34:58 -0800 (PST)
Date:   Mon, 2 Nov 2020 16:34:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] nvmem: qfprom: Avoid untouchable regions
Message-ID: <20201102223457.GA65067@builder.lan>
References: <20201029002827.1729915-1-evgreen@chromium.org>
 <0a7d86ee-96b0-eff8-e315-ff65086661ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7d86ee-96b0-eff8-e315-ff65086661ee@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Nov 09:58 CST 2020, Srinivas Kandagatla wrote:

> 
> 
> On 29/10/2020 00:28, Evan Green wrote:
> > Certain fuses are protected by the XPU such that the AP cannot
> > access them. Attempting to do so causes an SError. Introduce an
> > SoC-specific compatible string, and introduce support into the
> > nvmem core to avoid accessing specified regions. Then use those
> > new elements in the qfprom driver to avoid SErrors when usermode
> > accesses certain registers.
> > 
> > Changes in v3:
> >   - Fixed example (Doug and rob-bot)
> >   - Use min()/max() macros instead of defining my own (Doug)
> >   - Comment changes to indicate sorting (Doug)
> >   - Add function to validate keepouts are proper (Doug)
> > 
> > Changes in v2:
> >   - Add other soc compatible strings (Doug)
> >   - Fix compatible string definition (Doug)
> >   - Introduced keepout regions into the core (Srini)
> >   - Use new core support in qfprom (Srini)
> > 
> > Evan Green (4):
> >    dt-bindings: nvmem: Add soc qfprom compatible strings
> >    arm64: dts: qcom: sc7180: Add soc-specific qfprom compat string
> >    nvmem: core: Add support for keepout regions
> >    nvmem: qfprom: Don't touch certain fuses
> 
> Except dts patch, I have applied all the patches, dts patch should go via
> arm-soc tree!
> 

And I've picked the dts patch.

Thank you,
Bjorn

> 
> --srini
> 
> > 
> >   .../bindings/nvmem/qcom,qfprom.yaml           |  17 +-
> >   arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
> >   drivers/nvmem/core.c                          | 153 +++++++++++++++++-
> >   drivers/nvmem/qfprom.c                        |  30 ++++
> >   include/linux/nvmem-provider.h                |  17 ++
> >   5 files changed, 211 insertions(+), 8 deletions(-)
> > 
