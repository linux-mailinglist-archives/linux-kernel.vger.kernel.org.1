Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3721E7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 08:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgGNGOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 02:14:32 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:64067 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgGNGOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:14:32 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 06E6E33F024828;
        Tue, 14 Jul 2020 15:14:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 06E6E33F024828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594707244;
        bh=mOcbSlBkfHZn1T5iVADjaQnNfA8I3/LNq/v0cJT1fAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cqAASXHE2xvsuWfTGsHKyFDQ0O+vz02gDrjZDek4ngpLYWT5W/MAqVkMbJVvHNmGV
         O/2vjzOV71V/Ud0weZvBeDDCq6rL+bUUzrskD7JljG1+5vbrVn154Xe1Ka98k/JlzO
         tOwGIK9Pm7Y72c3mMlHgsWSq++wZMr4mBE27uaavR8AZijz9wZRYwpV2WlaYsv7vN4
         rhnEzkv7gZV1Sh7/3akVmIT0ZRqtz77m6+T2nteISia2vY3EBj2XmrAHNKjB7XDU8W
         e3f5aeF6+xVXDe7Pv0i5PoBNLP+vE2mV4BtUSvr8tEpQCilzsVMUho+EDk/8bXmycl
         to/QDh74WNAhQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id o184so221324vsc.0;
        Mon, 13 Jul 2020 23:14:04 -0700 (PDT)
X-Gm-Message-State: AOAM530pPcgIZxrwiv36FoAxIzx5MJg867ezUgDtuG5K6nENwSz1DuB+
        YtuurOcZvFljqqeM41NCrCfD1SeHtebHl52qZLI=
X-Google-Smtp-Source: ABdhPJyEQUewdqjYSjbQ5eQsqie1dSmZKBqqOnYOdQ1EPFt5mHUxq1RYQUHAYkUTcRbFtkaVmamaxfWs9F9YcL/S6+w=
X-Received: by 2002:a67:de09:: with SMTP id q9mr2024085vsk.179.1594707243302;
 Mon, 13 Jul 2020 23:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114005.791643-1-yamada.masahiro@socionext.com> <20200714022252.GA1151466@bogus>
In-Reply-To: <20200714022252.GA1151466@bogus>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Jul 2020 15:13:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
Message-ID: <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        DTML <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        - <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:22 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 23 Jun 2020 20:40:05 +0900, Masahiro Yamada wrote:
> > Convert the UniPhier EVEA sound codec binding to DT schema format.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v2:
> >   - Add schema for subnode 'port'
> >
> >  .../sound/socionext,uniphier-evea.yaml        | 70 +++++++++++++++++++
> >  .../bindings/sound/uniphier,evea.txt          | 26 -------
> >  2 files changed, 70 insertions(+), 26 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>


What do you mean by Reviewed-by ?
Do you expect this to go to the asoc tree?

I just thought the schema conversion
would go through the dt tree.



-- 
Best Regards
Masahiro Yamada
