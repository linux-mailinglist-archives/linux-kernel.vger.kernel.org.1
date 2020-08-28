Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D249B2556A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgH1IoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 04:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgH1IoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:44:14 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFCFC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:44:13 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id y2so146408uaq.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeXlfnXZ4sTJswhwNtffWf0Y5RYZt7CDOEurreh9XAI=;
        b=LvoKCakWRKLvx/0BHLE5JGzq92yOk3o/lHDjeCNYJRZW2x4PnX4osD+BUJKunyCUj2
         /bqB9UVotpxVrZ5G923Rznp1fq4DzwoO4tD3hKWIMMQNSfyK3iXaOd14ozrYm5Ye5HCq
         0Rzr3iNz8cf5rlznhBgAvVEGYCLwb4S4oXh7MRVdr9zhOVoLT4PZvIkIJuc4utbIjTcz
         UqJF64cJ6Jk/hR8jwWu49mRJ8G2l8vDf+TK1xPJS06hCvHJZ7/rD3Laa0bSm+pCy/iJL
         0Mb1WU+Xtn3sOlJLpNsl3jOqTIEXq6svmJo31r7nkA/4n6OYkyyD33PSoncLANEO2ydm
         Em/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeXlfnXZ4sTJswhwNtffWf0Y5RYZt7CDOEurreh9XAI=;
        b=DCXlcks0ocDs6U4CJWVkTUhjqmaiMnxoG3L+DrQf2k+b7UZNq5QHaqdc4joYBGA9EF
         gNopb53UFvd9rouWuXqAdoB9F5jf0ZAMZgmDNjzsfNdPTQ4S/KHqtX6xUtyDPiXA/X3K
         ugVBfxWWib+056BoTaccd+kHneO+c+fXPnLodthOq6LPdn+z00wJwzNhhSjESVZlsC1h
         vaL37TD+4z61yoxoWblNE0lH7XGNVYrfl/Sef441I/C4ddGhd0BvP24G4BBQzs1jtNKp
         plqDOwFf21dWEtuqnyRgNqNg61ZXPy9MLRA1nzY+ZMz5crLe754B1+zx0REo69DYSD0h
         U0/A==
X-Gm-Message-State: AOAM532PpEd5Xx8dqUifwUXVs7Y5sKiWHsDNS6Pv1PHvqu37CT9lJe9H
        41ZOSC7SbR5/qIk9EH6NH3bviNZJyezrk4oHpq5Xfg==
X-Google-Smtp-Source: ABdhPJxDXAOV/vb6si47r9ICjb8OmqVI+/7MJPxURFzZTGQqh0+TR5mXHiyTJTbQAY+DumtfmYUO31qltv4NzpdAdck=
X-Received: by 2002:ab0:2848:: with SMTP id c8mr283199uaq.15.1598604253138;
 Fri, 28 Aug 2020 01:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200814014346.6496-1-wenbin.mei@mediatek.com>
 <20200814014346.6496-3-wenbin.mei@mediatek.com> <CAPDyKFpt6-a+pkTXb2RZdx=yTONetugSCKbtSsRD2xQ3PRPhDQ@mail.gmail.com>
 <1dfc1938-f5e8-c4c8-57c7-d7b6c33dcb1d@gmail.com>
In-Reply-To: <1dfc1938-f5e8-c4c8-57c7-d7b6c33dcb1d@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:43:34 +0200
Message-ID: <CAPDyKFp+nFq11YcnNSe6sfDx-gkBHiYAjNE+r-OQ8HdrK1LBKw@mail.gmail.com>
Subject: Re: [v5,2/3] arm64: dts: mt7622: add reset node for mmc device
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 10:23, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 24/08/2020 11:50, Ulf Hansson wrote:
> > On Fri, 14 Aug 2020 at 03:44, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
> >>
> >> This commit adds reset node for mmc device.
> >>
> >> Cc: <stable@vger.kernel.org> # v5.4+
> >> Fixes: 966580ad236e ("mmc: mediatek: add support for MT7622 SoC")
> >> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> >> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> >
> > I can pick this for my fixes branch, together with the other changes,
> > however deferring that until Matthias acks it.
>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> My understanding is, that this will land also in v5.9-rc[3,4], correct?

Correct.

Applied for fixes, thanks!

[...]

Kind regards
Uffe
