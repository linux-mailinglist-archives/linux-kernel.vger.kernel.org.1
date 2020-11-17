Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2312B5E2F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgKQLXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:23:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgKQLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605612193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dS7znSw5g8o6/lg1YdPszQ5ItVhBgNxvcUYvJULhaMY=;
        b=I/jQYD/ll5TIUkhTxkdraObx9SYb+K2cojc4Ov5noQd5BtbO6Y/Y1DHjkI1j25HOVZuyLk
        3x3NDgk16uhIafGxLlMZcScU93JKb2j9hsjtx5NxFrsBQkhz49Wao02viOF4FoIGdLdP1E
        zKDurfngeK+b+uBlWqigTcgom52pChk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-6aTCZUfEMembvr5360JvOA-1; Tue, 17 Nov 2020 06:23:11 -0500
X-MC-Unique: 6aTCZUfEMembvr5360JvOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8FC68030C5;
        Tue, 17 Nov 2020 11:23:09 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79BA419C78;
        Tue, 17 Nov 2020 11:23:06 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:23:05 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 06/12] vdpa_sim: add struct vdpasim_device to store
 device properties
Message-ID: <20201117112305.GE131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-7-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-7-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 02:47:06PM +0100, Stefano Garzarella wrote:
> Move device properties used during the entire life cycle in a new
> structure to simplify the copy of these fields during the vdpasim
> initialization.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 17 ++++++++------
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 33 ++++++++++++++--------------
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  8 +++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  9 +++++---
>  4 files changed, 38 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdp=
a_sim.h
> index 6a1267c40d5e..76e642042eb0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -40,12 +40,17 @@ struct vdpasim_virtqueue {
>  =09irqreturn_t (*cb)(void *data);
>  };
> =20
> +struct vdpasim_device {
> +=09u64 supported_features;
> +=09u32 id;
> +=09int nvqs;
> +};
> +
>  struct vdpasim_init_attr {
> -=09u32=09=09device_id;
> -=09u64=09=09features;
> +=09struct vdpasim_device device;

It's unclear to me what the exact purpose of struct vdpasim_device is.
At least the name reminds me of struct device, which this is not.

Should this be called just struct vdpasim_attr or struct
vdpasim_dev_attr? In other words, the attributes that are needed even
after intialization?

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zspkACgkQnKSrs4Gr
c8gFPwf9EKotDJQ7Se2GaXlaY0nCpGIeqdUBQaX5Et7tpXyDxXzsIKTYIfqAsqU1
Ww4kBfcM9jPqPjLZSdlMLdWqysoQ0teBSSNuCcb+uOC3O9N9c4eh3o7lO1SQpvya
OSfsYqw8bDmohwhxKYPTpjbM5fxcO7HiKrneufqBnSgJcubmQt7nJkCWNX+73r/g
xn4baxIxEAWEWFrBLeDtKfVBr/kk9dj6uXSMKMvWIwFibGN1b36n555O5sd8MenZ
iT4SJJuKdfQZE4vj743dAR7F8qyVYBHYyvEieRXZN4qAz5bEAPnmULAlYTzlJUh/
vpYRvzcmyXImaHN+a+uRHcG+7lJSEA==
=VNtu
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--

