Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D631A16DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgDGUeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGUeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:34:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC62C2074B;
        Tue,  7 Apr 2020 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586291689;
        bh=YRABWMvwvHV0PmDLsBbttXpDhy97LPhtP+IKmrC+GN4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=myOh01Dmx+KkdWrwz40Cn7g/n00RxRMho1HYuUNqGKXOcalbV/rv3vk/Ni5UOFIMf
         wjSfQFrDMjiu+Kpe0IwkQFz09Dx/Ah2ANqDryLaB5RDYetyY4DoKURVSBQ5BgWy9ux
         oXBEvtnVgLj4JdHZEFyUDi4buGHDcpmErypEZF5Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAfSe-u1VNDiY0MXGwrUqsNLBiai8zivxoPiyLnkJMZ7hcX+Eg@mail.gmail.com>
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com> <158605608663.158626.7732167785990086489@swboyd.mtv.corp.google.com> <CAAfSe-u1VNDiY0MXGwrUqsNLBiai8zivxoPiyLnkJMZ7hcX+Eg@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: don't gate uart console clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 07 Apr 2020 13:34:48 -0700
Message-ID: <158629168890.88454.8918367547173437575@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-04-06 19:02:38)
> On Sun, 5 Apr 2020 at 11:08, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Chunyan Zhang (2020-03-31 03:45:32)
> > > Don't gate uart1_eb which provides console clock, gating that clock w=
ould
> > > make serial stop working if serial driver didn't enable that explicit=
ly.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> >
> > Do you have a Fixes: tag?
>=20
> I didn't leave a Fixed tag since that commit [1] will be merged into v5.7=
-rc1
>=20
> [1] https://www.spinics.net/lists/linux-clk/msg46430.html

Please still provide a Fixes tag. It helps track what commit is fixed
regardless.
