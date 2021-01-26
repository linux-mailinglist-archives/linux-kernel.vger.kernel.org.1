Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE0304102
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405882AbhAZOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405823AbhAZOyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:54:05 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A496C0698C0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:53:25 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m22so23075896lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FZjycms5gnBCIpvZP+ctIDCiLaUF2g3Z9pOjKVsdC0=;
        b=YC1EV9dV4gLXUfWerPjvjrjQdSJ+wwfVBcUDEIaM0flplCFVLxlAChsv3hzwWoy7iz
         Hi0S30M8VFmQ8BsE4iPn7f80s/c66XPGgfA2t01Mjh484dbNXrOpb2yVjTqtAWqQ8cRk
         mJPIODGZR5ngh8wJEIT1rYkNxEj7xy4zsGH23iGkEgzlXHb4YaNKMTbsEVlAIrHaH4hL
         p6GCSBNLjPJML3NJMc4PO7Ae3TbHCp5XPliFMWLGLT4LLDMNDN2snpJhaqoqZRs6RmuQ
         0+eMcBEjfyuknWpS8iMeqRNP3VFSQbHl0Yxb4FuYt/+hFHftJxrFFgZzJHMVB5HPhr3d
         slSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FZjycms5gnBCIpvZP+ctIDCiLaUF2g3Z9pOjKVsdC0=;
        b=JGXOvlZpTevSbpVOkzxuiJDHpWiBJURbAUzz7DDUhvOXytDqALnAiwY2a++y6O8m8S
         k6HIJkUphAMI9P17vh/d53pl3S2m6RFoIqnqWMT5nsrUX2W2H00LlZBCUciwy9nxee9C
         yGfe6lHpKiw/rjiFTp/O/nSbAZLUb/nMzs/QVkb9/AmbsX/KQi80Imh8ZRQiZzpU6B4n
         eX2TDTRQvZVewRnkSBp20BX3GyJqIhOx41LqsPOb15vB2EnvXEv9+rYRZoVIxMG2uCUA
         fsZQQVaqF9z7V+RnhjjTZj/9oXQREaQZ99WF9+BMZoJzGZJ2CQAqTR+t+U6GiuF40Vx/
         Npvg==
X-Gm-Message-State: AOAM5337ePdTXNO8t/6zntOXYsVH4XHncvv5mF7KOwe48QRF5FY+VwXD
        Dc5LvhCrFiV/5CuXqyE4BzmhdlArD8gRReQ4X3ujUw==
X-Google-Smtp-Source: ABdhPJyaXqdBSRbne+mx+lif6Cq8WwZOJakN0nseaAW1Q7KoMw1ocidpAn9dDfM8IO/W87GNbGvCW6b3/uPSuBZrfGs=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr2653252lfh.649.1611672803601;
 Tue, 26 Jan 2021 06:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20210115171115.123155-1-konrad.dybcio@somainline.org>
In-Reply-To: <20210115171115.123155-1-konrad.dybcio@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 15:53:12 +0100
Message-ID: <CACRpkdZ46OSTNited84091XzikVA9HFncmrX_iXZ62mGUJEmVQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom-pmic-gpio: Add support for pm8019
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 6:11 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:

> PM8019 provides 6 GPIOs. Add a compatible to support that.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Patch applied.

Yours,
Linus Walleij
