Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C272AF3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKKOes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:34:48 -0500
Received: from smtp1.axis.com ([195.60.68.17]:32587 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgKKOer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1107; q=dns/txt; s=axis-central1;
  t=1605105287; x=1636641287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZo5FDiY07KFPg5BcSuAAsjtq42yWRgQkuO3O7ZjX3Y=;
  b=UIjzT90MLV/kjGXH6P6byy4MqFeGjOkRVvaTUqoj3mSvroDa9zEbKC0O
   IoQekzMUsaQqA7OPnYw/FKKhKK7I3GjEPVZWPv9de7WBEG66hFgzTm3Br
   UNL+ESb2tIYEqeXQa6UyIxR93CYUgKJ8lx+mXOYkk2aGcKcQTugD+sNqb
   jBU157+B0z3D2wJVM+ieCFXDlbtk48SmPACZKwtAt5L+0u1HcYgcV4kuM
   rlIb9ZhSeJtFEQS4iE6avIeUlZpBewlDbbmLwBBZCm2F/Cw5HuyH0Q8DL
   YKDXM6wEgTqcP0WE9K9yA4aL0QQAQ1AyyGcSOMz1rGjfx3GRSAxCypyvg
   Q==;
IronPort-SDR: Qn0yKih+djzo/7r4VIN8GWUM63O4VCWKptG4dc1Yi0j/ph3TVfFGNzdbypLR5cJR4pFfMnIxN4
 wHe+B6s7mER9Z+PMgZIv9oFpxOYQz57NqDKcEatUhVId6K/mGP4hqLnNfZQnXA1GAC9YmNP2+O
 Gsxoc9RaN+bxn99OcDdMBJ5QQ5+Y0MDLvBXWwEnD3H89XlHcyWZNjV1FsuZgd8JYcA1Nlvlj3h
 bZfJydwLYj84sQy4OQ3VMY0G52fVfhO42eWOSwBN4bOsjQgMQiEMBRIamatIPLIOljHBaCTNrf
 4v0=
X-IronPort-AV: E=Sophos;i="5.77,469,1596492000"; 
   d="scan'208";a="14952850"
Date:   Wed, 11 Nov 2020 15:34:44 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 48/71] of: Fix reserved-memory overlap detection
Message-ID: <20201111143444.tsna5rmvnke2e2my@axis.com>
References: <20201109125019.906191744@linuxfoundation.org>
 <20201109125022.156835188@linuxfoundation.org> <20201111125359.GB26508@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201111125359.GB26508@amd>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 01:53:59PM +0100, Pavel Machek wrote:
> >  OF: reserved mem: OVERLAP DETECTED!
> >  bar@0 (0x00000000--0x00001000) overlaps with foo@0 (0x00000000--0x00002000)
> >  OF: reserved mem: OVERLAP DETECTED!
> >  foo@0 (0x00000000--0x00002000) overlaps with baz@1000 (0x00001000--0x00002000)
> 
> Is it good idea to push this into 4.19 so early? It does not fix
> anything, it just causes warnings.
> 
> Such overlap currently exists in 4.19:
> 
> arch/arm/boot/dts/s5pv210.dtsi and can not be fixed easily, see:
> 
> > > > > >               clocks: clock-controller@e0100000 {
> > > > > > +                     compatible = "samsung,s5pv210-clock";
> > > > > >                       reg = <0xe0100000 0x10000>;
> > > > > ...
> > > > > > +             pmu_syscon: syscon@e0108000 {
> > > > > > +                     reg = <0xe0108000 0x8000>;
> > > > > >               };

The patch only concerns detection of overlaps in reserved-memory nodes,
and the above does not look like reserved-memory so it will not be
affected.

That being said, I already questioned the need for backporting this
patch:

 https://lore.kernel.org/lkml/20201103111110.lvapcdf4nndunsie@axis.com/
