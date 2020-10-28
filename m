Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8B29DA06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgJ1XKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgJ1XJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:09:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF2FC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:09:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y16so1093714ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hatfo1xwFEDynogYQDEhCt1lpMjNGoJQpQEAAPUn4fY=;
        b=o7y3xKxud6jpWJiD7Y/D54i7FmuhCdJjwT+WBVsmaMPt3nLT6r/eT2RK7+eSFFJh+N
         C/QVs+MZ4Lm7rwEX2dqJ0I3QCAT+OdhVTJmk2WhagbTrBfLj3o895BBWKbRm1hIYCEMM
         6/lB/QNEWcsELphJiVQmi94u/Boca3tez7YBz6e3p5yZjHRCFWwAGovezFOFSGFbS7kh
         exEW3HvfxSOBS3fQp94B1TXeSks+8Zd21nrupBBq3K77pKSG5UOGVltHfNGOQVgDurTz
         8e6vs6QD0PHSN243mURr9pUb6EWOPRR/E/U35y7EpmhJIQtMpHOxDXd/9HLLUOPrI7KR
         pjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hatfo1xwFEDynogYQDEhCt1lpMjNGoJQpQEAAPUn4fY=;
        b=p9RDIVYIqG974uYjDMrRtNxh/ooNlLdgNAyfpGpg79+w2qcR3xYSAX7AZZGHOX6qTW
         o9fGC76hjPCqE1zOIGVQUPlg+W6bsbxBJo1qdinFldjd+TaVg1WE3eMaKJmtz+gui14W
         6O1t98Rq5FTnb/SZhRf/Z7MzW2HtJRDe8SPCMz4reR+yFetUiVjeWwsqFVV0oGtGaf9w
         TZnCqvSsN3tBRF+8b4/eerfCCx4dnhUD+RrDcDfAuoJW2cetElaUnCrn1bChtSFj6T1M
         UfLRElvcNnKg2pdk6c5yLZgFqQJMz8lMsLvVpJYiFPEIvxz0Bdt5LkSEsOGNf9lPxlfT
         5aCQ==
X-Gm-Message-State: AOAM533nivYt2zI7/59QCeMtoP/dcrv5i3qFT+jgjp5QQgVb1FSgEsGg
        NJsJonXo+zkSusSLXX26nPv1Qa8cXva8Mc2P2gIDh1aBZ5fLFA==
X-Google-Smtp-Source: ABdhPJw+Y+AFcpZE5IrWDaF75uBlkljVPeaRqxNXP6B8aDvxXTWl++DYovIgyPQUxwMCkmQBdRS/3260GiTYigirY18=
X-Received: by 2002:a2e:86d4:: with SMTP id n20mr3755779ljj.293.1603900056645;
 Wed, 28 Oct 2020 08:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201007160611.942754-1-junak.pub@gmail.com>
In-Reply-To: <20201007160611.942754-1-junak.pub@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Oct 2020 16:47:25 +0100
Message-ID: <CACRpkdb=0iEqT0+6UnB2y09_XdQWwf5za43Sn-g7vA_dEkgSuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: qcom: add pinctrl driver for msm8953
To:     Vladimir Lypak <junak.pub@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 6:26 PM Vladimir Lypak <junak.pub@gmail.com> wrote:

> Add inititial pinctrl driver for MSM8953 platform. Compatible SoCs are:
> MSM8953, APQ8053, SDM(SDA)450, SDM(SDA)632.
> Based off CAF implementation.
>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Vladimir Lypak <junak.pub@gmail.com>
> ---
> Changes in V2:
> - sorted SDC_QDSD_PINGROUP entries in msm8953_groups array.

Bjorn can you look at this?

I was submitted right before the merge window so I guess it got
lost in the storm.

Yours,
Linus Walleij
