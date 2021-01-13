Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079982F4A28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbhAML3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbhAML3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:29:03 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7844CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:28:23 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id p128so419732vkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBYo6W/p5JZvDAn/qFQUoh+980h8QORlUqiOC9iDQIw=;
        b=F97GImsPv7LovRmqDSB0+LmGy8/qg5nuYKbrVVbTOmKjLBVlJGr3xHiQSy9dZwiiZx
         8z1ClPYmkK1R4FwWocCAqAAhSENQi1nIc26a+wYqXyHEqpXaRCvCRO2RlW54PJD2oJS8
         ECv1DAX9E+eseL8/HfGTI1fAksoGC6WF/8HmdefH3Ebkc/+GWiHmiPT8SRnUE82F8r5O
         ybP9j1AzOPFVUxYeXcnhFlxOXe3hNtQMNKA00ljGsHKM+C7b5/l/6pGNcUxc9QdJgXlE
         GBMsawzmK/eNTp9K0KNcvBZk9YC6kK3GKWPG+v/uhTjckwsLEdc/FudCd1V23omgWwQl
         kXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBYo6W/p5JZvDAn/qFQUoh+980h8QORlUqiOC9iDQIw=;
        b=GNrfCaOirDqIV1gZdnlrQZSMO4VYj1YSyVuBF4FZS4gjrE04d8nJX0eVcgzI0+KcCZ
         uZvNQ87XRT8fJ2ijXOn0w7w6xDC8/CMh0B0ApFjX2OTR8ZAdYdBPi8+y7zb6yydNwHJe
         OIFv0PoFcuujuoj4yd9jcRKR2HZq8VMGOBGaslm11fqUVeyxMiJ7NCIboD/qCkwSZCT5
         cQIgqU6f7Nf+KTjTFx5fNdGWYtAgHua8QfC0cMKET+VZzFjW7moildD7irT8tLYM/Xin
         P+uBwNkoSiMsDoY21ry7WYvPU8Kcf0Df+6jgftk7O0VViAGZIoEy5NRzbP+YJlgRyShn
         UjGA==
X-Gm-Message-State: AOAM532LLVMdGVfd4aBuCHRMJxCSbIyxreVnxQpeQ85TdEukdcTld7Uv
        FMI2L2VnVkWqWxd/47SQEHsoERmNE+GYGijYiPZCJg==
X-Google-Smtp-Source: ABdhPJybCIKTJASUutX1qGCq7mRxFP1jaeKd4zmFJeMiCkz2FmVuxo081IaEVXn0JDNL1EvE8aRX8tzZuazzfVsTeZI=
X-Received: by 2002:a1f:4582:: with SMTP id s124mr1483220vka.7.1610537302692;
 Wed, 13 Jan 2021 03:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20210107055457.14948-1-a-govindraju@ti.com> <CAPDyKFp89zPwr-SS9wgR6C5RM+KhSLWbkXivxAttRqTxtiVGDQ@mail.gmail.com>
 <9ad5f3a3-2175-8f43-2481-7bef17828ce2@ti.com>
In-Reply-To: <9ad5f3a3-2175-8f43-2481-7bef17828ce2@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:27:45 +0100
Message-ID: <CAPDyKFpTSME=NTZdDUq3+tLpKNdzoBKFZ-B_WDyWzLqNOsx0EQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for
 AM64 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 at 12:20, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Hi Uffe,
>
> On 13/01/21 4:26 pm, Ulf Hansson wrote:
> > On Thu, 7 Jan 2021 at 06:55, Aswath Govindraju <a-govindraju@ti.com> wrote:
> >>
> >> Add compatible string for AM64 SoC in device tree binding of AM654 SDHCI
> >> module as the same IP is used.
> >>
> >> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> >
> > Do you have a corresponding patch for the driver as well? I would like
> > to apply them together.
> >
>
> Yes, I do. Here is the link to the patch,
> https://lore.kernel.org/patchwork/patch/1364589/

Great. Can you please re-submit them together to the linux-mmc list,
then I can pick them up.

[...]

Kind regards
Uffe
