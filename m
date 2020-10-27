Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9422C29BA01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1803740AbgJ0PxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:53:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36741 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759218AbgJ0P1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:27:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F06E5C012E;
        Tue, 27 Oct 2020 11:27:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Oct 2020 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=hvOE926BMwRPcVsTY7vA6vM+v5v
        qveqiHwZTJuprkG0=; b=mEpre88K4kz8UV7+hA0J9G6Rg0SQ6owSBrcwW4KrhL1
        dZaXHFCHYji6mc1XwlisKdTk4cFVM65/co9xWCPgyEmxcj9wqri0uFAeWGeRL1gu
        MxhkvviBV6OsR5Oa5EGtvdpCCRZDB6LQrKFqoQimW68Z+AcEiXaqz2ddOUDEvudf
        EUSU5AL2TDfW9bgUp5cbaYvwe3gwt9JOpvifaEeRSnc6zzXOAHn0lhosP72GSdM0
        V18Cc+RR2tevaCpe+dePeyt55qvfkYc/fwi6CBBVVIR9AKnhb9CxYqYWmWovCLzP
        HKUGApzjQIGiE4av9LLKelSWgY9rJ66Rp9fE18jRvAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hvOE92
        6BMwRPcVsTY7vA6vM+v5vqveqiHwZTJuprkG0=; b=J53JRrOOwiS16aoL+sVD+V
        /fJzW1shFRFYxoWtDyf26CgeMGkAtELM5U2aTrEIRX5+wSugMNeRkwWQ7kxRDlcW
        EzivdPmhK4XjmjA0MnHp1xQk5Qq45YTLMW4EnFV2RyviORgHtRDjOlcT5z8wDpE0
        UGFFv2RUfMCHhZ0mGJIwCpf4GWl+ZqYtLGw9mqwdmmvIqvkJeNFFaY/nXqfvyOCq
        3f+EbCGJVcfAdoqRYt+Goxbut7kLtutEpXqiMd8n9AciLTVIgqI3+gorPwieURTs
        9JPcPM0vsfw3L2xUydFw2s2vSKWpadYiveKLtBeRyrzN0w7iH64XbqyXCatAPMdg
        ==
X-ME-Sender: <xms:dTyYX0WoW_5K7pLJiBhktXq-BZVa7vR2-wh6uvc79IgLJewDBVZLKA>
    <xme:dTyYX4m_xuMVmbDWZQBz4sx-JOzxWjUWUZltaS-Dzp_uYtLKLB230ceaM0wQnx1RE
    ce7drB2B8faRV4PUik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:dTyYX4b7YOPVre4ydSrk0rOtmwU3NHpYHuEXTNFDMIwKbGE4GLGkIA>
    <xmx:dTyYXzXosEpU_II8kpfNzpBrgkEEvGdO5kpbLX1fFGoKLNu7XVJvDQ>
    <xmx:dTyYX-lAEgGEvfWNxt-Nhxgp1czeGqLwXRPyiyx74VYlq73NjZKEBQ>
    <xmx:djyYXwiFBumfuHJrODzJL-FOVqwATCMGmqIvew1rXkP9eYPhAGARdw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A240328005A;
        Tue, 27 Oct 2020 11:27:49 -0400 (EDT)
Date:   Tue, 27 Oct 2020 16:27:47 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: zeropi: remove useless pinctrl
 properties
Message-ID: <20201027152747.ohedeqklzz6np3io@gilmour.lan>
References: <20201027101258.18094-1-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6k5mw3tnqf6affyj"
Content-Disposition: inline
In-Reply-To: <20201027101258.18094-1-mtwget@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6k5mw3tnqf6affyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2020 at 06:12:58PM +0800, Yu-Tung Chang wrote:
> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>

Ah so it was to fix the build breakage in next. I've squashed it into
your previous patch.

Generally speaking though, a commit log is needed

Thanks!
Maxime

--6k5mw3tnqf6affyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5g8cwAKCRDj7w1vZxhR
xeLuAP96ocT+YPjTN3Ps4JreHt8/HEJKBCFS+6To8l6Rhw7QXAEA7iVgW7ius5eN
u/hFixJJh1VqxmwzmV8Q1u8r8/s6PQY=
=Hd/R
-----END PGP SIGNATURE-----

--6k5mw3tnqf6affyj--
