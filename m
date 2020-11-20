Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D51B2BAEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgKTPWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:22:36 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50827 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729616AbgKTPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:22:35 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 726DF5C0072;
        Fri, 20 Nov 2020 10:22:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 20 Nov 2020 10:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=5reqwur2UhUxcVOhcDd+nPHvkf/
        Cb9bEyt2nIWUb9UM=; b=CWHZqC1svoEuSzJAtGgqrGf/sQQTqCGemKk0rIDzySu
        zeoeIFTb4YPvgv7F8Y9zjRWDzGv/17H9ZxRPMt2891+T3PQv+N4tqeBaNQ3DH6Yc
        3+T0pC965h9i5bOwqZAK8LoKzT5BmvGOse12TI1UoHzdea4gyCR+UAAXoiF3/GIZ
        C+HqRxx/Lo/EhGN6ohUXl1NdlyGkKIMP8q2JoNyriVoUXHwsJ07IW5CbCJAyALYb
        8zMBhEXAsyfyvQsWqrdIoep78Y0I4/7y3XIwVTGtxGCOXzcSVAflHuwIYur38L10
        Tu9s9n6G1OS8HVo9AU7b8z/3z7Rw53YniB83KPSd1IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5reqwu
        r2UhUxcVOhcDd+nPHvkf/Cb9bEyt2nIWUb9UM=; b=IBSRRtf+kTTT3SFS0v3qiv
        ljTXHp3eUCPjVWIkt4umpcyVCiE+cqQs4SyzANRh42f6FtSvJYEwfevGQSNWU726
        APMmtpx/MbSddYO8TS8YjBzrbjf2CVUsfPZYYnh798oreVGmyC6bJ0Tu5QrYlIgU
        nGU1egqbBOiAPwDLs0b1IM/UxFgXzE60nWd2C4mSZNLL3R0D/ybgvhEYVt/kfL90
        QwjTDOpM78A0xw5v2cNi1k1/pvxwwh/Nf8Mu2p3DOx1gzLTm41/wIu4m8s1GLEwH
        jLCRSZd6qvNNq1RYQuVIih06ALi9kVVqVufHZ78viOx3ChVjaLk1giDJrZnJiBIg
        ==
X-ME-Sender: <xms:Od-3X5WwadH3vayFKjir-Mph_66T24NTQgBq8sAz2dQG2svOzBLWkg>
    <xme:Od-3X5kp-GVt5OCD-UWQAcphT4qp4PTMQ4AzZdB97u-xmyqVEllx-UxQQxfe7EwCD
    CNeYoRGtuz0L0SU4cU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegtddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Od-3X1aEdV6vQALmBZz3AM31MX7TApj0FyYWcBBXgCMsJRva4kws4w>
    <xmx:Od-3X8UIGqWHoon7au9-raIRAOuQjRjWWwHQ9zeIUCvJzdJkra-sMg>
    <xmx:Od-3Xzl-1tevFfjPAVwLO9Q4o9TPpxtWXy3OPnD7GPDdqgSH_6oDTQ>
    <xmx:Ot-3X-suy72L8481MEyCMGwM_EEar3S84Qhormh11bcHjakIneqt3Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18B55328005E;
        Fri, 20 Nov 2020 10:22:33 -0500 (EST)
Date:   Fri, 20 Nov 2020 16:22:31 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH 0/2] clk: sunxi-ng: a64: Remove CPUX mux switching
Message-ID: <20201120152231.2ur2yaz6yuf66mt2@gilmour>
References: <20201109053358.54220-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nqijcl7v223acup3"
Content-Disposition: inline
In-Reply-To: <20201109053358.54220-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nqijcl7v223acup3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2020 at 01:33:56PM +0800, Icenowy Zheng wrote:
> According to Ondrej Jirman, switching of the mux of CPUX clock is one of
> the sources of timer jumps on A64 (and maybe this will also lead to
> timer jump on H3).

Isn't the arch timer supposed to be clocked directly for the 24MHz
crystal? Either way, it would be great to have some explanations on why
this is the source of the timer jumps. It's like the third or fourth
time that claim is made, without completely fixing the issue so far

Maxime

--nqijcl7v223acup3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX7ffNwAKCRDj7w1vZxhR
xbPHAP9hMLMMz5d3lYBeB8EviBVg0A9lP1syML/RvOF71WSN6gEA5cNHkSIbsxEF
9wB8PPlnUb9+ioJvIDUs2GsC9vs4AQ0=
=oyCh
-----END PGP SIGNATURE-----

--nqijcl7v223acup3--
