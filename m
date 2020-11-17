Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8D12B5E77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgKQLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:36:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbgKQLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605613005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ojbyE0PcDtW26NIEQPg/SaNisXd9lAY9pA+BqplcSlc=;
        b=RiuWGSr0oqnj8skx6zZpRfGSw8VprJvT/nqbx8EF5ElHwDVazoQqJEPvahuXXTP8PEDXVT
        eeYKX9gOERN4lxB3B/jzrlyOKLFQ6caGPLWnz5xT59D/hWBFvM2CZHmcGT4vxDgEnjrNVN
        bvvjY+KiHTv1Hs6am8FdqL9nuYMYRsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-XjfEPL-VPQumwALw6W0xUg-1; Tue, 17 Nov 2020 06:36:43 -0500
X-MC-Unique: XjfEPL-VPQumwALw6W0xUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA4501084C8B;
        Tue, 17 Nov 2020 11:36:41 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D41295C1D0;
        Tue, 17 Nov 2020 11:36:37 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:36:36 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201117113636.GG131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-13-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NPukt5Otb9an/u20"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NPukt5Otb9an/u20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 02:47:12PM +0100, Stefano Garzarella wrote:
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index 8e41b3ab98d5..68e74383322f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/module.h>
> +#include <linux/blkdev.h>
>  #include <uapi/linux/virtio_blk.h>
> =20
>  #include "vdpa_sim.h"
> @@ -24,10 +25,137 @@
> =20
>  static struct vdpasim *vdpasim_blk_dev;
> =20
> +static int vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> +=09=09=09=09  struct vdpasim_virtqueue *vq)

This function has a non-standard int return value. Please document it.

> +{
> +=09size_t wrote =3D 0, to_read =3D 0, to_write =3D 0;
> +=09struct virtio_blk_outhdr hdr;
> +=09uint8_t status;
> +=09uint32_t type;
> +=09ssize_t bytes;
> +=09loff_t offset;
> +=09int i, ret;
> +
> +=09vringh_kiov_cleanup(&vq->riov);
> +=09vringh_kiov_cleanup(&vq->wiov);
> +
> +=09ret =3D vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
> +=09=09=09=09   &vq->head, GFP_ATOMIC);
> +=09if (ret !=3D 1)
> +=09=09return ret;
> +
> +=09for (i =3D 0; i < vq->wiov.used; i++)
> +=09=09to_write +=3D vq->wiov.iov[i].iov_len;
> +=09to_write -=3D 1; /* last byte is the status */

What if vq->wiov.used =3D=3D 0?

> +
> +=09for (i =3D 0; i < vq->riov.used; i++)
> +=09=09to_read +=3D vq->riov.iov[i].iov_len;
> +
> +=09bytes =3D vringh_iov_pull_iotlb(&vq->vring, &vq->riov, &hdr, sizeof(h=
dr));
> +=09if (bytes !=3D sizeof(hdr))
> +=09=09return 0;
> +
> +=09to_read -=3D bytes;
> +
> +=09type =3D le32_to_cpu(hdr.type);
> +=09offset =3D le64_to_cpu(hdr.sector) << SECTOR_SHIFT;
> +=09status =3D VIRTIO_BLK_S_OK;
> +
> +=09switch (type) {
> +=09case VIRTIO_BLK_T_IN:
> +=09=09if (offset + to_write > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {

Integer overflow is not handled.

--NPukt5Otb9an/u20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ztcQACgkQnKSrs4Gr
c8iolAgApTBD1PaVo9UuMIiHwUOHDFHckP5/xzilctMNmZYAzMd60k7GRTsYu0z2
eTkPw8Ik1Z5PXqgtSa8w2alDtWE7kJV6x2K+D4Xs3Y4miArXfd8NlozeFYsJCScf
b37DkWKR7sXDLWv/ITGqH5M+HjT6hIbXA4hrOtrUsF9S07OfzwwS7T0HmBxreiom
IUaloJ95O+c8WzhlHzoyxJeC/MSV4wPyivmuJZ6FzrtPMvPhAJwjWa5Xark5s3bM
A9iDFP1eikLSn0zrn03cWy7FzA14QAyO/Ppnv0sllpLDLWx5flHXnyQRIZx74JNh
yuLDV+JjZJroWZYLpKPWdZQ+xoQ/Fw==
=TgK+
-----END PGP SIGNATURE-----

--NPukt5Otb9an/u20--

