Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8482E6B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbgL1W4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgL1Umk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:42:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CEC061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:42:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o19so26594991lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4AwaZljJajwZpxLBOrWsNrXSZnM6PPh3AF/enMC7UM=;
        b=QkUjVoQkI+gATzDLGq8Rpy0+y2Pwp2yCimxuEnMgY/X2ZuKzIEjydn1AwgjgqPi1Q9
         LvCbNqdrGEs1Tolf2u59B4Pq8seibuhCO8vV3yHRhNHmDwVYmFkGxMp2JFhVdJ5t26sw
         71br0igoPW3GTDyZLUQZ6O4G5e9Vl/CgjgGzvRd52CldxYAq0dfr/c4DsGjuQG+MS11p
         rHOkSdG/jPD6QNxfF8J5oewUOQ6lM4RKNYF/FzvM3Hhs531lzSTq9T549hA7EozEvdq1
         lGbDxZk3dnPt3LpSiGdDUradwKLVISk85wUeiWBEGCJo949NfxuqbJ/z1eoYLf/4qtmb
         /Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4AwaZljJajwZpxLBOrWsNrXSZnM6PPh3AF/enMC7UM=;
        b=IAXHXBi6GJcFhoTGpSBfpsK288lXEic07nPXh5czO0u6A9CqV0P8IiEX0Pb/jD/fA0
         bd5TD/wbMzwqlv7lFIH9Zfgm6CA4dB0EbzlrtxG7xkK1klVRdCzYTcCgrbKkO04jeW31
         PE5CkbqkZ5ebNWsJ8NyFWjaaZXAi71r3rbFhhLXaYIQf8TkeOcq0A8ExGvzsASFQqEPT
         Qya22zLgHgIlGuxlBeRG9OPMal+l5PIssa49bIudzWRi+Ms4lIHW/8gQvI5qlbBDCTeN
         MP43nOUZXa/oaHN4fnWzECAISNPbsaqpcLBoVrsrDV7CUKVYF8FPW8cKk7y1UjUGmg2I
         Zb+Q==
X-Gm-Message-State: AOAM530jTfUEnTFf8HpCmv/Y8KYO40ulSnZogr0Sv0mq1ICfOtwAvlBU
        bAkDgxGEj20gXs3/ivb5kiLo7sXlvZdst3PMuRgWqA==
X-Google-Smtp-Source: ABdhPJzMvmz9xDTj2R+mc2KmglBKtZx5MtPfLE/0wbemEcqJCIANlfPDvJJ/8pBMddTE5ARiEnAaoD03uXxvHdDNNm0=
X-Received: by 2002:ac2:5597:: with SMTP id v23mr13727087lfg.649.1609188118632;
 Mon, 28 Dec 2020 12:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20201224112203.7174-1-nikita.shubin@maquefel.me>
 <CACRpkdZ=QBGZ9G97+2xPRk4PTTSHGHL64bTLZGbz5kFsg-NqWg@mail.gmail.com> <115071609167990@mail.yandex.ru>
In-Reply-To: <115071609167990@mail.yandex.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Dec 2020 21:41:47 +0100
Message-ID: <CACRpkdagGSLm8TVVj0Ox8EE+iqS=knS2AgKz2sycMWtOtBN4Nw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] gpio: ep93xx: convert to multi irqchips
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 4:14 PM <nikita.shubin@maquefel.me> wrote:

> I had such a thought, but I was stopped by the delusion that no one is using this
> hardware anymore.

It is definately *used* a lot. It is dubious if it is used with the
latest kernel.
Hartley was/is using it on engraving machinery and using the latest
kernel, I think his setup is pretty large.

The number of deployed machines using EP93xx is likely large, but
more importantly, as with MOXA Art it is likely to be internet connected
and managing vital control systems.

In short: nobody may be upgrading these kernels, but the definately
*should* be upgrading them. For security reasons.

So as a community hat I have concluded it would be socially unacceptable
to delete it and not offer an upgrade path for these systems the
day they realize "oh s.... that is an internet connected pressure boiler".

So if possible it should be modernized.

> Not promising anything right now - but such a job sounds like a real fun.

I would be grateful.

Yours,
Linus Walleij
