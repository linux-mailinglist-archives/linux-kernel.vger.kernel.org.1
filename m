Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F42EC14A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhAFQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:36:41 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49185 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbhAFQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:36:40 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FE9F5C0108;
        Wed,  6 Jan 2021 11:35:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Jan 2021 11:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=wYwESHTQ+y8mpfRTdygkc8t4ZkZ
        rdqT3MfHsCVCaE8w=; b=u0b6bdBbiRa6/8+PyeLAOhNMSi6A1ZM3lW1GHlChmTY
        9b9GHSpGa1FSohsbSHca+8tKpgtFGSKLgFtmQ46MwV9JNNhjCUHe/2qc2d8Nd7ls
        1JWeJw2E0xnDNR8WxfP4O+IRWo3fYgBfoa33YxlNID7noWnoYxOQUt8+Hqfb1NGa
        ur+rvZm0L8I635EsjwljwKffQjEHboXNH4R1V8xO5niaQclo7l86Iij2mKxnqyc/
        zqk8J8jy4YNU/TKx2M5gGD0dzDR/eQ3llb0jHJi5xyBcvMSk2ZHTpAgM88gkhDwf
        j1IfhnxwgIRJVfYjG8kMI1sCZncnmW31EvE933wW14A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wYwESH
        TQ+y8mpfRTdygkc8t4ZkZrdqT3MfHsCVCaE8w=; b=fpnzNfDur95VG8fxH4PvNr
        to8ogQxr8s0zrNiZMy807P3ojbzQh0q3bBjVujLbtzMb7sy5Y9iEckLhWwM2ifaO
        CcAIzrL8akcfKITo30Yeuq9GiBn2LlFPDDJuPNea8betymmRsaTiBl+Z0P5LGZcp
        LpR5nx2BkoEtuWq2ay9WZcmx9lBFkDLRGdW/AlZrvmlm3OYpkprLR600MIUDdCLm
        NJGEvBYH62b0WNHUOs0NKe5FbJnsThVXgzl6fQ6Y6PPfjowHMu3MmEKGgXphoZKU
        4tQo3bC9GHNQ5qJYeAQs02OuGCKnCSCNScdF8QreeQqw8mVy6II3W/W30LQNWYSg
        ==
X-ME-Sender: <xms:6Ob1X8Ff_S6HS3wPbhZwGOzxbkU7yh1g2S0r5T2QjsS0YUEiMYeIcg>
    <xme:6Ob1X25og3yfhqZx_14GokXkTuyDnCIIOoboMUxCHMEJTWkaFK3gFdlisa76oCBc0
    Owpwu1cv1YVzBVZh8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegtdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhho
    rdhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehfffgie
    ejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
    gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6Ob1X1bhuAPmLLkVNJnDnlVM48pYCKo8VGDzRjAxZiJB4OhniMx4jw>
    <xmx:6Ob1X0gHcioT8AyKTlMUsTOXIeZMr9rxRGO0feFC-QIxx-k_jCFrEg>
    <xmx:6Ob1X3fXEHXaCz4ddVawozbQghd-6L6qtrdMpYhu0y6fc-SFawQIQQ>
    <xmx:6ub1X-6oZmyOw2VuZGCjaZnChTy-TOKbLpCoSbJ8alwvyAfcV7cvwA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95502240064;
        Wed,  6 Jan 2021 11:35:52 -0500 (EST)
Date:   Wed, 6 Jan 2021 17:35:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: sun50i-a64-pinephone: add 'pine64,
 pinephone' to the compatible list
Message-ID: <20210106163551.pjaxvxgxms333ieq@gilmour>
References: <20201230104205.5592-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="elgx7cag4glaquyq"
Content-Disposition: inline
In-Reply-To: <20201230104205.5592-1-me@dylanvanassche.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--elgx7cag4glaquyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 11:42:05AM +0100, Dylan Van Assche wrote:
> All revisions of the PinePhone share most of the hardware.
> This patch makes it easier to detect PinePhone hardware without
> having to check for each possible revision.
>=20
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>

Applied, thanks
Maxime

--elgx7cag4glaquyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/Xm5wAKCRDj7w1vZxhR
xS5+APwLU8fQcZwlNRrq2m5oc+XxWYAjpQSCwiUComFYplSQNgD/cKv/nJ9gBIpG
/hexRC8+G5bOy5Mly5659job5gMr2gg=
=H1Ex
-----END PGP SIGNATURE-----

--elgx7cag4glaquyq--
