Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C812C71A2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbgK1Vvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:37 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:51540 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731290AbgK1StN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:49:13 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 1405720AB7;
        Sat, 28 Nov 2020 11:28:39 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 29046200FE;
        Sat, 28 Nov 2020 11:28:36 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id DE5B33F157;
        Sat, 28 Nov 2020 11:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 2E7CF2A522;
        Sat, 28 Nov 2020 12:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606562913;
        bh=bUu9xuiJBLYbY3Ckw9r1uvUgI2YgsuLZgK0IecpJuA8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WMaR+1Ro9QHf6tharipr8XvKyFk9p4PSGItbTjRTKhTjj00J33vMm4YklW6fo++rN
         3YwXEZqc1ZQH83BtZd0WNfooJGU8DCvUmswZlR9RXdQ8kcKMlWWVZ66iz7yhYkxm/X
         2XcOLzqzkKQAj3W8v2z0XMtEY3Nk/GIVlDZ8ehqE=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iA2Z0az4S0cs; Sat, 28 Nov 2020 12:28:31 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 28 Nov 2020 12:28:31 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id E6ACE41EAD;
        Sat, 28 Nov 2020 11:28:30 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="u6a4pnNm";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id D6AC241EAD;
        Sat, 28 Nov 2020 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606562905; bh=bUu9xuiJBLYbY3Ckw9r1uvUgI2YgsuLZgK0IecpJuA8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u6a4pnNm2ANChoSW8d+ZSIo0sF4zBpQ/tPVCLNXiZ7aNQKmgt6ORG3WeatN+xaAsP
         5UI6u7/EfTkQ4LbX9mBvBKi1JTbMk/0q2qmhNlvnahfkXLim7A3vC8B6kZqyzYZIDG
         06Xh7kI68hjo0loCZgAsjZv2zjRDCkZ/tvnUVlqI=
Message-ID: <1666a61f6ea3e7d573795f9000a0b096c7b7dee0.camel@aosc.io>
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add
 DT for PineTab developer sample
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Sat, 28 Nov 2020 19:28:19 +0800
In-Reply-To: <20201128103827.d6sfc2eumli2betx@gilmour>
References: <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
         <20201116155508.364dg6ycklwylswe@gilmour.lan>
         <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io>
         <20201120155939.3ajmbny2pka2vsnf@gilmour>
         <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io>
         <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
         <20201123111512.y7lbwsipbkcpuleb@gilmour>
         <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
         <20201123125332.2p5z3ew7svszvyfs@gilmour>
         <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
         <20201128103827.d6sfc2eumli2betx@gilmour>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E6ACE41EAD
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.1:received];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-11-28星期六的 11:38 +0100，Maxime Ripard写道：
> On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
> > > > > > > Okay. But I'm not satisfied with a non-public sample
> > > > > > > occupies
> > > > > > > the pinetab name. Is rename it to pinetab-dev and add a
> > > > > > > pinetab-retail okay?
> > > > > > 
> > > > > > To me, naming the production version anything but "pinetab"
> > > > > > isn't
> > > > > > satisfying either.
> > > > > 
> > > > > I understand where you're coming from, but the point I was
> > > > > making my
> > > > > previous mail is precisely that it's not really possible.
> > > > > 
> > > > > You want to name the early adopter version _the_ production
> > > > > version. Let's assume the hardware changes again between the
> > > > > early
> > > > > adopter and mass-production version. Which one will be _the_
> > > > > production version? The early-adopter or the mass-produced
> > > > > one?
> > > > > 
> > > > > There's really no good answer here, and both would suck in
> > > > > their
> > > > > own way. The only way to deal with this is to simply avoid
> > > > > defining one version as the one true board, and just loading
> > > > > the
> > > > > proper DT in u-boot based on whatever clue we have of the
> > > > > hardware
> > > > > revision.
> > > > Then will it be okay to rename current pinetab DT to
> > > > pinetab-sample and then introduce new DTs all with suffixes?
> > > 
> > > No. From my previous mail:
> > 
> > It can be seen as dropping the PineTab DT and introduce new DTs
> > with
> > suffix.
> > 
> > Do we have rule that we cannot drop boards?
> 
> Are you really arguing that removing a DT and then adding an
> identical
> one under a different name is not renaming it?

Then we can just keep confusing name?

If we do so, how can we mark the new DT as "the user should use this
one"?
