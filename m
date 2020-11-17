Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283532B5E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgKQLLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727214AbgKQLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605611489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ITDbJ5FeObPmxp9jb5MtpoVUKiHieLkWbG48UC2H4M=;
        b=WZPzW8lfkigKn26Ysd147LCgTsi1UFrG+JttTvOQq4lIgCg3bAORa+os/wMNLU/uM+SrPe
        TNrrwdnSXGGZ7qojJ/E0PuxNREujgIAi+x6bohfXsbXq1vUzXJwGNG6fdO4r5w7Y0ZOmNK
        Pq46E/o/yHj6ivg+7vk30aRdTYQDsBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-7tS0sVaAN0awBuS74jjcyg-1; Tue, 17 Nov 2020 06:11:26 -0500
X-MC-Unique: 7tS0sVaAN0awBuS74jjcyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8561802B61;
        Tue, 17 Nov 2020 11:11:25 +0000 (UTC)
Received: from localhost (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 468555D707;
        Tue, 17 Nov 2020 11:11:22 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:11:21 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201117111121.GD131917@stefanha-x1.localdomain>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-5-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2020 at 02:47:04PM +0100, Stefano Garzarella wrote:
> +static void vdpasim_blk_work(struct work_struct *work)
> +{
> +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> +	u8 status = VIRTIO_BLK_S_OK;
> +	int i;
> +
> +	spin_lock(&vdpasim->lock);
> +
> +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto out;
> +
> +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
> +
> +		if (!vq->ready)
> +			continue;
> +
> +		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
> +					    &vq->head, GFP_ATOMIC) > 0) {
> +
> +			int write;
> +
> +			vq->iov.i = vq->iov.used - 1;
> +			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
> +			if (write <= 0)
> +				break;

We're lucky the guest driver doesn't crash after VIRTIO_BLK_T_GET_ID? :)

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+zr9kACgkQnKSrs4Gr
c8iPWQgAum2Wx+ML7CwyIMXTLzRGqriW1/Z2uu/EQd5+DN1mh1OwzeQx+lyRC/I/
ateKy1MSPp6uXbOBPcjwNjoO/i9rpgMAv5k+T7zsCYjGYyUksR3+uyipbDo11qsW
FRkBsxyffjMmQupvEVoDj125ACqgtc8uajpbU9qdwGeDSEDiGWf4yuma1Jo9speI
VNH6UL4lmffCVhz1c385SW9L6oi0wVYBQlECdkKadgZsTWW3vN5sufKW53/8MHod
MTnf85IqyDbRMMVcXR5nD/B577+04gmSjauzHpIg9iDXDG35zgB6Uk4tV+wv9XA7
RuZaCUywt6pKH9zkeO4+Kcpxd6h4jw==
=58Zf
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--

