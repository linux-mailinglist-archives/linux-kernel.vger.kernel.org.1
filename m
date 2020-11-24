Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD22C2F67
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404075AbgKXR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404004AbgKXR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:56:14 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336DEC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:56:13 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id a186so688649vkh.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dstdkNf1brKdffRW0gFmbGJRx2DF5qxz6SUvxED47w8=;
        b=TGh7RNH83GE0U0nAPatnZIFjE4u3CMt0Qxiu9Wqb0GPS/OPZJNtTkAnC0zifkdi1is
         fxaivn+USYnBKSThYwUlDA0giTUU/2ozReLrNWUtISAP37Q1Drz7JKH12xsPmz5edpav
         /CgogcL0A4GA2sXcKGMlF3edlC1/RBIPC+Jb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dstdkNf1brKdffRW0gFmbGJRx2DF5qxz6SUvxED47w8=;
        b=oM6qiBfvAteATZjiCfRPGreKFy3w5gOPhJXd5SfEkYHy12iBXVmV7SUgufkNl9RFWu
         uuAS9rbgRawHnMYJ+bSwd8PK3ep3f5ATGDHS+MGVNUFwk2YAvgqzUMCKAVTeh+EsKxUG
         Qo6aYsEM0WFFxsK8x2F671+weGmGT+Av9l8oiFlqsO2gblRbf/XjTVHkv9LoR6riHEgm
         mw0YPsd5gfjvuPna/reAAl2N/MHwKa1sXW/Cdp8eZ+lpXPcCSD9933r2cZPiwvUQaU74
         nan79TMtiTHVtjDyWQLzqQw1jAYSiRldPsQ8Z6I2BaCI4///zdnzvZNhNJ9kzJzZ7A1q
         ff6w==
X-Gm-Message-State: AOAM530Mlds9qqVwbonMB7rgB83YTgxYt1RW19+UXpeWYHY03ArXjGhN
        kXqZb3fqDp6tccZ8p7c2zBYqAJM3JlwZmw==
X-Google-Smtp-Source: ABdhPJzAdQkVU3+oW5cLuGDSCR9/RIcQuyU0z7XMTxocTCvoos2dmWZ9rjLn2mLeZBdQ+5KCKfsKLw==
X-Received: by 2002:a1f:1289:: with SMTP id 131mr5158483vks.24.1606240572175;
        Tue, 24 Nov 2020 09:56:12 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id d2sm1740458vkg.46.2020.11.24.09.56.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 09:56:11 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id f7so11553224vsh.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:56:11 -0800 (PST)
X-Received: by 2002:a67:4242:: with SMTP id p63mr5023952vsa.34.1606240571069;
 Tue, 24 Nov 2020 09:56:11 -0800 (PST)
MIME-Version: 1.0
References: <1606198876-3515-1-git-send-email-sibis@codeaurora.org> <1606198876-3515-2-git-send-email-sibis@codeaurora.org>
In-Reply-To: <1606198876-3515-2-git-send-email-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Nov 2020 09:55:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X-3YzmhS1g8ytcNLNfrtLnMKNmeycA4oW5kJjb=X+BMw@mail.gmail.com>
Message-ID: <CAD=FV=X-3YzmhS1g8ytcNLNfrtLnMKNmeycA4oW5kJjb=X+BMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7180: Add DDR/L3 votes for the
 pro variant
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 23, 2020 at 10:21 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add DDR/L3 bandwidth votes for the pro variant of SC7180 SoC, as it support
> frequencies upto 2.5 GHz.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
