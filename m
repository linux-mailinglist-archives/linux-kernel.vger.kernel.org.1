Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333612AD92C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgKJOrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbgKJOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:47:21 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052DC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:47:21 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a25so9044233lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiWbHwM/Lr8KmmLC2XpYaczHAMgXswVwBOFL89IZblY=;
        b=XZOD1vKezmecxMgGB2KrnL99f6D1FfXpEp38edLi+v6XX+/2DwlTq8GQNRMPlUGcas
         WTmTOsZdFoW/F53Xc4MjByycnOx3skWg7Lw0au4+WC+y+fbxiT1FbuIA2K3TF1ZkM6hX
         sfaq/f+id1NXynG39rkmv2VNdGaoFkt6cx7J2wfOatok+ZvBVD2Ytc3SsqTyLkNOvHBk
         i0no7VAoh9Ty6snnjOyibxmv6PpiNg40TvV5mMylXUrkJUsOY9LRTDcyHLJqT04KgZqN
         Kny7Cje9XUnNHbZ+6YjaD7VdtuKilcGIYHrsqOnNwLspmNYbT1W4Ns+IzTmDKpThPqlR
         YhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiWbHwM/Lr8KmmLC2XpYaczHAMgXswVwBOFL89IZblY=;
        b=VoILSn8TGSXzqD6ddjO6TJ2P71nLKjQFcgqWngl3GxyXSGhVT0Gw1RjcjzcTwCj+Aw
         rPcZYE8Fr+3nk1BhNe2b1VFUfmYgOUhpR44b1CY8oDKVCxbE4VT27YzeU378L4eVLfyF
         ecF+wuOJUFeycFCnClwD/WhiCcAmF3h5nJAQs+vd9xrWgZGGAZ2l73sX2IK7VOge6GmU
         0Zy4NBxN/sIQuf5G/g/eui1s7TbnQWq6r4rU+QtJOxGwcZFaczVXIyuCwLuiXluwkKRS
         Pb89ox2n6vHSpFYWHSOFdRf6/ksvCw62IOFRkx9c05hDUYZ0LsAHU6hZNThRXlL+wJdG
         FPog==
X-Gm-Message-State: AOAM532U25d0pNREnpQLkNitKkxsHof+qrnStiQcYdEUvWV6hPWhGMvm
        4JSndaukQKnv40MTPgSWXXqxkUk//LBNuOdbc3r2nw==
X-Google-Smtp-Source: ABdhPJyi74cMCtvgB2LhCZiGshSdj4vtK9CzMPI7ALGe90BKtPZD+3vJoENQBsDaxfuy/JxgoF7vPVs3eoY3U4dEbmw=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr7305358lfm.333.1605019639735;
 Tue, 10 Nov 2020 06:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20201109062620.14566-1-vkoul@kernel.org>
In-Reply-To: <20201109062620.14566-1-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 15:47:08 +0100
Message-ID: <CACRpkdY=g4omnvgTzsBP6qwg7s8VYaFwChgAsJciQFS7SJ67jQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pinctrl: qcom: Add binding and driver for SDX55 pincontrol
To:     Vinod Koul <vkoul@kernel.org>, John Stultz <john.stultz@linaro.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 7:26 AM Vinod Koul <vkoul@kernel.org> wrote:

> This series add device tree binding documentation and driver for SDX55 SOC
> pincontroller.
>
> Changes in v3:
>  - Add ack by Bjorn
>  - Fix dt_binding_check errors
>  - Add gpio ranges in binding

Excellent, patches applied for v5.11.

I also just applied John Stultz patches for modularizing the Qualcomm
drivers so there might be some need to patch up so this driver can
also modularize, check the result!

Yours,
Linus Walleij
