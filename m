Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716B62CEACA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgLDJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgLDJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:23:17 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4870C061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:22:36 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v14so6747604lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYq/XPgqbbO9duJ3GxFpTKpjpGAVkbV/EIB/2AHjb7Y=;
        b=vq5Mq9sfpre5y5h9hLNtxqvlbvpaXnb402SFVrdq9f7j2PrZ6vfQaRsyGwhpXqYpMB
         1vW3Wekon4dr3fCvc1K1vRggZDp4kLDaiPAvIokbxJCxRdqa7MTiT7u3Fh7NGqHi2cnx
         5/x8hWyl3QcvIeVxdxIZHaCKvqBrrMBJ3l85qrrJJrzqwU56Y7XXaE8/wl1vwFY+Y3La
         Xmqs8GJA10ODXtpHaXa/wijZ51slevr7CmfbwHO5FzLkWZtyjs7KoFAZmabp8ca75Jlf
         4fkfU85ihyujb3Zw8S4BVJahGoo5FPYPfJkVaxytSkHdL+cMsIPMq1zLoA0ViA21+fMg
         qs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYq/XPgqbbO9duJ3GxFpTKpjpGAVkbV/EIB/2AHjb7Y=;
        b=j1ftpIIxXfV5kC1w9URkWzZu8lmnhCNMDUeKXCMaIHQm3O1mFvfZ5rEdONiBzgacX8
         VrIBKcaLTdnRXkoKR9rSDLTjkXECtzkeCz8ASNljcB9t/LGuFMCgoW6vbART3OemJnid
         R39X+pXJZ1dNSph2asN8CQ/0ckEJGvdcDzCqTXm+Blsc4R/DWhSRFl7iMGQUih0tLgkn
         w05+kXSrNbmofwaQ3W73N9I1r/VDbjB/atIcjt35dquCl/j/dsI9obPmiInWXZoDkBzt
         fQm7jNTv8YCa0NLaS7Fl7arMxiiAuhA8HFhnX/zzK0GjqO88Wa/G2Rp/Xcif/3H66iI8
         Ab7w==
X-Gm-Message-State: AOAM530bJbA+sr4X0w5d0Xuv+Jg7nE5wZbhRGSbcuuyrVKWz3g8nVtq0
        yv8CJj8KFGG/cPYX87rl3lE3kfa0SRvldzAZBKCIlw==
X-Google-Smtp-Source: ABdhPJxAg1KlfSomf5ob2QBWoRTp7CIdi8ZC2KZNWiRy1dS+dOEA+tdlmVyUv6o663ydHPY/ql/NeaP6IzPrec2CwRI=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr2821150lfh.260.1607073755191;
 Fri, 04 Dec 2020 01:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20201126092151.1082697-1-vkoul@kernel.org> <20201126092151.1082697-2-vkoul@kernel.org>
In-Reply-To: <20201126092151.1082697-2-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 10:22:24 +0100
Message-ID: <CACRpkda8w6s5D_OF3zh-OJ6rcnRLUMrHzhOZ6nxwxnLuJYH9Xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom-pmic-gpio: Add support for pmx55
To:     Vinod Koul <vkoul@kernel.org>
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

On Thu, Nov 26, 2020 at 10:22 AM Vinod Koul <vkoul@kernel.org> wrote:

> PM55 pmic support gpio controller so add compatible and comment for gpio
> holes
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Patch applied!

Yours,
Linus Walleij
