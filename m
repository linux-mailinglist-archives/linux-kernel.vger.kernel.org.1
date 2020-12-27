Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436552E32E1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgL0VRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgL0VRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:17:19 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B91C061795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:16:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h205so20043233lfd.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHA52hpeNhfsc6lYY553O6SKD7NWsjET+INvz3i0oks=;
        b=cAXQe7zGXrn5Ggd8p7VLdtu1xQvMMOOJAMWxmNFQq8dIIjkKjs/Tuw3jFpmy12wNaG
         aNMcI6SHIQ0WmPbOqITt8jmJy++dGHXy6ZXIQES36X7kb2uNJas9pW2uDVvUEWwWCV1n
         vG1ZBZ7AHpo6H47W7xbZt/Q3vo8btS7D5TT/i2nNihrGdJ6JAFB0oLYXWMDd0NLCVtC3
         +FcwSD1YMTLhDGtb3vomj5jTQ2gP8wquijDB4u7/waekA1hu+MfWkVOIZOFx1hCOE/26
         EZ1+HH6Gmvtg58tsYmErly9H1jOYQvL8/vFjwQ52rvCJcCw3HvFxXMhIJC4HcWYDT9XQ
         AnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHA52hpeNhfsc6lYY553O6SKD7NWsjET+INvz3i0oks=;
        b=d8nTdY8Bs20RpuVJMkyl68zBxcwcSNHv5vfYHr4YhQ/EEKurkDe1VtLM3ywMpQk9th
         E4Kmv9/aPT+vn+7BlD3AdN0g0Byo7veBF+bRltSlxkbbnJKzi2dAi8up9c9hK3sSFmWO
         F/2xF6Awyl77RH3LI3v9CogYCpKawJTUL8esDU0ozXDLfeIsEAhgo5GJenIETtBKwGSr
         aWoSNwUUNnU+mcIATwKY1s3Bc0BPP6DeJWoIAa4ezQLaRwrweP1KKlb4Mb+NmwlPShOp
         85cEAeCbE25SKSl1fDaA9OqQYTaQyxnpsNWrV1L97DDCRi84LVSiuyBbCdMAETi/qcLK
         KMiA==
X-Gm-Message-State: AOAM530tOxDKC5vCv4ALnm8QA4IZHT+KJhofpAWTYZToCCEMB2IPJwKv
        s4eemTrBFzLqJeUMvE72jcN4vDlCoiimz+yYgvO0Xg==
X-Google-Smtp-Source: ABdhPJw8tWJODRP92VyA2n4t1a1c4F2W75dmcujyE3C61i1j8crUTIS0eN6A86WC4MlfYW/tOwoihem5gZCAToIVFxw=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr21435937ljj.326.1609103797976;
 Sun, 27 Dec 2020 13:16:37 -0800 (PST)
MIME-Version: 1.0
References: <1608718963-21818-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1608718963-21818-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1608718963-21818-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:16:27 +0100
Message-ID: <CACRpkdaDFgoaLnqmPFSnXe3KyNrGnpQObb0t7d2X_btU7VWD5w@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] gpio: bd9571mwv: Add BD9574MWF support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        khiem.nguyen.xt@renesas.com, linux-power@fi.rohmeurope.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 11:22 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:

> Add support for BD9574MWF which is similar chip with BD9571MWV.
> Note that BD9574MWF has additional features "RECOV_GPOUT",
> "FREQSEL" and "RTC_IN", but supports GPIO function only.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This looks like it compile-time depends on the other patches right?

Yours,
Linus Walleij
