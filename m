Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B532D2740
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgLHJPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:15:47 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1520 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgLHJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:15:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcf441a0000>; Tue, 08 Dec 2020 01:15:06 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Dec
 2020 09:15:04 +0000
Date:   Tue, 8 Dec 2020 11:15:00 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <lulu@redhat.com>,
        <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use write memory barrier after updating CQ
 index
Message-ID: <20201208091500.GA17763@mtl-vdi-166.wap.labs.mlnx>
References: <20201206105719.123753-1-elic@nvidia.com>
 <dd7cde10-2e75-1bd3-68ad-f4988274b37d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dd7cde10-2e75-1bd3-68ad-f4988274b37d@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607418906; bh=dFsq2xs9sTUYZhZViaCLtjhb30g1fDD4Z2bfmBzr46M=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:Content-Transfer-Encoding:
         In-Reply-To:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=Km45oX1nrydEXr3wGp1VEdrwnc4vCj0VFQJQ395jSO4K1aQpvyNEOJdolklVW3hk/
         OGecy/daM70W2QmfW3FmzyNDGC7T8vQfJdA5PB7GJdtisIRkkIRmaocdNmjUCFEgOD
         +T6NGWPUFq2Q5Hh4ml2f9ZOBMTzMiwjqwQayvYhY6WwjKMHebrY7vYqeyeEW7rtTz9
         Hw6B9LM4oJ5sZvIP38I7sfZCMEWZKJM4Wobsvu20DsbGUlQRi29zRDQdKektUvw9QW
         AeCxDp58u9kcP0XNlWpTEb0UtWR0Dszbk7ATf49RlGlqmgHI7MwaPqoZlfzHeXppWs
         V/fJUcaZxO00A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:51:44AM +0800, Jason Wang wrote:
>=20
> On 2020/12/6 =E4=B8=8B=E5=8D=886:57, Eli Cohen wrote:
> > Make sure to put write memory barrier after updating CQ consumer index
> > so the hardware knows that there are available CQE slots in the queue.
> >=20
> > Failure to do this can cause the update of the RX doorbell record to ge=
t
> > updated before the CQ consumer index resulting in CQ overrun.
> >=20
> > Change-Id: Ib0ae4c118cce524c9f492b32569179f3c1f04cc1

Michael, I left this gerrit ID by mistake. Can you remove it before
merging?

> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 dev=
ices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 1f4089c6f9d7..295f46eea2a5 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -478,6 +478,11 @@ static int mlx5_vdpa_poll_one(struct mlx5_vdpa_cq =
*vcq)
> >   static void mlx5_vdpa_handle_completions(struct mlx5_vdpa_virtqueue *=
mvq, int num)
> >   {
> >   	mlx5_cq_set_ci(&mvq->cq.mcq);
> > +
> > +	/* make sure CQ cosumer update is visible to the hardware before upda=
ting
> > +	 * RX doorbell record.
> > +	 */
> > +	wmb();
> >   	rx_post(&mvq->vqqp, num);
> >   	if (mvq->event_cb.callback)
> >   		mvq->event_cb.callback(mvq->event_cb.private);
>=20
>=20
> Acked-by: Jason Wang <jasowang@redhat.com>
>=20
>=20
