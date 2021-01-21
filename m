Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A72FF6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbhAUVRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbhAUVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:15:49 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B11C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:15:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u25so4601309lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 13:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPXB/QvYHeHyDz12IYDpQ3kxdX/RQPSljq83YM1Cbsc=;
        b=wo7ePqnG4Mm+bFPILZUluUgv231HKhHEiahePqoHv3xnAid9a5Z86blUh3bEeEylKv
         gvSsMGkXjczuVNSDNujTGMiPZBEPj9lbYrlWgWsCD/mYbsu2UsaQfMk1tthRok8lmnE2
         9d/LB/nDix4e1CycxhLnPnAcNXGPjQV3Zq7GPBTyYyTEro303Hc7ZnRSvkeupCrjE2YA
         jKdzXbQRpCvwHSaaF466rZw5U98kgwT7fxwyuOYEaouHYtILW/CqPybq6bRDfhvqaJT8
         gtr+RjZkvt3v6JZPMBpPbU+bzBnqK1ISqf185HR/oSpJHHrWGUfaB1s13Cw+smCKP0Uo
         TojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPXB/QvYHeHyDz12IYDpQ3kxdX/RQPSljq83YM1Cbsc=;
        b=Hc9SYNxBv7/LRukdOiOr3eidrW7aVldscs90eYDGQ0FYJBoZ1DzHo++5IDEraRiKqE
         bIVAIbFcR1Aje+48VWv02DAqxCaOatjJc8QDcQpzJaFimo48KsjdScQpq3/MLItu0AzG
         RfErWam7T9uMVarc3cxQfswkGK3HVoaXikZy8ExzC51BqxNA/h60+Y2LQWaUYYu1rsV7
         5NlnNfJuJoevRJz/CgXSVk2FrX5Z9wvlPztj15U5H/+wabk9SNsJwfqPzcZ3c2Addt17
         SHHkLgLob3Sdf2Qq4huypp68j6GrSfZ2P7D9Dzf91SNKbbsxUi828Rp24WUk+Dybhb6n
         4R2w==
X-Gm-Message-State: AOAM530BGJdHeoHXJ2f3N8G5lmGdLLJhQiMVuZwOq1tEsj3hNKaZEXgK
        Bs0cBOWU8aMjm8nOyVY7F05I0uZcSPZHXXgDP+a3UA==
X-Google-Smtp-Source: ABdhPJzto7cVc2tViSt4RVRSrr3/F7h20c99bb+Y6MaUO5KU4srR4Hy+E2Gqsm4PgTH97JOqrGczVwlmOK+aXQSq0Ag=
X-Received: by 2002:ac2:5c45:: with SMTP id s5mr562511lfp.586.1611263706367;
 Thu, 21 Jan 2021 13:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20210118020848.11721-1-andre.przywara@arm.com> <20210118020848.11721-5-andre.przywara@arm.com>
In-Reply-To: <20210118020848.11721-5-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 22:14:55 +0100
Message-ID: <CACRpkdbeVJkEuLx7gC-FANevOq2QTr7GaQVMF5So=kg346ty9Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/21] pinctrl: sunxi: Add support for the Allwinner
 H616 pin controller
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 3:09 AM Andre Przywara <andre.przywara@arm.com> wrote:

> Port A is used for an internal connection to some analogue circuitry
> which looks like an AC200 IP (as in the H6), though this is not
> mentioned in the manual.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Patch applied to the pinctrl tree.

Yours,
Linus Walleij
