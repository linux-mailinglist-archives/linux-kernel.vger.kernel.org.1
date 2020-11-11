Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8672AE624
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 03:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgKKCIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 21:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732023AbgKKCIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 21:08:50 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38967C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:08:50 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id t8so313616vsr.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CTtCQABE7EZnyvMRJRp+ux2mvwXMPszr5VQjn2UmnU=;
        b=D4hYa65WfHrMf5alNOxHlfnicpj9Vucke/Ha0ieZmTy4CL5qv4AS08Mzgf3N5Dg3LP
         GloHepCI0Djj9Hb7x1bp/ejfxwmZbgkM7XrU5q5Yi+icuTUuhAI/m93GEiWOeeHuvt2h
         QW6MGb5eCzhsMdU4s31tUXt4719VQbYGFbwL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CTtCQABE7EZnyvMRJRp+ux2mvwXMPszr5VQjn2UmnU=;
        b=meZK3a9sGWu+/qUH00ZitLARkO6EMGbh4yZIFEKcc6IiFda4uHRSVpo+pGcnvgwbPV
         YvxJn9Bmw4jH5FcnFKEPSd/ll4lYabbjCEzyvF8oaLZBKdSX7SWoMKvjX5KgCW1MEQgd
         xIQuncg/Ig8o6jkmUeb6kRpVL4t+4Ch7FUJRBnJXkrsKd/X9GVQyoYfbkwvoNr+ad9lf
         ZXxSNy8juve5H3z1Xu/PB9RhY4l5Lh9M5vCtBO/MB5QPabmVY5wNdYac0AhDQQH1mZmI
         e7vn/cohthBpwj0pGf5+LtgLcNk6NMVEA97YT3FOd29yJggVUiQy+bc5M/vcBWJMrCTk
         Zkqg==
X-Gm-Message-State: AOAM532cEPZp3i4wwKc/5fmvkCNApeCuN/4O8qdrX07TU5YnfLZr3Y3w
        JXIBkm/KHxCRdpVaL1X91WF5Zk1dEUylWQ==
X-Google-Smtp-Source: ABdhPJxa4Hmt2WaJgeXyoFhSvKb1g9/ONQrAiiHxhyZmzIB4ADGR3PhmNoQgeBm/yRRmNFfeHWNAFA==
X-Received: by 2002:a05:6102:1091:: with SMTP id s17mr14069594vsr.31.1605060528618;
        Tue, 10 Nov 2020 18:08:48 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id w184sm60087vsw.3.2020.11.10.18.08.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 18:08:47 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id l22so310427vsa.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 18:08:47 -0800 (PST)
X-Received: by 2002:a67:f142:: with SMTP id t2mr13882174vsm.34.1605060526929;
 Tue, 10 Nov 2020 18:08:46 -0800 (PST)
MIME-Version: 1.0
References: <1604687907-25712-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1604687907-25712-1-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Nov 2020 18:08:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ws=s_XU8Fk0mtVmjbFDOrmYrDPk7pbLpWfBAw=bzRmsA@mail.gmail.com>
Message-ID: <CAD=FV=Ws=s_XU8Fk0mtVmjbFDOrmYrDPk7pbLpWfBAw=bzRmsA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: sc7180: Add camera clock controller node
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 6, 2020 at 10:39 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> Add the camera clock controller node supported on SC7180.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

This matches the bindings, which has landed in the clock tree.  It's
also sorted properly.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
