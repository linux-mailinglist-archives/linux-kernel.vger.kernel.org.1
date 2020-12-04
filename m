Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D067D2CE934
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgLDIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgLDIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:07:53 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC5C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:07:12 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so5601424ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yX8j4Zc6r/G3qEMx5P335vQOgY7XxWfI8gCDr2DAO3c=;
        b=jOjb14vbi/ICQVDR+N5WlNELy+GMtxUHXHl63d4T9jWbwhs3ydZftkYWMXcjYh3iIv
         zz4dCH5cwlou55Gp0mpTqSj4rgZltncqEtjV9SbkkoYe9/N4fq32oxhTVLlAGd8BKdUs
         UR0V9LbEWqw0w7Zwu4HeOo6vzCTR3nlAWSwlHIx1lbW0MjINrHxYxBN7XXHf2js3MN91
         u9mtvJZ+cTt+D0gE+eb+pQmN92QJ1cQ4rokNzZ70P5MYhz3Ff+UvRBE1e+LATNFo8aFR
         lykS5c7Kgbkmq0snVKFdMB3Kg8/Yw943yTJgYek7MzzSMFuJRE3NJlizh8Lqzn5kDp3k
         z0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yX8j4Zc6r/G3qEMx5P335vQOgY7XxWfI8gCDr2DAO3c=;
        b=DiLqhS8CWuLn2OY2ofgh7S5lvAKOH6virn2MemhZcPGg0w0eRHDiDJfHRmVoXSnk0z
         vNA0qleWoUYjq+DxNLDv7LUepAgNd7G2Rur6TSSwJnhOibdISODGS+kmHsyr66BFvqIO
         h1nnAxgSaDJzZgDglw2M9rSkKiFbMCrHkY4rGGHGsYiSkGo+W2PZKUR9de5TNHF+n2BY
         D9Iyq/3/DRDLzrIJwYXwQKtFrEStfwLCpbUclS8O4wwh+IMTQ46QZOZJ+uHCOezH2SIT
         ps/V/k5H0BR8kYrMdSWeoG58mX8pbiY5z7LiXW+6yUrEC+VmXRWOOR7Tjy5S998LRE0v
         lulQ==
X-Gm-Message-State: AOAM530m/An5r+Ltoi7PNLMxB0YduTYHNBJXJauVzobuAA+RGWKkJRNE
        Cpp6Qa1dkn+bZvhr1s+0TZOmkfhAJlJNKnA+9Q8sCQ==
X-Google-Smtp-Source: ABdhPJyujIvA+3fbQ3u8na7bGvEvTitc/TtlhppiehVaP7Ddj81M94noixPJVvbspU0gwxZBNHJR1TblG5npcdIqJqw=
X-Received: by 2002:a2e:321a:: with SMTP id y26mr2839981ljy.293.1607069231260;
 Fri, 04 Dec 2020 00:07:11 -0800 (PST)
MIME-Version: 1.0
References: <24505deb08d050eb4ce38f186f4037d7541ea217.1605722628.git.cristian.ciocaltea@gmail.com>
In-Reply-To: <24505deb08d050eb4ce38f186f4037d7541ea217.1605722628.git.cristian.ciocaltea@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 09:07:00 +0100
Message-ID: <CACRpkdY-7bCC5-yGQB+vhLX7ZRB4irH_3u7KcfKmN0QiiXpHwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: actions: pinctrl-s500: Constify s500_padinfo[]
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 7:10 PM Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:

> s500_padinfo[] is never modified and should be made 'const' to allow
> the compiler to optimize code generation, i.e. put it in the text
> section instead of the data section.
>
> Before:
>    text    data     bss     dec     hex filename
>   12503    5088       0   17591    44b7 drivers/pinctrl/actions/pinctrl-s500.o
>
> After:
>    text    data     bss     dec     hex filename
>   14435    3156       0   17591    44b7 drivers/pinctrl/actions/pinctrl-s500.o
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Patch applied.

Yours,
Linus Walleij
