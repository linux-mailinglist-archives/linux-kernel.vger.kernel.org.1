Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5699C23B2C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 04:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHDCfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHDCfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:35:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BDDC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 19:35:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so37133291qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 19:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmrOBPbvqH0tUwujk7SVsTyO/ZlaXtcKlCwky7dKn9o=;
        b=LONJ8+kDG0Db9G9T5+29RjtHqahyZ2pcP1Y5qqhDhaLBoNDQPe9wciDe9twj3K35Z7
         mb10Ul7loDbQiIEXxvDd8zgtS4yqZcyovXHGp3m9Ln95AJD0m0UfEJqTKYsB5xQDoli/
         azoAYhW1JbOFIn33KbNEYR9lA9nK6X4lThzpomRRocTm3kar1J5PxiQAoqJHcN+WF80E
         0+09+einulhyH1hBSFH31MHi3ftXyE4A0qbdyMbOmkIpKZiRcuRr6V+72E6LZ+JNMcMq
         0TEPIWd/6zEwOFZA9UTgpXmXCFAT4RskpALMGbIa+BOoGGdiokhzgMgfOxT2/F5gYowk
         ntGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmrOBPbvqH0tUwujk7SVsTyO/ZlaXtcKlCwky7dKn9o=;
        b=BxvN3oYXRILLDdfbAZ/zag72bIce0d8npCCH0iNd/CXp6tsO8+KUblL6tvKlG3Eg+z
         Jg5R0Y1AY7kk5dxbNKH4ZmfN1K7vhVcLXSueS7c6///3TUx1hal77iCduiFkj7G3oKdC
         zW/ruKyGFm6yYF+9jzAVRSJUB1x2NCWHHZj1lwH05qhGz2yX6j8ME29n0IDqf9oA/8Oq
         NEvnj/FO8pfsW+Zeiac1iUFjboQdL/L1HWbczwMhuYyyBPLxNxPDB7d6Mi3EpA6WB9Rr
         61oUzC3OQppmMAfLhODSJEam/e5NYA2Wb8TmuezZTJVZxNHcyT1fTh8H3kf6qNdAYa6d
         95TQ==
X-Gm-Message-State: AOAM532BhGU+XRpQTTzN7WnS1A2sQ3jaO01MEKhyrdlAZ7UOJuJPjrOX
        lvDLz6ff6gEbZZ7LHrk29Aysz/d/e4l6hUTX8nI3t8eE
X-Google-Smtp-Source: ABdhPJx1F4Rp5o4LA8Gjn0KDh/r5IB4SF374BJSkFakd8/t+goX1ZwnWeeLNi2DN07CDXxi4Cu81LFxCplyDjnUtX4s=
X-Received: by 2002:a05:620a:628:: with SMTP id 8mr20046814qkv.103.1596508523476;
 Mon, 03 Aug 2020 19:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia> <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia> <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
 <20200804021114.GA15390@Asurada-Nvidia>
In-Reply-To: <20200804021114.GA15390@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 4 Aug 2020 10:35:12 +0800
Message-ID: <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 10:11 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Aug 04, 2020 at 09:39:44AM +0800, Shengjiu Wang wrote:
> > On Tue, Aug 4, 2020 at 5:57 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > On Mon, Aug 03, 2020 at 04:04:23PM +0800, Shengjiu Wang wrote:
> > >
> > > > > > clock generation. The TCSR.TE is no need to enabled when only RX
> > > > > > is enabled.
> > > > >
> > > > > You are correct if there's only RX running without TX joining.
> > > > > However, that's something we can't guarantee. Then we'd enable
> > > > > TE after RE is enabled, which is against what RM recommends:
> > > > >
> > > > > # From 54.3.3.1 Synchronous mode in IMX6SXRM
> > > > > # If the receiver bit clock and frame sync are to be used by
> > > > > # both the transmitter and receiver, it is recommended that
> > > > > # the receiver is the last enabled and the first disabled.
> > > > >
> > > > > I remember I did this "ugly" design by strictly following what
> > > > > RM says. If hardware team has updated the RM or removed this
> > > > > limitation, please quote in the commit logs.
> > > >
> > > > There is no change in RM and same recommandation.
> > > >
> > > > My change does not violate the RM. The direction which generates
> > > > the clock is still last enabled.
> > >
> > > Using Tx syncing with Rx clock for example,
> > > T1: arecord (non-stop) => set RE
> > > T2: aplay => set TE then RE (but RE is already set at T1)
> > >
> > > Anything that I am missing?
> >
> > This is a good example.
> > We have used this change locally for a long time, so I think it is
> > safe to do this change, a little different with the recommandation.
>
> Any reason for we have to go against the recommendation?

Previous code will enable TE and RE  together even for asynchronous
mode.
And for recommendation, previous code just consider the RX sync with
TX, but still violates the recommendation for TX sync with RX case.
So at least this new change is some kind of improvement.

best regards
wang shengjiu
