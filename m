Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF762B5E38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgKQL1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbgKQL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605612431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A2JFewxKry8whthCDMxr2NfywJCIm21teU8xW5CsAu4=;
        b=RxzUfkWuMotLg6h+qeMue96ogf6CvFnI+i3I12u7NTyr6GR2xB4Fyu4N8A0JhA573K+Tq/
        uNrMsth1GqoV3PSPbrmMW1Aalw6p12U1bxX5KqR3/GlzuBdGAxqQiBnNGpNigXtCTaApqY
        sfqZtAxdoH4H/ZlO2M66dnKiBNBWjDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-JskOsdioPQGvNIKGQgGEBQ-1; Tue, 17 Nov 2020 06:27:09 -0500
X-MC-Unique: JskOsdioPQGvNIKGQgGEBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 190D284639C;
        Tue, 17 Nov 2020 11:27:08 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB3BC10013D0;
        Tue, 17 Nov 2020 11:27:04 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:27:03 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 10/12] vdpa_sim: split vdpasim_virtqueue's iov field
 in riov and wiov
Message-ID: <20201117112703.GF131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-11-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-11-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 02:47:10PM +0100, Stefano Garzarella wrote:
> vringh_getdesc_iotlb() manages 2 iovs for writable and readable
> descriptors. This is very useful for the block device, where for
> each request we have both types of descriptor.
>=20
> Let's split the vdpasim_virtqueue's iov field in riov and wiov
> to use them with vringh_getdesc_iotlb().

Is riov/wiov naming common? VIRTIO uses "in" (device-to-driver) and
"out" (driver-to-device). Using VIRTIO terminology might be clearer.

Stefan

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zs4cACgkQnKSrs4Gr
c8gyXQf/ZimGDuF+KQ6wdqffxElUTSDfmEi9aKo+s0ffWcLS2VRhi2BrEplJZCkF
/e2hIuJt+kVvvSuXHWaIwtK25DSyVpFjo2TvV9DeYz5tnB8O+LPArPneLLThCqnF
56EE7/utit0+PmFCTn+gmhGCZh6uzfYcIv702qtuQ6UHhbcAZFETgidYhp+fbFsv
5NhbNG+rZZzWVzW4YU/UaDe69qY/YuHFHGmH+ekAG8WuBzd9IVCcvFwDZa6VccIL
ezMgtfIHKO0CSQpjlA6tMU9L7A/Vc+49e3oYtif4m+7DwjtpENk7KEOX8Wsp4ikG
pxGcS3eDQXYxDl1HduDoG5jb3Bzz/g==
=w7yP
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--

