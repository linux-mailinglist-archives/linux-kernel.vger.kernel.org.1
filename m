Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4052EEEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbhAHI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:58:49 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46747 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbhAHI6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:58:48 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 16EC91B64;
        Fri,  8 Jan 2021 03:57:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 08 Jan 2021 03:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=8
        O6u94pIlwIq7O7U2osx82iiV1SvqRhzxEdUxQwefzY=; b=OEo7HcAxk1okUqIg6
        Z5Sw0BK6FkrL8qbFy7Veh5vJuY9BgHlVyJUNgRXA7BPOD1ddnOPosluifwMsmMbN
        h3HsSExT7gyYtEiOYHjHVnDiQge5uveGryHCinrHdf1F+xSERHXAVzdxHD5dq1vl
        ZtXMTTTxcnslhTQ/swwIIGyaQS4rWcEd05Nrfp5llrEIEgLKG2IeiWExkGD2bVxI
        7m95VYkqgprr4mUhtPLbW5hi85WOKakHhj4FU/B9pTzW9WJvTGR3AR1VXwSBOKOW
        7iEgF9xngWUPw2oViGwYVFSkl4k6S8qvFtg367cXUjH3DE+yXA5GyjzCsNN9J6nb
        FCRkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=8O6u94pIlwIq7O7U2osx82iiV1SvqRhzxEdUxQwef
        zY=; b=EIc2m3Ij9XPqHtmObUiDpkOAScfX+0SZAZ1VwoWAK93uKTYL8FFuDR8Du
        TEBmxBQ+dbMfzFTUH2VKqMyDD8XMftDhJPQ4ORU6jebw3H5m4pe4roU5mLRBT/sp
        cRBwBwo+j1KzTszksOKcC/QY6DgF/DsH9+WvMbR5VBqoJVwLfNOPTnlvZ1eBNt7e
        u/z3VDjh9/SUDnAIJuZMuwsT4R66OV8QzdOf5j9zSorYVeYU6jic+K0p84YelXTL
        d4xAlVb6CHWJFZ4MirzUXE03T7DE2ySzV/8pXpvflfDb9pGVrd6exopENat9yjX+
        bBDZ2AH3agM8PYjlEad9adz3K/TGQ==
X-ME-Sender: <xms:hB74X4zWwvuNPQ1wvLlaLINsgWVAqu-oDS_z7wR1QLvgCU91SSXFOg>
    <xme:hB74X8Q9vbdGTJI_-McKi2tEeXYOXuqAQKlT9ZePqEZS8WBBN-RQ5qdhKuu2HhWHS
    12xIw1PjfoZ44MVFsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegfedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepgfejtedtjefggfffvdetuedthedtheegheeuteekfeeghfdtteejkeel
    udegvddunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:hB74X6W8ISEEM-fbcCeJ6T7a9Pn8PBiOEIEcsAijWQu9-oj-5Ndqwg>
    <xmx:hB74X2j82K3_kHZiWOXQlVX2qDtd8LqzdnH6s1lfHPmXjvN79LiHLw>
    <xmx:hB74X6CsTBTxLs451kv9W9_4Ng1LOkyVZyGIhVhQMVTmgzW5gbznHg>
    <xmx:hR74Xx5B9IMZWPi2Datu_Z06mOLEkq3A-c7LrGbuxycsZyw-vpFnLQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5FD47108005B;
        Fri,  8 Jan 2021 03:57:40 -0500 (EST)
Date:   Fri, 8 Jan 2021 09:57:38 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v5 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210108085738.va4onpg3v2pw6ojp@gilmour>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
 <0deae76aec31586da45c316546b12bcc316442ee.1608721968.git.wilken.gottwalt@posteo.net>
 <20210106101542.zziwdyhq7arysrsj@gilmour>
 <20210107094314.4cfd5756@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210107094314.4cfd5756@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 09:43:14AM +0100, Wilken Gottwalt wrote:
> On Wed, 6 Jan 2021 11:15:42 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > On Wed, Dec 23, 2020 at 12:35:10PM +0100, Wilken Gottwalt wrote:
> > > Adds the sun6i_hwspinlock driver for the hardware spinlock unit found=
 in
> > > most of the sun6i compatible SoCs.
> > >=20
> > > This unit provides at least 32 spinlocks in hardware. The implementat=
ion
> > > supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> > > reading a register and released by writing a 0 to it. This driver
> > > supports all 4 spinlock setups, but for now only the first setup (32
> > > locks) seem to exist in available devices. This spinlock unit is shar=
ed
> > > between all ARM cores and the embedded companion core. All of them can
> > > take/release a lock with a single cycle operation. It can be used to
> > > sync access to devices shared by the ARM cores and the companion core.
> > >=20
> > > There are two ways to check if a lock is taken. The first way is to r=
ead
> > > a lock. If a 0 is returned, the lock was free and is taken now. If an=
 1
> > > is returned, the caller has to try again. Which means the lock is tak=
en.
> > > The second way is to read a 32bit wide status register where every bit
> > > represents one of the 32 first locks. According to the datasheets this
> > > status register supports only the 32 first locks. This is the reason =
the
> > > first way (lock read/write) approach is used to be able to cover all =
256
> > > locks in future devices. The driver also reports the amount of suppor=
ted
> > > locks via debugfs.
> > >=20
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> >=20
> > Reviewed-by: Maxime Ripard <mripard@kernel.org>
>=20
> Does it mean the driver is okay and I only need to fix the bindings
> documentation? If so, would you prefer an updated patch set or only the
> documentation patch in a new version?

It means I'm fine with the driver patch but the binding require a new
version. Send a new version of the series with my reviewed-by added to
the driver commit

Maxime
