Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DC52A27BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgKBKHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:07:48 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47783 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728081AbgKBKHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:07:48 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5B1015EC;
        Mon,  2 Nov 2020 05:07:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ksX0oJuNzRG+XdJwYwHrBBw9Tr1
        29EcWdvlrKeW8250=; b=CYWsmIvp6j2RbgNGVHVq1kheu37/iC7efF4scuTR4sW
        JzPo5kyXPjgI0NJ64UwRmDwanoHA5+MgZvWcwah1YyVuqE07pWPBeNWfQQpEn4mr
        TuwZ67W6P7lGIv7t8da7PZl93kBtJSWqQF1SfcCl4JPVkqRUccxw0CLbxbhiyusM
        XYTeCVpaqfTPSs6VCaBwfldFQX7SnnGNFGrBXSmM8ZX4hjX//shLJj27O7jMB4S+
        Jqm9s3mq6fNv3L6adqAQBuqIRXliWCLkN0VqyriyS93qXuDaZb8U/1g9lVpN/aFV
        3n6iLc4lJqr0RR+gBJ5O18s4zLNkT+GK+P4ibgCVfsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ksX0oJ
        uNzRG+XdJwYwHrBBw9Tr129EcWdvlrKeW8250=; b=nfsHu3LV0WraeEsh+QHEIp
        l/A5MQFDdtlbwv7KlGtGkisrYmKzQMNULb7qAJ+7gLRNxxnnQjTinMUUhRB90Puf
        7jrzq9paoLmpwDZAaG7HcWB/Ko7GUNUT2sAjF0QACoELYaybp45pCJwmNulKz7wV
        9WHxhuZcpPCgkrZ+Ug8fSBJUEymTxnY0OTFtxpy5KvXGw7Zrid2iJxzW7TxgcW/7
        MsqGWzHIG1XtmywZxcD9ysgeA8wIDSKZyi3pDDba0uxBc5sSFg0uGH6M53xMibgH
        ZmmiEw0npzg4e13DXPg9d4SToXjnmgLrCiFY4NDwrDAHzN1v/5ogFDWhH/lnYp7g
        ==
X-ME-Sender: <xms:ctqfX4f-0H4dcGo1C54v2r8yNfOdQVgfxE6lk-KfBc1Qjvw1NJEmFA>
    <xme:ctqfX6PFE8KYbtPci6YYFRJIBPAR2ODKg7Zh0hjaD9TVYfMbt3M8V6cJwdXVL7PyZ
    H8FHhKSP44E8z-CoJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ctqfX5jwn-lGGH_tKtEYvArOBguXdTYY2m1e-ijcOLJEPSqaRWNN-g>
    <xmx:ctqfX99sRQzTSFEGO0tlEutjfJ1FH-wE5xWOmxI0xyAQUA_KQLeC-g>
    <xmx:ctqfX0t5N5WH1AjaeehXRcFAJXiMMumJcKzacrTqYJOAq2ReQCo_2w>
    <xmx:ctqfX95EHopwnzPF_J4kjThwN8GYfAtCVHYTsyMJ8wFvAIMy7HybQw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80355306468B;
        Mon,  2 Nov 2020 05:07:46 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:07:45 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] ARM: dts: sunxi: align pinecube compatible
 property to other S3 boards
Message-ID: <20201102100745.gloe4j63cwisbhhm@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201030234325.5865-7-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4t5eww6pjmgjfel6"
Content-Disposition: inline
In-Reply-To: <20201030234325.5865-7-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4t5eww6pjmgjfel6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 11:43:25PM +0000, Matteo Scordino wrote:
> The compatible string in the Pine64 Pincube dts diverges from the ones
> used in other S3 based boards, like the LicheePi and the Elimo Impetus
> and Initium. Discussion on LKML decided the PineCube should align to the
> others.
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-s3-pinecube.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-s3-pinecube.dts b/arch/arm/boot/dts/=
sun8i-s3-pinecube.dts
> index 9bab6b7f4014..4aa0ee897a0a 100644
> --- a/arch/arm/boot/dts/sun8i-s3-pinecube.dts
> +++ b/arch/arm/boot/dts/sun8i-s3-pinecube.dts
> @@ -10,7 +10,7 @@
> =20
>  / {
>  	model =3D "PineCube IP Camera";
> -	compatible =3D "pine64,pinecube", "allwinner,sun8i-s3";
> +	compatible =3D "pine64,pinecube", "sochip,s3", "allwinner,sun8i-v3";

I've applied it with the prefix changed a little, and s/Pincube/Pinecube/ i=
n the commit log.

Maxime

--4t5eww6pjmgjfel6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/acQAKCRDj7w1vZxhR
xX0lAQDczW23QXNN532ys0KyARoRvDttMvH5TV3UnQqgI5WnIQD8DAq6gEW6RArz
Qm+ubfz2FErCRi09LF0Vu/XgDGh52w8=
=nYxL
-----END PGP SIGNATURE-----

--4t5eww6pjmgjfel6--
