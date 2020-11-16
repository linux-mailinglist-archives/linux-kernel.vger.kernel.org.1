Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB22B467A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgKPO5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbgKPO5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:57:55 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C8CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:57:54 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id z123so9289732vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sg3eMzSsvsFQKF9WYrus0kI2hc/riBKKXYCgRDx0GaI=;
        b=cDYymRXmY7cN1YqBVrDKxLtgp3HsW+XjlleSpOJL3ZvY+i5aDFQlDVe1bvmxNoormg
         F+/Yv/XabrzCe9u7fiBvT6VQg3Ose4LHuY8wcFNuSr/SS0roJaLvBKDbwBnVfeMDVVym
         srYMs68PWUkfmH5asG++lDq8nFRWyh5eNMQ/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sg3eMzSsvsFQKF9WYrus0kI2hc/riBKKXYCgRDx0GaI=;
        b=RaiYrdtkVFltKHihmNWUgg32yN7lVhwsYCLvhGLFKtPJqtFNdt2l0ussKENIJA1Frs
         KxdrC0tzIFQXrHfR0CrGRRNkofThNadX/IPbdX2xyE0JwwD1UBPTf3oFJc8Hdg2umPKy
         e7FtgviJNha29AfEl+OHkw2zZB+ja6KT6g6KQQ9yQCi1pT4I9S8QijgiJVRd1FeZvjtZ
         6x8B9ukOWxKK+sKMUYOElFFKYkkvOZ1WdC2Pr1XvkkE8d6MQTv8YLZCbowG0Zx27jLlY
         wB2gk32/QcnT9+y5ITqECVFXvwypLHZvCQJq2SY/sbEOr6fPWAqsmDXUt5QAZq958+b4
         11cA==
X-Gm-Message-State: AOAM533zGGnXL1yz73Cd3mpGFB6lAXUsp8N82sBwV3ULNwrVKEJG23xt
        82OnPWNUHIYqqDtRA0uPl9TpjqNHs2xmBw==
X-Google-Smtp-Source: ABdhPJx9+YCe7t+y6bR/KfqAFMIgHHyfiKOy6FKnPL7MRkN6MtIVJ4WYFPWMij4U6QCf2UZa+IwWaw==
X-Received: by 2002:a67:6996:: with SMTP id e144mr7857701vsc.23.1605538673789;
        Mon, 16 Nov 2020 06:57:53 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id t188sm2195470vkg.23.2020.11.16.06.57.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 06:57:52 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id z123so9289672vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 06:57:52 -0800 (PST)
X-Received: by 2002:a67:ef98:: with SMTP id r24mr7638617vsp.37.1605538672446;
 Mon, 16 Nov 2020 06:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20201116083014.547-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20201116083014.547-1-terry_hsiao@compal.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Nov 2020 06:57:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UetS0P++02rRfkxuxAau6i6pHDyc_9iz_OwZ5h_T_Fug@mail.gmail.com>
Message-ID: <CAD=FV=UetS0P++02rRfkxuxAau6i6pHDyc_9iz_OwZ5h_T_Fug@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: add "pen-insert" label
 for trogdor
To:     Terry Hsiao <a804335@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        terry_hsiao@compal.corp-partner.google.com,
        danny_kuo@compal.corp-partner.google.com,
        jasper_lee@compal.corp-partner.google.com,
        van_chen@compal.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 16, 2020 at 12:30 AM Terry Hsiao <a804335@gmail.com> wrote:
>
> Add a label to the "pen-insert" node in sc7180-trogdor.dtsi
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
