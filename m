Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3EA29E72E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgJ2JZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:25:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42621 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgJ2JZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:25:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 748F45C009D;
        Thu, 29 Oct 2020 05:25:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Oct 2020 05:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=fORRJP5ZFdVljZT2SOUe6jKO6uX
        rQ3IJS6SChENSYRE=; b=sH9dnPy0ldKgbyIEvtU72dqnwWnWVsN09p/E51ZBrGA
        sAXhTriaihdKWPtjHKiR9RSzr/RLzd5X4FztwsNRl+jLfA8p7WITMAkkD3JS/N7Y
        cl7CIz6R3cu2N7DUqKKclDcGO9JnKudPEVI20f6n9aq3rYcvYx/2Tr7/Igyb8SLf
        oxb0aaHNIxx39wWEnBZQdActLBJ/uXau701UncAWCDcbL7buIpwZCOPDP7mPvyId
        YIjSNPRTwBs5ClKllo/tDOJ6IMhyPvT5L1q6Xjxkpz/yNRwJOZDHAuEbtNwWOgE6
        OivQ9XwI3FRvbCALyNxqztdofRqDTZKiX2BzDd/qN+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fORRJP
        5ZFdVljZT2SOUe6jKO6uXrQ3IJS6SChENSYRE=; b=VubYrucvFt97xjYCPbVFHR
        +8Zgz45o8CI/7BkcJAxn/MTto8P1ar8K4USmbCQGpPiHUJomt0hjPWUWzpFqdJoW
        b1FMUMSXbj4iyPjm8QhJJRU6kFTAnhwwWB6evo/98T3rtbM1yoj3KKXAsNVqsiSt
        Nknn6lp2CzQlV02+SIVkXaRrKSr+Uf6spoeSlj1b3USoKzsmHz0l//d0UdaaLBeo
        yhlkIqfITQd9fFst7OzLiAIkbse7hh0BLrgjpxMaKYUHtDWCvFv7FqmLQ6xRobwz
        N1AJ1H1hMAQ9Lv3oiN+sradEEaHmhLuMQTtRXQOca+WaL96xlPVT8U7S2e8wL7Mg
        ==
X-ME-Sender: <xms:foqaX9GzgRd-U9jaa8fAoA2I1WXM6kDlaim3AjUXu0UTkEVrQ9u4kg>
    <xme:foqaXyVyadQl45LJdkLfp1zXvCJc3vxZIGjkrsZJ50jOgKBoFbskuCf0TZX8ck9va
    SfIUnFBQGa7mrTW6zo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:foqaX_Iv73To4BgIWhhZKJ39UIpexCTaZK_BUIhHw136gKSMkPpsSw>
    <xmx:foqaXzFC5gLJcO1tkoNBmyMeHL3RTwk8eIWrKbLAN_WZILxrgW5Ygg>
    <xmx:foqaXzX58drMQAEoFt8TNILlSoOhODHNZ0ABc92BMcvDEIXyrPb80A>
    <xmx:f4qaX5w8r_3_FLKL5M2Veu8RqvJaFtENaro-R8Lpp6wcgGyF9kCUAw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37114328005D;
        Thu, 29 Oct 2020 05:25:18 -0400 (EDT)
Date:   Thu, 29 Oct 2020 10:25:16 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     joro@8bytes.org, wens@csie.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] iommu/sun50i: check return value of
 of_find_device_by_node() in sun50i_iommu_of_xlate()
Message-ID: <20201029092516.rhhajxzzkwsyvtt5@gilmour.lan>
References: <20201029092244.900564-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g776cgqylgfg6fuc"
Content-Disposition: inline
In-Reply-To: <20201029092244.900564-1-yukuai3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g776cgqylgfg6fuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 05:22:44PM +0800, Yu Kuai wrote:
> If of_find_device_by_node() failed in sun50i_iommu_of_xlate(), null
> pointer dereference will be triggered. Thus return error code if
> of_find_device_by_node() failed.
>=20
> Fixes: 4100b8c229b3("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--g776cgqylgfg6fuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5qKfAAKCRDj7w1vZxhR
xSDRAQCrm1rq32V1f+7In92beYotHM1K7zMBFFZLkZTBEHjtswEAtV1/C0ykkRUj
NNqL+oncLSDng/A8pDUfGcZnykgnxwk=
=tnA6
-----END PGP SIGNATURE-----

--g776cgqylgfg6fuc--
