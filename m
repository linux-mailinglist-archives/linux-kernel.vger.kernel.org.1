Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838212723E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIUM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:29:24 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56759 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgIUM3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:29:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 46BABB57;
        Mon, 21 Sep 2020 08:29:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Sep 2020 08:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=R
        HKQR7CbzI0F6ZRKVieWVWj1G/b0kU9KL/lrLU/cXIE=; b=BmH4loHf/twmMvruG
        h+1fAO/CvxSkfl44OnYhWxEx9nAlNqB9xc0MBQipOjf3YpW9p4Y2UxFv5u1jwwEk
        7itf8mgtLdyHUTNFAlgVz11YQvxeLAMdIXXbcBdiSvpXLoJ4iL8W4GXRL2AX9l4C
        w4d/8tRbIVhEJUimi7VoZszz/9dNSk/KQ/rw/7NHU0LJq6ICr2MalqxmZHNtvdCO
        GoS/5WX4ZxAXn3mj+IOgBmejzXi9Iydb/8cyfzXDvqVbHQeTJmGoEOEXwWPEAOmp
        MTQ3yIHAKIweDxETUuvLopmQ+JEaX7JiLaADyZS4QitYgrwa7a+/18eOkmQ8RUDM
        +Dfpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=RHKQR7CbzI0F6ZRKVieWVWj1G/b0kU9KL/lrLU/cX
        IE=; b=uCP6FvdbREPriWo7tBN7COrxikiM1temZ9SQ7f1vnlWJXXvpTgR8/9WKF
        kGwplJwffLMMZMU3LkW4bYkyd6g7UFI9QfVFjeAJjXI/SRHxXt3Cet9h5D8+gfnF
        OukGuVCqfRLO46NtvgMf/Rt2q6Vl4DxvzUFlQLq5CfjVCkYbMLCPv961KFo4RiMh
        ARu2F1aqKZfZaXxMvQx8XhOmZKqk7TSCFEzY102TvWsSUKDor6w+NO2M5GZABkbO
        XXF1vINgJBGIMsRMFOd4simfgjl+K3nqKrJoyEfVUe4Ozfw/CbYRhN/yJyHBan4s
        PFJzTtoMmqieBbOhGHyPo+R6I9ysg==
X-ME-Sender: <xms:n5xoX2Urj45I8RuFot4ZW1GTKO1jGOAaFRwEfOPzw3-hYRLhznqFMQ>
    <xme:n5xoXylUBDPDNvKOWfMGfVZeTqjyqmZDH_cMYtsDFq1fOKmJc7UloqI4F4-VuT8lU
    l0xdfK5E8_JQdgkrU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepheelvdfhkeelgfevleekleduvefftefhudekvdffhffhgeefuefgheegfeej
    vedtnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:n5xoX6YDobf3ogp7c8SHV-Yk_rRA2uc1uDT86C0UPE5mNFI5wgY1cA>
    <xmx:n5xoX9UdwW79t8SEbNgS2451IJpJPK2zkH1UejK3VnnXZ18zE4yFDg>
    <xmx:n5xoXwnWphsACygt4earwWgNmDEcjJ9UZiDhs4nrWeCxNQGLQO3IGQ>
    <xmx:oJxoX786_gnFaDjZ6XBX4Ymq0ztTe-t6QLlEfLX6vTz5qNRVAAO84E4SLM4>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F091328005A;
        Mon, 21 Sep 2020 08:29:19 -0400 (EDT)
Date:   Mon, 21 Sep 2020 14:29:18 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 02/22] ASoC: sun4i-i2s: Change set_chan_cfg() params
Message-ID: <20200921122918.kzzu623wui277nwr@gilmour.lan>
References: <20200921102731.747736-1-peron.clem@gmail.com>
 <20200921102731.747736-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200921102731.747736-3-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 12:27:11PM +0200, Cl=E9ment P=E9ron wrote:
> As slots and slot_width can be overwritter in case set_tdm() is
> called. Avoid to have this logic in set_chan_cfg().
>=20
> Instead pass the required values as params to set_chan_cfg().

It's not really clear here what the issue is, and how passing the slots
and slot_width as arguments addresses it

> This also fix a bug when i2s->slot_width is set for TDM but not
> properly used in set_chan_cfg().

Which bug?

Also, Fixes tag?

Thanks!
Maxime
