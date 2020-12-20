Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0C2DF68D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgLTSov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgLTSov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:44:51 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608489850;
        bh=q7CQdtmJ6I7XLlNUwEFcrFBqeXfXAvtLEXZ9U4L1q9c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LjplDPGJBLzzXrpAeWlxxCcPM6eULI/XdabcF4Dd9eozr4nyvC1Y/l0uJO01oEN8h
         pyntpUSMvBEmtIu5V06LErZFdhFjd3lF1FvaHENgYLG8UyUYWZe7sA06KpNd9SD5nH
         6r+eGmjGN46uRJqPz+4aJ0/WkcB4twgdPIBw6oUCUsElF+Dt4EyvDyPf2rgQzOVYKv
         sIWGR0R3F7N5+AK1BBNQfQLXsx2uZtn0j18ENjzocO6x7hRrhazwhrJ1NQF+ApSaYm
         3aQrwwcDDNhkfPvKahhSRCCNeqQlH4uMKtzSu5BZ0+TRFaBzLpSL9QZugnx5lOlHdX
         5LAMAnVKtsjow==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFr9PX=f=HyHBk4s3e_vnMDC53R1X18m7sKFCLMMjitPm+8oEQ@mail.gmail.com>
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-3-daniel@0x0f.com> <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com> <CAFr9PX=f=HyHBk4s3e_vnMDC53R1X18m7sKFCLMMjitPm+8oEQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding description
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
To:     Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 20 Dec 2020 10:44:09 -0800
Message-ID: <160848984935.1580929.936824086681978646@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2020-12-19 22:35:41)
> Hi Stephen,
>=20
> On Sun, 20 Dec 2020 at 12:39, Stephen Boyd <sboyd@kernel.org> wrote:
> > > +  clock-output-names:
> > > +    minItems: 8
> > > +    maxItems: 8
> > > +    description: |
> > > +      This should provide a name for the internal PLL clock and then
> > > +      a name for each of the divided outputs.
> >
> > Is this necessary?
>=20
> I found without the names specified in the dt probing of muxes that
> depend on the outputs but appear earlier didn't work.
> Also this same PLL layout seems to be used in some other places so
> eventually I was thinking this driver would get used for those PLLs
> with different output names.

Still seems like it could be auto-generated based on dev_name() +
number. Now that we have a way to specify clk parents via the clocks
property in DT (without any clock-names required) we should be able to
avoid needing clock-output-names in general.
