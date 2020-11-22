Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93AB2BFBE0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 23:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKVWC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 17:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgKVWC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 17:02:26 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7E3C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:02:26 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id gj5so20637584ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1G9n/p+A9jTECzi1tQiMVIoBBKxdrMCZ8k6vKAnDLc=;
        b=R1D5l7Q/2PikUyIgixV42SL6CoifIonkLJ0MpSO+TNgLUWhgGssInEm/SZlLtWg4Gp
         PwnGMfK+a3FNIXxzCU5Y5c+3GRUdfFN13t1oqEsSkndczby8beXcHyso/2RtK+6dKFpF
         F4q2e0zWVW+/X6vd+T9mJLcdF8+6WwVP4GgFsaY27Nel5zV0iWkROTf+zVYTajMFFP4j
         7INiyG4+KT/WnsT7Zzm4sonGu9NpeVUv+suwNYAogrzyDvNFM4c8HofbiSlXrL7akWM4
         1YjvT5u/rTiNqxcqf+I3Y7nEm1QenXgcPYkoSLwbUZ+TJ64xim27M3MbmbUuKDDQ+ZMe
         BV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1G9n/p+A9jTECzi1tQiMVIoBBKxdrMCZ8k6vKAnDLc=;
        b=PDQgW3sNSQDDXqB0IwSmF8DvPxNN58MpOT2zHQ2ypdg6WeGvNwQeG+Syo0fVl5rBZi
         d2bxMl06Ear0ryfHNLj1PwGvYi7f0KG+ZGXGmaM67OO0P34lifpn2n0bZoX46gIi/kZL
         B5MehxRtGI9utsXo9LB3FGGlAKpKwBXMyOGNMmIhC9fzjZbErBMjCJnXkh2l05uIrNxp
         K8561VNWfO3IOyiHPNhWJv4k6u9JVbiSeLfAx7zt6DXWqTGFd0j/7QL9qL0OTv1HYBQT
         71vaXrXQMJrR/XVOvDTWVm+jo1sjiUZrUT0Chuc9KYk55FaLY00QT01c+uK/zH3lKwRB
         7TAQ==
X-Gm-Message-State: AOAM530f7FwwMxwUKWChIZC+CXVeU0UOusR98C8yakWtfcmwmkzbVJL4
        Xm5ToZ5V8W0b2/SuN2GrSrsgTi0EtUUKymLia7A=
X-Google-Smtp-Source: ABdhPJzJ6xNhMXuBa4xagGSXQD+1DW3j8R+R5BNLivTDQCFs8zZawLqQuLrW7tYu6a9nH7LqqffarOmGi1BCknM17ks=
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr42615819ejd.328.1606082545161;
 Sun, 22 Nov 2020 14:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20201120153229.3920123-1-narmstrong@baylibre.com> <20201120153229.3920123-3-narmstrong@baylibre.com>
In-Reply-To: <20201120153229.3920123-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 22 Nov 2020 23:02:14 +0100
Message-ID: <CAFBinCDf7xJivLXWmqN=-utdKeDnGnQK2dC-zGU4dwZC=zc+Cw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: meson-axg-s400: enable USB OTG
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Nov 20, 2020 at 4:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> This enables USB OTG on the S400 board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
this is already upstream [0]: 19f6a6b79880c97bf910c3c72725eb70


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f450d2c219f6a6b79880c97bf910c3c72725eb70
