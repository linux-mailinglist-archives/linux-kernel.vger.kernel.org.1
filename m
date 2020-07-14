Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38EF21EF80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGNLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 07:40:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:38966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgGNLkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:40:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2425AF36;
        Tue, 14 Jul 2020 11:40:06 +0000 (UTC)
Message-ID: <809a3445c6fdbc2dfc0ea00097157bce61ccd5ea.camel@suse.de>
Subject: Re: [PATCH 3/4] dma-pool: Introduce dma_guess_pool()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2020 13:40:01 +0200
In-Reply-To: <20200714112208.GA18261@lst.de>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de>
         <20200709161903.26229-4-nsaenzjulienne@suse.de>
         <20200714112208.GA18261@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jtA8Pvm/q46e3P8cNpns"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jtA8Pvm/q46e3P8cNpns
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-07-14 at 13:22 +0200, Christoph Hellwig wrote:
> This one doesn't appear to actually apply on top of Linus' tree plus the
> two previous patches.

I'll take care of it.


--=-jtA8Pvm/q46e3P8cNpns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8NmZEACgkQlfZmHno8
x/67vgf/S8THsKAgGwIlTRp0AyhSbdCLurjEs05omCC23BcU290BbvGjT1aaYB31
+sO2IbjDIv7EsH/DN4LeiAwJHagCrw8NlEdwSmreJDRdGhCgFaXfCwRBOtK5TXsr
zPrTK//uac3ZdJjrBt76k3ww247ff5lfAuXcXzaemRRPlYk/tM9j6XrONBNtU2Tn
snSlA798GKc5yS77daiyp8Fkb50px6aMj8YW8nQEcInDcUDiVZ7y8mwfojBWZKez
IH48qHWxEEojTBooK2dLlLkhRWAtPLhj8G8CeKFHZh//Zbp5SCuGsQKREh7eRulG
psgvv6ahP0v7UW4NngAQ9Gu3Nz5VTw==
=Yb8P
-----END PGP SIGNATURE-----

--=-jtA8Pvm/q46e3P8cNpns--

