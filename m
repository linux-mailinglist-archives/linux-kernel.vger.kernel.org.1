Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9530430C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392794AbhAZPwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbhAZPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:52:15 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857C7C061D7F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:51:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id my11so1464319pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzZyFBzr4f1W011B4gds9g7r9/jftdBns1YRMkXB7G4=;
        b=HOFUATxySjWJF9wDr1dtWEkN+/idvEzn47Zjt9MKZL3qGL1P87LT1q+9u5NM9j7v8k
         obQGW/r4Ddie+9jlcmPuPh9sr+WLnmaHVVwTQCN+5uujt0uwUqUAnkAbW6NLqyp4E8kZ
         N9iYoV0lni2uaomeyhRyfzBxhn/embFLAkuTYk3ScoPKQHYre/uVftOlCqlDZCiwPrAx
         plP9flXyFRkfl07jr/ergkUlOc/odRWH6f3xD2rJuelLWuQaUYnJeyTGEuT8cXc3m7Y+
         mEJuvJzOSPlzZxc2yNKjgCO6FwWi1t3I1BmgOS+mP+WmpcPjZcmEiJAjIfvrixhXKYCh
         YWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzZyFBzr4f1W011B4gds9g7r9/jftdBns1YRMkXB7G4=;
        b=lAd8FgUKHatI/k906q3sv7jorBFPkbQ75Gd+WSohuuGVDgTE5dYJ4Us77I1CggAlLi
         37yy076FjKpDVh6TvWqY5UWwIS97zN/V3Ov6l+jspSyRJae5jWBfvkvZWGaqzdZhti8t
         gxSQ2XdZ16X7vVK1c0BjixMC7wbBNmSsLNPh1wCP2zHhX/3ndIWB1Gr9lDcQkELj9uNr
         xdg6VjIchmyn/RVwD2hKtBb3COnwAKUucReh6qYXdX2DQiCYYrfoj2m5BS9GM2bgBnF1
         2sOgBEWG6R9IsQUx/AEGw5KRDVdq5FB3o6YGYXfZX8zClIgQxzwCdIezV6p25jHnLz2O
         rTMg==
X-Gm-Message-State: AOAM530wajMUbHvNJmZKRhBih3kbTK6Rw7psATCeIAUffTP6yCDkC1MW
        Ph50P6GAc8EsJ8Mz33BPMXiORiuXQg4iQUFjr1KlbQ==
X-Google-Smtp-Source: ABdhPJxT6M1sJ1hYz7Ajt4zTCMc/Fq44WCfGtLRnoQTq/rcNFbTPShvjS86lvm79AzCU2Th24aK0wvSkVq+CXn3YDyY=
X-Received: by 2002:a17:90a:9414:: with SMTP id r20mr413274pjo.222.1611676295029;
 Tue, 26 Jan 2021 07:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20210120134357.1522254-1-robert.foss@linaro.org>
 <20210120134357.1522254-15-robert.foss@linaro.org> <20210122163427.GA922435@robh.at.kernel.org>
In-Reply-To: <20210122163427.GA922435@robh.at.kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 26 Jan 2021 16:51:24 +0100
Message-ID: <CAG3jFysf5D1T7zkEJCR2KXEm+r6AHRiNp-HMk=+CtFyExDyaVQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/22] dt-bindings: media: camss: Add qcom,sdm660-camss binding
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        Vinod Koul <vkoul@kernel.org>, Anson.Huang@nxp.com,
        michael@walle.cc, agx@sigxcpu.org, max.oss.09@gmail.com,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob!

On Fri, 22 Jan 2021 at 17:34, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 20, 2021 at 02:43:50PM +0100, Robert Foss wrote:
> > Add bindings for qcom,sdm660-camss in order to support the camera
> > subsystem on SDM630/660 and SDA variants.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >
> > Changes since v1:
> >  - Laurent: Reworked driver to use dtschema
>
> Same comments on this one.

I applied the same feedback to msm8916, msm8996, sdm660 & sdm845
bindings in this series.
Thanks!
