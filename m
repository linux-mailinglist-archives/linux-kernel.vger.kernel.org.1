Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360DE267968
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgILKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 06:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgILKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:15:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1882C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:15:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so14503926ljk.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AjpiL8urXAnTFAVO+8GiICWg+iw3QUy3tHni9BkRczo=;
        b=MBHfoAjUqf4woWSnRdAcuxjYv33XADoFtAFkOO3qJ5xVIxmnb1T3Pyg253yCD+NpgP
         mEk2h9Lb2095Wv7HJaicIPbAzNAItE6vaH1XnyvUjjlHBnX7xe0C6FhpExhRZx1+P/nx
         PSjPMLBjorq8ZDEWXmTLzu0ris0OkzZZDeai+bSpvExDrdUPRQ4uEX6CkiwYztB6snOu
         sN1HXRow6j8jDCUIR7b3cuc7jAbpQwibVodevBe12WvrVX4YLRYGUrF7yzsy79DK9j05
         fBgxc+eZmC8OBx7jkPGXWJ7Owibo8+mq4e4+CA5WG7CWMEw8L3Bl2KPOSensBREmew5Y
         eCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjpiL8urXAnTFAVO+8GiICWg+iw3QUy3tHni9BkRczo=;
        b=D/UBcIbv6jVW03lxUprgsndqhDt/8UAzlMRKSxtqoQZ512qdyTtkyuWj71/x+/gZNs
         6FnupHCmLq8QPYGorXI6GNvjMtGt4XRhyXxLZhQ+YrbOhbpGqK/v4EDugAQWTCe5o0DY
         s3jOfAAbBvQbFROqP8Td84V/eoCMq36PeBkqrWqpcN10CBW8A13FY7cpV2Q8+zMBOrrq
         F640lHIhS8xEu0KoevrY/Z9HG3K6tLugjnxifiU4qrsNbb1EEkLWAb7+zYpb7EMY+DpI
         xtIXeLZ7kq40wZIo2o/Zvdf42n7uTDZ8a1QnDqMlKMPX1cxYtYfr3Zru6TZVR05198X9
         hX4A==
X-Gm-Message-State: AOAM533JVTldehM1+j51cWdXPUkn2g4MkiZSpRbnQ7mPugLG7m76zOvC
        8fHZcv3wZiup8dORwikGu5UwA5Fjx1ZPzALTVb8o8gTFI24=
X-Google-Smtp-Source: ABdhPJwssAD5MX8soX/Gyh8wLeblUTI/YESMVu+/NN0tgiA4ZMs+m5cRPX3MEADA9aOXlOa2ltm+n+lSiAnt6ahfLuk=
X-Received: by 2002:a2e:810e:: with SMTP id d14mr2388725ljg.100.1599905755340;
 Sat, 12 Sep 2020 03:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200830224311.36994-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200830224311.36994-1-rikard.falkeborn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 12:15:44 +0200
Message-ID: <CACRpkdbwVLNbabGjwdcKvcKrTWup1PQhoHPivQE2S3ZiPfNV2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl/actions: Constify static variables
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:43 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:

> Constify a couple of static variables which are not modified to allow
> the compiler to put them in read-only memory. Patch 1/3 is probably
> the most important one since those structs contain function pointer.
> The patches are independent, and can be applied in any order.
> Compile-tested only.
>
> Rikard Falkeborn (3):
>   pinctrl: actions: pinctrl-owl: Constify owl_pinctrl_ops and
>     owl_pinmux_ops
>   pinctrl: actions: pinctrl-s700: Constify s700_padinfo[]
>   pinctrl: actions: pinctrl-s900: Constify s900_padinfo[]

Patch series applied,
thanks!

Yours,
Linus Walleij
