Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631E42F72EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbhAOGd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:33:28 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35615 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbhAOGd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:33:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CEBB5C00B6;
        Fri, 15 Jan 2021 01:32:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Jan 2021 01:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=xpEsxA6y9Y1w5nIkSqkW6j0h0Zy
        NX6ec0RTZZ5uLIaY=; b=CY6qIxybOucn3pm5uIh8KIft3iJrkcD07rGWduyDsxn
        1Lwv/E9Va1lni5Q5dfa7nI5WAxTfijP2beAz9ktUjnPrG7d0WSOg2w81677sW8OC
        By6QbiOXwf9FStEbtWUuGF21Enqx0b4Pa+EEcumRm+FhqkpDZn07FxVhqiunExHA
        neLraoaM8Y4kukvSnF738ssUKo7O9doag7yMbaEco7iWPSXOE53DUSslsSbkbZFU
        jR/RaAfBZy/QS7UuNCrOakv74TlgIA+kOWC4gPg0TKDWozsqWGHhJV9Jv7nX65nq
        fjuX6a9doAMVjG25XWuWPuEX3EZKKq7c59GnQmYAkjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xpEsxA
        6y9Y1w5nIkSqkW6j0h0ZyNX6ec0RTZZ5uLIaY=; b=SKuTbMH4rjZArVPxPK6uk+
        y25jqUzeYOd3OEviSfbwUv5g4BRY16SzkyKBQ/eAWmmREr8Jp/3xrRayGxhL/XIa
        9BTr+oHKAhVAHEaVDRMZCZlhn5vFEGUrC3hmW42gphSjcrzIiqvKWSytfaL0N2zl
        WsHRyS72jKxuZ4y3yonQW7yGW07GsSYRLOqIjNpSQM/+p+pvLZzQniOb+Bi3HAxV
        PVDB3GIrbnuhZ5T/kWAZvKJDO85duFY9ELdS9EOpTI/vE1yIi3Gc0i4S9s7w8ulS
        /K+ipfRQO8RUziMZ/xHmAZWqZzl9aGQdUW7a1VGu5/TNn5e+cw6VcOj8Z+qvh72A
        ==
X-ME-Sender: <xms:9DYBYEijSVYR-S5mIYHvE_hrpIHbyN74ENvUsq1tLM9UuV6zec6SfQ>
    <xme:9DYBYNBRYyT9JOsLU7eUmn9-pIDTYR7iEeHfKWvsWeuXdyyOMLepe8LKbdXSISrb8
    u9iUbA1neU5tXTJjfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddugdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
    lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
    hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
    necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:9DYBYMEN63wEIKVcGXOW9Myd4A02iVMu-KUgi9ANFWqIqbwTW2CLSA>
    <xmx:9DYBYFStP6_Iu-D5ABdAYkNVoWJ1qzaJkqfOeyKqz4rFKH3AWqucCg>
    <xmx:9DYBYBwJirHy8jGQZVs4IYXxjuFM_gg7II0tokIgZaVgTiyzbMjoSQ>
    <xmx:9TYBYEre-4v2S59bOR4niEbVezqw3bg4PNX5ANWHGodeMoJoBnfY8w>
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by mail.messagingengine.com (Postfix) with ESMTPA id C7FCA240057;
        Fri, 15 Jan 2021 01:32:19 -0500 (EST)
Date:   Fri, 15 Jan 2021 07:32:18 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Klaus Jensen <k.jensen@samsung.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: allow use of cmb on v1.4 controllers
Message-ID: <YAE28i5Aq0U40fPB@apples.localdomain>
References: <20210115063046.274495-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1U8gbzxJNV82M3VG"
Content-Disposition: inline
In-Reply-To: <20210115063046.274495-1-its@irrelevant.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1U8gbzxJNV82M3VG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 15 07:30, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Since NVMe v1.4 the Controller Memory Buffer must be explicitly enabled
> by the host.
>=20

Sorry, messed up and missed adding the changes for v2.

v2:
  - Do not explicitly check the NVMe version, rely on the presence of
    the new register instead. (Christoph)
  - Use hi_lo_writeq. (Christoph, Keith)
  - Fix missing offset and use pci_bus_address(). (Keith)

--1U8gbzxJNV82M3VG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmABNuwACgkQTeGvMW1P
DelOBggAsOWPWqP1jQiNj9M5TyKKmCMZXVgMRiAyHX0NIXPQJYePYleMU572MNvQ
HJai6Z0+YpnRZCG6XAmHSj61pJ/jum64DSBwRmVMAIjYyv6r/4n56XvP4QobIr9J
cTQ+HN89ueW77SzLgDDwsAplW+9l/siY4o5UDJE1RIXnVpy/HSoyV1hWrQD1hFze
41G5/O9MAx8srSpGbO90tmY/eZ4EvrI8S4AY/2D/CX/ElOkodJsf9PM7qHz/I0Ly
lrneSiU34OhvufoFunmWcN0OWQowHqHLr4Jpm/RxAgJG8ucaB0WlUuMzMdx0VFI0
KVmU3V/zt54k0UAwJy2jYcXY7WXkNA==
=zs9f
-----END PGP SIGNATURE-----

--1U8gbzxJNV82M3VG--
