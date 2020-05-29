Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271411E84E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 19:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgE2Rcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 13:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2Rck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:32:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1191BC08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:26:33 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so118500iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8OACykXjIzxNzzYJDcQomDu+bSaXx9nM76v7J1rnOc=;
        b=N4jmxuBRHu9i+7FFNASFaQjN4abnqiZo4PhPXmtm959rzOBOSm+7Huvel2yMZOGL6J
         L3YDrdL0zD8zpqbQ04ZWiR4x4O3kagbBm6APPFB13kSMk3H1QROQY+2vIF1ZldyGqRDF
         bAqJl18vR4TiVZQr/619DbLOoqewiS/BKYAMfJOp9Jj+S+C/J3VS8STRCBBSmsSkaksb
         ApY3WPl8R/Eic5rKAOi0eDW1pnrW2e+US63v/lpJ9u7BBUa2IFu/beqHQ72ET5FqhBIi
         lt/RcnyklXiCgf7y8HknKN3BSNFEwTssq3fjHwaUyqIQmXDKR6d1H5VWpqgkblSyq2n9
         SueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8OACykXjIzxNzzYJDcQomDu+bSaXx9nM76v7J1rnOc=;
        b=gPOynwox3ubqrPiqHAlY/PeWSKZ8ksJaFh0PKyb/7sggEJNjJRBLkiUNhC1szmvbzU
         QW7w/DjXyUVmTOAln379dyPN9gpHnCPbep/WiXROuCottrWR0dj/aDzzSf/6yxWkKQh4
         nRlQ/90S2pQGfm/Kk/azvQtecrnd5pS1Cv0xSpoIvi4AFjoSse0hKV0mgQt/kxbdqSwt
         EcIWtpDIIuTFhsBUOxqQGymHDLb7XRug+Hjtve2kvUbuYn3mrIOtv8KmgVE3S14ORNam
         TMyMWUWSFyxgE5c9V3ErI4GxqiPQwzpMWQYxCe3PQZTsRhzJ6J925ttp2K0D2fCsTTC7
         vQAQ==
X-Gm-Message-State: AOAM533nwbbIjdWt6MTpQhRWR90vYULc3EFAKOZvhikeik0EhmvxGR4N
        s1Ob0KuqUGviX6Owq/XKuWz0J8i9MulNfrM6x6uvSQ==
X-Google-Smtp-Source: ABdhPJwbz0o/jI3+dVTtyWVPjpigszAYMfgQJZaWm9/WbEOU+YXtNt0QJXWVbd3dmvHCuLQo0DqWifEdtyW1qHfQRg4=
X-Received: by 2002:a6b:38c4:: with SMTP id f187mr7311468ioa.205.1590773192031;
 Fri, 29 May 2020 10:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <1590750293-12769-1-git-send-email-jiaxin.yu@mediatek.com>
 <20200529110915.GH4610@sirena.org.uk> <CA+Px+wVSwJK-=75chKLjSEe3bPRtV2wD95W5D_pdR0Pw0G470A@mail.gmail.com>
 <20200529130539.GK4610@sirena.org.uk>
In-Reply-To: <20200529130539.GK4610@sirena.org.uk>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Sat, 30 May 2020 01:26:20 +0800
Message-ID: <CA+Px+wVhXoU=BdBmMW0sdPtUrnQH+Kn6dkFdW-n67qEDGceCEQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt6358: support DMIC one-wire mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        howie.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 9:05 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 07:22:43PM +0800, Tzung-Bi Shih wrote:
> > On Fri, May 29, 2020 at 7:09 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > What is DMIC one wire mode?  This doesn't sound like something I'd
> > > expect to vary at runtime.
>
> > It means: 1 PDM data wire carries 2 channel data (rising edge for left
> > and falling edge for right).
>
> I thought that was normal for DMICs - is this selecting between left and
> right or something?

Not sure what is the common name but use the same context here.

MT6358 accepts up to 2 PDM wires for 2 DMICs.
If one wire mode is on, MT6358 only accepts 1 PDM wire.
If one wire mode is off, MT6358 merges L/R from 2 PDM wires into 1
I2S-like to SoC.
