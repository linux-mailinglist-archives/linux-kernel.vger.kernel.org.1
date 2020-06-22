Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BD2203415
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 11:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFVJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 05:57:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726644AbgFVJ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592819818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J3J1GK/1v24r8R8vBSVjEP1Qqwlwwoh+PJYXVdhCI1A=;
        b=ALwYf9U93nFNEMsz/+Li9soi6lIcwwl7V+ibyrBDfUZpON86oiYk2th0VVVPYJdJAw4/W9
        TXfVHR9fFOTpFVRIGTuoe5ip5GgDUsolp5r8CWesDYS5Od7c+Iw/KguaYFqZRXsxPYH1IU
        qmAozIva87Fc7e1/PpVKq8fvYsBMY4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-mFwUshu-OC2Ov1O5wyre8w-1; Mon, 22 Jun 2020 05:56:56 -0400
X-MC-Unique: mFwUshu-OC2Ov1O5wyre8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C871464;
        Mon, 22 Jun 2020 09:56:54 +0000 (UTC)
Received: from localhost (ovpn-115-184.ams2.redhat.com [10.36.115.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1987F7C1FD;
        Mon, 22 Jun 2020 09:56:50 +0000 (UTC)
Date:   Mon, 22 Jun 2020 10:56:49 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drivers/block: Use kobj_to_dev() API
Message-ID: <20200622095649.GA6675@stefanha-x1.localdomain>
References: <1592618024-28990-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
In-Reply-To: <1592618024-28990-1-git-send-email-wangqing@vivo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 09:53:43AM +0800, Wang Qing wrote:
> Use kobj_to_dev() API instead of container_of().
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7wgGEACgkQnKSrs4Gr
c8jiqwf+NDwvJrqVQacgMbfslm7ctFkXeq127ECemWo6fBJHJ0v01REWrK2Uw9U+
envftxXJjZBtRea5aPUC2NBHfyVQoBuM3q5F2vbmSOOtOv+BHq0oDp16mUqsUD7k
Jg//Y4VKXMFykxC2cHsq1AkyJxUvvU1eLyjs0T6AtbtW7rFysXeT95p7n0bd72ah
G9yxU3htdGZUWygJKbCPYZXM/4uCfZpuiMq0GFdyBNH27aP/XvuD/pRJ4ag5Q9JZ
wq5JtUbs7EqdAGQokCfY0/tk6emgN0MW7GPClOUA0kBcCUoOZivS6/igsjk5FF22
UzBcDoKiDUf2nZhjEPcv1Wqqjkd5xw==
=PUEf
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

