Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4434F2DC06F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgLPMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgLPMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:42:36 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A0DC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 04:41:56 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o19so22326513lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 04:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdWZ2Pk1OFPUwPBsoB678Mi8MqbdY4ggPgKtXlI/SK4=;
        b=tmT2NwDjj8bfQbdMkIGY2YjDPKm0YLTfWJZk10f+bQMuSILDTxEAVs0VdfmbkUqMHC
         Tjd1yn1ZkdF2HBjgzVPs1dz6rd4Aygot+krES5typbxrzS4egI/+z08allpO3l3TOeb+
         RQLxJoPUyVfnJeoG7i3Q0r7saNMLmY5bPb3WqJ54uiBdCytn1MzufdJ0DLscPiHqKmAg
         FJ4K+AYpxPJ3Hke98FrPCPIhGxC0fMCwko8Q0qlKApJP3bDLlGmtYhM/onpb95d6K9Mc
         f3BUudJp4PQrUDe6crxuDhyR7vw7xiAk/j15gqvx57gDdNaGVMpKqBfrbgrIv6AKVrLm
         NUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdWZ2Pk1OFPUwPBsoB678Mi8MqbdY4ggPgKtXlI/SK4=;
        b=q5EbCMmdqUURtqHJ4A2bsFfj5GQVZaEw3SEoIM3OEdFkapajWe5cFnYs5GmVTqzqf4
         k7uAEpAkvfLQOW+3u703wMw4A0DIY0HMr5ycA/grWquNPgIX0loOyVX3N52OVms8coG5
         fa94ZOsd3lYKUwGlcVefgT2gT2FO3aZH3gW0AfjXyYTR5Xx+tCsDaKq6jN7e2B3H4oQ2
         uNujF/Olibed0/WSWJgnBTaxTaIQn3F1hTSZWViNb/6lSpI8Ee2AuhqQTDnFBtuZOg7O
         HURDRJQ2oXjvcfk+sW2m+pUBBpdydBtzButLA/yKemLsCMJRPituwwcIpyksOe3Cc4Ge
         gy/w==
X-Gm-Message-State: AOAM530bwpVSh1n/AEvnmRCPA/aAbt0hiVEAvk7/xdOg9h686VpvlsAq
        46pY2psHrROE5FL4acu4bnM7sLJ1cpRrPg+T6vnRiQ==
X-Google-Smtp-Source: ABdhPJyZMYbSapCUAF75EOCuZAjdXjhZ+BEiBYaZzhIBzbUzf7PgwgU03PMTn0yH5XnqH4CgTnhtc/1VsDlALIWtp7Q=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr9572843ljl.467.1608122514851;
 Wed, 16 Dec 2020 04:41:54 -0800 (PST)
MIME-Version: 1.0
References: <5fd76cf2.1c69fb81.6f19b.b16a@mx.google.com> <483b08f2-09c3-e753-d2ce-4e34fee627f3@collabora.com>
 <CACRpkdbozXM3FHQB9+GcPJZdNT+Vi1223m2uEqqJ21ukY1A4Gw@mail.gmail.com> <8e5e0251-9450-5c93-cd2e-c44779a72b0c@collabora.com>
In-Reply-To: <8e5e0251-9450-5c93-cd2e-c44779a72b0c@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Dec 2020 13:41:43 +0100
Message-ID: <CACRpkdb8Bgie3dJME5qQwu_33b6zVYzAayJnHJUCzrkntpNNXw@mail.gmail.com>
Subject: Re: linusw/devel bisection: baseline.bootrr.mediatek-mt8173-pinctrl-probed
 on mt8173-elm-hana
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Johan Hovold <johan@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Sean Wang <sean.wang@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 11:10 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:

> > It seems we need to teach the core to ignore the name (empty string).
>
> OK great, I see you've sent a patch for that.  I'll check if we
> can confirm it fixes the issue (something I'd like to also
> automate...).

Yups would love to hear if this solves it, it should be in today's
-next.

Yours,
Linus Walleij
