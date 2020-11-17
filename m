Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF012B5DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgKQK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:57:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727928AbgKQK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605610638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sef5YC7ElT0CPIu8Xi0KQIpgG9At4z3nHnONcWlaT6I=;
        b=Bm6Q8IJrjOU0k5kViYBmlnx9Sawci0GMjJr8fskqTLRZGvZguaTLpubNiTjhPoUeAJwjYA
        XPVfnBT2xv39WLxg9/WSlgscHL1LVIfh+igV3gV+9vlI6hnggI3T19YBnLewjUQV4MFHyD
        DsjLkZQqT9QauxxR8RrFCtF8lwpcExc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-CLA16zfPMwG3lzZ5nu0hvg-1; Tue, 17 Nov 2020 05:57:15 -0500
X-MC-Unique: CLA16zfPMwG3lzZ5nu0hvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A255B8030BD;
        Tue, 17 Nov 2020 10:57:14 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16B645B4AA;
        Tue, 17 Nov 2020 10:57:10 +0000 (UTC)
Date:   Tue, 17 Nov 2020 10:57:09 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 01/12] vhost-vdpa: add support for vDPA blk devices
Message-ID: <20201117105709.GC131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-2-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-2-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 02:47:01PM +0100, Stefano Garzarella wrote:
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 2754f3069738..fb0411594963 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -22,6 +22,7 @@
>  #include <linux/nospec.h>
>  #include <linux/vhost.h>
>  #include <linux/virtio_net.h>
> +#include <linux/virtio_blk.h>
> =20
>  #include "vhost.h"
> =20
> @@ -194,6 +195,9 @@ static int vhost_vdpa_config_validate(struct vhost_vd=
pa *v,
>  =09case VIRTIO_ID_NET:
>  =09=09size =3D sizeof(struct virtio_net_config);
>  =09=09break;
> +=09case VIRTIO_ID_BLOCK:
> +=09=09size =3D sizeof(struct virtio_blk_config);
> +=09=09break;
>  =09}
> =20
>  =09if (c->len =3D=3D 0)

Can vdpa_config_ops->get/set_config() handle the size check instead of
hardcoding device-specific knowledge into drivers/vhost/vdpa.c?

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zrIUACgkQnKSrs4Gr
c8gvowf/Wpwi/uMVifoS0NwyRCe5/CVH7tVJdmGYKpQ0EOCpn9vsgvZ+nD+xnnf5
6X8eiwurchLDat2lMMlWEupsa4ThfFqlLeRIvoGzlIhyc0bJfS3BfhAF+K/dFYhb
UtOzecblfCtEbcTb2wNicHsz3M1wdxW8T04y0vD8vxQRJN3SFvUqa6fxToU9Z4ji
np403zzsVijvNfZf1c204D5oUBr9OR8TXJldXrGPXdp0yTglBi6ZLeicuCiN6Mr5
RHES2SztSo5XrXAoIgI/JZsKgFWCCnYdpJxOt+WUuJVH5PyxhX+57fDLQxZiOXF0
7TVh+myYaXRw0joEJZuSu/zKU0uGzQ==
=Mbol
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

