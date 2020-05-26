Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A931A784B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438229AbgDNKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 06:17:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438217AbgDNKRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:17:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A99E6AAFD;
        Tue, 14 Apr 2020 10:17:06 +0000 (UTC)
Message-ID: <f88988c4059799dd21c4c0bf9d13df494eff2c4f.camel@suse.de>
Subject: Re: [PATCH] staging: vc04_services: bcm2835-audio: Make function
 arguments alignment match open parenthesis
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     R Veera Kumar <vkor@vkten.in>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Apr 2020 12:17:05 +0200
In-Reply-To: <20200413165905.6081-1-vkor@vkten.in>
References: <20200413165905.6081-1-vkor@vkten.in>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HvMJdd4MlU6lzP+RDzxu"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HvMJdd4MlU6lzP+RDzxu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-04-13 at 22:29 +0530, R Veera Kumar wrote:
> Make function arguments alignment match open parenthesis.
> Found using checkpatch.pl.
>=20
> Signed-off-by: R Veera Kumar <vkor@vkten.in>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks,
Nicolas


--=-HvMJdd4MlU6lzP+RDzxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6VjaEACgkQlfZmHno8
x/7QNAf+KEkgvllarl1bp7iHEIeawYA2hzu5cIUgBMq3Qn9pI9VDHNI3I8DG4EQb
gOHmJHG635oIvSU3ZVXbgSPRdomFsuXGO7t6te5WdYuhkNVkNyuSuVioOJk6Qdfx
54HT/S9tPICxf3lMZ7ga2JlSDFlHOEtdFEGy7yi6c+miPwkscp1/c6vOxDojOEp1
0Z9iPRSVTGAjKPJOF0Pik1S5cEwowScrdFF2m7Oku0F6ae71sv0eJ+8rZGmqP8Bj
ypzQVcXJYr9pIAGnq/8tRlt4d+IzSSPKxUpTcZZ67RBC/3opTf183ajZGOCTjZd1
CMKcxOYHmJdhwso9ulwPstE+ogLEaA==
=UMAf
-----END PGP SIGNATURE-----

--=-HvMJdd4MlU6lzP+RDzxu--

