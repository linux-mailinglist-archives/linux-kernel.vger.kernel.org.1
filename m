Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA012CA2B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgLAM27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:28:59 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39969 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgLAM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:28:59 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0B1CS0pI007236
        for <linux-kernel@vger.kernel.org>; Tue, 1 Dec 2020 21:28:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0B1CS0pI007236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1606825681;
        bh=VyWzw1DvMDFjjtA/3/S0sKeLcAuAFNayvwZdG4gboqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qhEuwsNEJsh33k59vzkl2ot113SesjdpjwuP7bD6IcaxERipfCg9X6ErDprYwwN+X
         k8wXigRtxQXOMyclUxQOudp8m1GR7HRcRLMZOfoXWoPV8YlXQqUPOLHC+q3mIwqF3H
         Ulzb49taRLH1Hf+kSka6hcz1Hp7U+mMCZM/CXlRFV8g1uTxNi2TTF/lGccXFKlwNhA
         ig3orJj69KvJ03v8u3pbzRx8MPjiYmkXpwU4W6tt4IvwnTli/wNhsvJJUCWtcfooPO
         BOSCLevHjDHY0paHbv8rsQWbzfx0J+q1sNHe8x0q0LgEq0TvNowyqZ/r5dljZjduE9
         C9yrM2PqIM0pA==
X-Nifty-SrcIP: [209.85.210.176]
Received: by mail-pf1-f176.google.com with SMTP id w6so1029622pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 04:28:00 -0800 (PST)
X-Gm-Message-State: AOAM530n/mxBOTyZ02eoJa56Eczk12Y+bJOuGkj+dQaMdhNzn0Xrr+cB
        lJdUp10i4wN8yCdXVL2S7ImLWpVqpCuZXOnheWE=
X-Google-Smtp-Source: ABdhPJy+ofSVZ9Ikv2DuaLyZkregh9m//GeneZayHvYZ66OBCRiXI/pmfCGr0AWBTx++jj5S83lXfRAoQ4UqQcfr8IU=
X-Received: by 2002:a65:6a16:: with SMTP id m22mr2070015pgu.175.1606825680148;
 Tue, 01 Dec 2020 04:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20201121193657.51441-1-masahiroy@kernel.org> <01998029-6222-a2d1-9147-1a0dbc7b7e4b@synopsys.com>
In-Reply-To: <01998029-6222-a2d1-9147-1a0dbc7b7e4b@synopsys.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 1 Dec 2020 21:27:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvscBtRU3E3c-3Sy3tw8nTF+sqy5P0FYd_u0Dp8NKmZA@mail.gmail.com>
Message-ID: <CAK7LNASvscBtRU3E3c-3Sy3tw8nTF+sqy5P0FYd_u0Dp8NKmZA@mail.gmail.com>
Subject: Re: [PATCH 0/6] ARC: build: fix various issues in arc boot Makefile
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 1:40 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> Hi Masahiro San,
>
> On 11/21/20 11:36 AM, Masahiro Yamada wrote:
> >
> >
> > Masahiro Yamada (6):
> >    ARC: build: remove non-existing bootpImage from KBUILD_IMAGE
> >    ARC: build: add uImage.lzma to the top-level target
> >    ARC: build: add boot_targets to PHONY
> >    ARC: build: move symlink creation to arch/arc/Makefile to avoid race
> >    ARC: build: remove unneeded extra-y
> >    ARC: build: use $(READELF) instead of hard-coded readelf
> >
> >   arch/arc/Makefile      | 20 +++++++++++++-------
> >   arch/arc/boot/Makefile | 18 ++++--------------
> >   2 files changed, 17 insertions(+), 21 deletions(-)
>
> This LGTM. Do you want me to pick up these via ARC tree ?
>
> Thx,
> -Vineet

Yes, please. Thanks.




-- 
Best Regards
Masahiro Yamada
