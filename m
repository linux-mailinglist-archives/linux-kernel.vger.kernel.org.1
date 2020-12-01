Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9962CB085
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLAWzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLAWzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:55:55 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B87C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 14:55:14 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id q13so8031465lfr.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zek3Th/B8edX275oK4UQoFClWrn9486n8mnbXM2NC2Y=;
        b=Hk5i6eiY5/+oDJs06GOmfCHlKHo8p3HBzdmov0q+9L3/P0VVaQV0BuPBqi6X9NeEFr
         QOLO8j75gBm1jmxMZ2Ey0gtGb16IFnfz864r/D56jMIqdHPjOSmFjAi0/k6CAyYo27E6
         yHS4ev7edijhpZelG254A5SnxgyLVb1+6prTRWsMIoK15Q0jqsRmLOz2zTybXz7u4Pes
         HMmiucTf56IugTvZ+8DD+znsMNDysM3HOCsJ7uMNHDNBfGs6g387VS4zQfHcHaEwMVJZ
         Dsc+Z2TXIfMo2A+JOc4SJ1npSR2K7Jpl+zZmMWefMWsiPHUO+wqzBdMAK9B6jLTLWv3j
         j+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zek3Th/B8edX275oK4UQoFClWrn9486n8mnbXM2NC2Y=;
        b=ZjEjoGfw9ObGVQwgxgRgppVAdCOfyoQ9VhoKtEkevUPbMTc8rJ0rZyGt51zbPiW+GL
         7mKcxNkxgehn9UdMkxo3X3G1hhfNlgvpEiiKTOcMSmtJbSRTMG6YxpJPw/WG7q//T1Ka
         evQxOHEJ0QjWVfvH5alDT2EpRIe7tSmoBBhDocsGIpDnbOqI1RPRTGy7ShY7RngRrIsK
         q0f052MXXqro+xCCCBgSIBJl4V2FTZTU5mv4iuPsUC6TPTcEl3QBlG6sXNtmJkRKhAnc
         I6d7wQLqbLMoihaXGpTB1RDg6TGp1/XwP2nAlBHxtFtVgj/L01u7+2MKR9rcDpIcnVsq
         FJTw==
X-Gm-Message-State: AOAM532oRq8y2x4rGXSxUI5kmSRJLu4J5GUGfftlptHKQhGwxJQSyBi8
        56b8NjSWvY+fXFLW0R4fxxHk81QTf5pe1jY15z6g0/mpgHdmOw==
X-Google-Smtp-Source: ABdhPJybfqBt2Tifwmy8kuDNWfeanwDGl7Yn1/jdNn0SkGnsbrwGrAiI9VqQuyyzvwLRXgAHPCcRgqDWctE9pp3nTJ0=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr2132447lfb.572.1606863313318;
 Tue, 01 Dec 2020 14:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20201201204652.22913-1-krzk@kernel.org>
In-Reply-To: <20201201204652.22913-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Dec 2020 23:55:02 +0100
Message-ID: <CACRpkdY9YqW11sKqcJcF0kCon1tGgXNgASXTdiiZKnU+cjivsQ@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: Pull for v5.11
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 9:46 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:
>
>   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-5.11
>
> for you to fetch changes up to c5564a50d99019f3c713fa306d5feecc3e909b10:
>
>   pinctrl: samsung: s3c24xx: remove unneeded break (2020-10-26 20:23:29 +0100)

Pulled in for v5.11!

Thanks!
Linus Walleij
