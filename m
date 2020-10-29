Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30829EDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgJ2ODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgJ2ODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:03:10 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0750EC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:03:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v6so3387631lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92Wvsa8QeN5oXBJQBgSBXtwtg0x+2FMYvo64EHUo00g=;
        b=myoxkGc4nH0UwcnEdAdThIJXXyu5AYXIxCiqvNsG3zJefwbWiIjt7BDjTDjgOqCeMV
         vpV8/pRUqT1IU/z1tIR09QZxo1L90FUoZoKIlMB9V2m1e75EuDGU/1d5MHyHGTsXriis
         qel5M4rKVY8HFype+DFBb6fn9CAEXrzjVutpK9TwgY8DB8XSyyyCimubSpIgO9oV7fYv
         0/xt7A+J97tgHfCFRNuWs9HR6nDhaoL3O4+XOi3ThfN8ECf5gPax5o0i6/CHdw2ZDhmu
         8rX7376FCicQ58AA2Buq7mrFkkhZ/7/aAs/27/ZFb556RYVR55pZdIeu0okYmfLrwD21
         VRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92Wvsa8QeN5oXBJQBgSBXtwtg0x+2FMYvo64EHUo00g=;
        b=ooxHRWa0yrodc+r5nONUMZdXxhZVkRUp1hSPakuFFT1wygxYmQpZu+7zrzQ6jY+jv7
         DVKcy078fF78Zq8ccA9oY8CBVXsijytxs8ehOjJpGloMBAD6ilwuRoSx2wPtw0djlHLg
         nVeVm3ljKKdedj2o0FBKKvc3Es/TUNo76NALbXgSP2ml9pqR3smw9mtnuoW4RmsX2Rqs
         hNpQXBmlzZKH1z+lSc1OtdDErQbahJviaVGUHHxEBJZS77OBF5tav1lYqP2cJtH46853
         FByRtG2yxHA3vYLI7rldBpBdjyC38eU9980vZX0rvFmi9QZp/stvb9ljRrnoKq2M+Fwd
         LXXQ==
X-Gm-Message-State: AOAM530cEklpuz9cuup43jEWqWF3+oLRTvJKHHzKYCtF89Ta+TgIKf/D
        OaN7QxT1FAGYzSb8Z5Fd5NV2QKPOTcz2QCzTXIhRsA==
X-Google-Smtp-Source: ABdhPJw5f+pbm+OCagVx13Hp7rRSTnDM2rKzYJ0oz1US7r1kPYSzVzcaUKCONaqZZFCt0KqI/bJrCI92slLADNyb38I=
X-Received: by 2002:a19:191:: with SMTP id 139mr1536310lfb.502.1603980186701;
 Thu, 29 Oct 2020 07:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <1602831532-24818-1-git-send-email-rnayak@codeaurora.org> <1602831532-24818-2-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1602831532-24818-2-git-send-email-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Oct 2020 15:02:55 +0100
Message-ID: <CACRpkdarjBLJFtM7-Cq=G40Bo9dEEgxuny=QDh5y0LogD3CQqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add sc7280 pinctrl driver
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 8:59 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for SC7280 SoC
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

This came in during the merge window I think, waiting for
Bjorn to have a look at it.

Yours,
Linus Walleij
