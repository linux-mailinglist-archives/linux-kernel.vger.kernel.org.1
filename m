Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CBD253F56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgH0HhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgH0HhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:37:06 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C002022BF5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598513826;
        bh=volXVo8FWRJKn6VNEcDI+eVcLxy+NtoiBEwSOpa0uzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rcoHj8O4M+WGB2HbBtUi4Mq7No2pw3FFa8MlVVLBbreL/PLx0uC8b5kHnT+1vIR0V
         dmDfrTcCeH0tIBmVbtL/tuTaL1oYQEWf7gXdZYq9/udH5Xx892SIKVUZ3f67VKrhn9
         OThj3SjWPtg1mjjvz7rgxA8wtbIM0DfxzcrmJZ+Y=
Received: by mail-ej1-f47.google.com with SMTP id d11so6262627ejt.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:37:05 -0700 (PDT)
X-Gm-Message-State: AOAM531kPfmgYSLrBLPkIJ+026IRrL+0ea3lynrlaiJoEHSh2gph6AE4
        yL5wAi4fJeL5M0s1TwIX8Jhl+b2nd/nfwuLJq5E=
X-Google-Smtp-Source: ABdhPJzgxP1osbjwfYUj1JBEmA+ZumWtne7IDni1iBpcoUIOJFP/NI7q5zpMASbPPsfsya4g8DCbWlKB+BXNLAd5T0Y=
X-Received: by 2002:a17:906:4ec3:: with SMTP id i3mr19144062ejv.215.1598513824336;
 Thu, 27 Aug 2020 00:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <1bdd59d511e4acd23aea6af51d06b1cadf09a1b2.1511065331.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <1bdd59d511e4acd23aea6af51d06b1cadf09a1b2.1511065331.git.arvind.yadav.cs@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 27 Aug 2020 09:36:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeg0_1gFZWhEvb-LwCiCvEuaZcZ2TQa256ntvuLecF_pw@mail.gmail.com>
Message-ID: <CAJKOXPeg0_1gFZWhEvb-LwCiCvEuaZcZ2TQa256ntvuLecF_pw@mail.gmail.com>
Subject: Re: [PATCH 1/3 v3] mfd: ipaq-micro: Fix platform_get_irq's error checking
To:     Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc:     lee.jones@linaro.org, maxime.ripard@free-electrons.com,
        wens@csie.org, linux@armlinux.org.uk,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2017 at 05:28, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>
> The platform_get_irq() function returns negative if an error occurs.
> zero or positive number on success. platform_get_irq() error checking
> for zero is not correct.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>               Add failure case '<= 0' instead of '< 0'. If IRQ0 is not valid.
> changes in v3 :
>               return -EINVAL insted of irq.
>
>  drivers/mfd/ipaq-micro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Arvind,

This was never applied. Can you rebase and resend the entire series?
Or maybe there was a reason to drop it?

Best Regards,
Krzysztof
