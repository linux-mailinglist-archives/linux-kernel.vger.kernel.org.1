Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACA62D94C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439601AbgLNJMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439584AbgLNJMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:12:36 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4220DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:11:56 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 23so28282064lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c3B4jvN7kEXAo7mrGFZLnN9AG7JaK5tlblUs67Gc2Q=;
        b=VQZYA/KPSdZhAC/0a7gHg/uhHQXBKlAoRmc+YIS78xz3xeM3dzvvbFEFwhwdgtjl33
         nxyF72B6XRWLHt61qo1g79bls3eWhYm2QRa0ERnaSytnpKrCIF/LnZhBDmeTUF8VFCX3
         tqpDFZH/+3OgZfNVhlVwTQh8mIIHAHUDjyVillugYk0zF6leZ2qaVVvCutvyijIKXyGV
         LnmspAK+fgdCb8E7g4iB6KVKd8/G5bVsgb6QmK330TLqVvIUvTVS5JaApuSGrLxo394n
         9NS2x+0aHzBlW1rvh6MuhIRsuxnFRvg2ZqpZRgZos6p9R+aUqgo1zr7Cn/Lvnzjysoyp
         FX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c3B4jvN7kEXAo7mrGFZLnN9AG7JaK5tlblUs67Gc2Q=;
        b=P5RpmiJV4hM6RmE8Cwyd+jSt47yw5GltUT5qjQDjlAzPCc5RQikh9xUrVIyzySRtTi
         77fljGtR01dzjJqUL9J5Z2bACVFMLYCghDPRn4nLQfXO7ggvIsFxA+JwEIxjJRr2jdiU
         N1nACm6rgKPYw6HJqIp/qRRjnggJY7+EYm6Brzj/z0oXSpmJl50NnmZijMbcAK+1xqi9
         h2PATm1GGCF8glrfrna1w3WDMtxLfPq2MX1LO0x+IGvszOepnqgNnwOu81mauLmXdavo
         Zv+w+pl3HVlvw6399M9DuR3QBLy8XyXD/mvR/Cbw0bFJYnKwM2Ow8T2ROOeM5A7Kk6no
         o33Q==
X-Gm-Message-State: AOAM533YIqn/9lHS/WUpGp75MclOA9LeSgNOTUC9flx0Sbt9+DXMDZ8q
        m8ZQwqYRnyjKYswO3lZPDlRyDClQ+S/YPxUHPjiO8g==
X-Google-Smtp-Source: ABdhPJx4mvGSnAulzpG7cr1odo2sol3BUseDWpJyTH+nCqCjd2QfcYAMQZ1rFDZPSwHMc2oN1JZjXTNzTgeIvZALP0Q=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr9388449lfe.29.1607937114798;
 Mon, 14 Dec 2020 01:11:54 -0800 (PST)
MIME-Version: 1.0
References: <1607934255-52544-1-git-send-email-luojiaxing@huawei.com> <1607934255-52544-3-git-send-email-luojiaxing@huawei.com>
In-Reply-To: <1607934255-52544-3-git-send-email-luojiaxing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Dec 2020 10:11:44 +0100
Message-ID: <CACRpkdaj4yZ0MAh9J_uN5+1MTH37fQiDGnj0O9UTeZYazEzZpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] MAINTAINERS: Add maintainer for HiSilicon GPIO driver
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 9:24 AM Luo Jiaxing <luojiaxing@huawei.com> wrote:

> Here add maintainer information for HiSilicon GPIO driver.
>
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>

Patch applied!

Yours,
Linus Walleij
