Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D05A2929DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgJSO6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgJSO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:58:21 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC915C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:58:20 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id f8so67474vsl.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXJc1lZhZIvXLyjj/AsZOoOAw4bh6yqivRvcz8+A/WQ=;
        b=Qr3sJTnt+f2P7nYRuso8/yLqIv2Za2b7XL6njSRbfuCMrcIQhgBuERIsu9IPxRQXWf
         zJ2xESOoqgk1xoVfp9i9Wf3NTtLy5s76hO2KwkzeKUauLwgTswhFQU/H0vwCYl8u10Hm
         Or/vhOIqKLH14d6G9D0ILiVULu0Lntjndshn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXJc1lZhZIvXLyjj/AsZOoOAw4bh6yqivRvcz8+A/WQ=;
        b=I42/ELhuzPHZdYYxhCI9dspTRtPE/e6EZ5WD3rYRn1f4s+q+AHgM5kfuvB8opKYdt6
         O1RJpvQfQZ3dVZ16p7nVvnDqVIQpn3X7+Zit+T9tlIpLq5SoXayMmWPXK4OidD/xnY6y
         cPoWkvZt75d1+QDgKO6ZUuVHWmgYXW3eX1+vYRRgIYPlzNTRRgqfpy97w11DJijDLX4F
         ojx4DzE2E+XAcXNNDZKG14Hs2Bjl6pbLwqDIzYGeSlT7i5Zu9Qx/dhVyhrAQlEvdMGKU
         N+lfFInDcEzMCQD04+NHzfwST49fXr9+qwPd68EZ8HA7cjagLDtusW95Sh3DmlSIJUk5
         EF1w==
X-Gm-Message-State: AOAM533Xivcys/r6/8slRXv/DZMBEIPcR05SqIKyZBE9+bmQ/e2N/PmE
        SCMZIITM4iiJMVysCfCMiKgVO5ISDuBv0g==
X-Google-Smtp-Source: ABdhPJy4LWhk+cn/DRsTVQ97AH025QlNpBFNOU0Jcd7Aan+XCLwg292v+dddshAv+mbqzCRhPz87yw==
X-Received: by 2002:a67:e30c:: with SMTP id j12mr328905vsf.1.1603119499808;
        Mon, 19 Oct 2020 07:58:19 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id j15sm4980vke.49.2020.10.19.07.58.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 07:58:19 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id l6so52426vsr.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:58:18 -0700 (PDT)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr331585vsp.34.1603119498344;
 Mon, 19 Oct 2020 07:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201017020137.1251319-1-sboyd@kernel.org>
In-Reply-To: <20201017020137.1251319-1-sboyd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 19 Oct 2020 07:58:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYFTu-J5L6usJNWtjH-FWe+o8JYWNxVYBdg5-coWaQag@mail.gmail.com>
Message-ID: <CAD=FV=WYFTu-J5L6usJNWtjH-FWe+o8JYWNxVYBdg5-coWaQag@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gdsc: Keep RETAIN_FF bit set if gdsc is
 already on
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 16, 2020 at 7:01 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> If the GDSC is enabled out of boot but doesn't have the retain ff bit
> set we will get confusing results where the registers that are powered
> by the GDSC lose their contents on the first power off of the GDSC but
> thereafter they retain their contents. This is because gdsc_init() fails
> to make sure the RETAIN_FF bit is set when it probes the GDSC the first
> time and thus powering off the GDSC causes the register contents to be
> reset. We do set the RETAIN_FF bit the next time we power on the GDSC,
> see gdsc_enable(), so that subsequent GDSC power off's don't lose
> register contents state.
>
> Forcibly set the bit at device probe time so that the kernel's assumed
> view of the GDSC is consistent with the state of the hardware. This
> fixes a problem where the audio PLL doesn't work on sc7180 when the
> bootloader leaves the lpass_core_hm GDSC enabled at boot (e.g. to make a
> noise) but critically doesn't set the RETAIN_FF bit.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Fixes: 173722995cdb ("clk: qcom: gdsc: Add support to enable retention of GSDCR")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/qcom/gdsc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
