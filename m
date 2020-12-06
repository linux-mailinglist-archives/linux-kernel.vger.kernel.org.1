Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080562D015A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 07:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLFGzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 01:55:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16829 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLFGzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 01:55:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcc80230000>; Sat, 05 Dec 2020 22:54:27 -0800
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 6 Dec
 2020 06:54:26 +0000
Date:   Sun, 6 Dec 2020 08:54:22 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201206065422.GA161813@mtl-vdi-166.wap.labs.mlnx>
References: <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
 <20201202165932-mutt-send-email-mst@kernel.org>
 <20201203064928.GA27404@mtl-vdi-166.wap.labs.mlnx>
 <20201203054330-mutt-send-email-mst@kernel.org>
 <20201203120929.GA38007@mtl-vdi-166.wap.labs.mlnx>
 <20201203071414-mutt-send-email-mst@kernel.org>
 <20201203122421.GB38007@mtl-vdi-166.wap.labs.mlnx>
 <b74596fe-fff3-2144-b41a-b9898b6933da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b74596fe-fff3-2144-b41a-b9898b6933da@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607237667; bh=RZ4Klcv7MjQhrlFlFICUWdmtXPcLQdJtQcK1nc/RQJo=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:Content-Transfer-Encoding:
         In-Reply-To:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=WGhbsaYv64TkjEFiy+xCBZahO2JoDGtylJcvuQEKdC/tTyowhPGK7dojaxb46iu+C
         6QFRbINr2wG075TrcSSBFpbKzUsBxgFoezM5qy7t8+YrsGDM/qWS+KlLsrOzsBO/zE
         26fMc6cLqh7ffBLyS2jeCFxgs6/6IW7k9ULRBciyW3yaiDJiXzCJzTPZuHQveXy/TS
         2kTwJbkFBzWFWAFEb28NVVRG6lv4NNO/An7nbMkWG+3S0ojRcOcPca1UOgGmDRCW9i
         jM/NQL27Ps//uIISP9JHcsTKFiSN1lAr15gx0r5hAMa+OuKzfi/dvwWQQHEHExt1lJ
         7uUmJUYpDLm1g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 10:53:28AM +0800, Jason Wang wrote:
>=20
> On 2020/12/3 =E4=B8=8B=E5=8D=888:24, Eli Cohen wrote:
> > > > It is mentioned in Parav's patchset that this will be coming in a
> > > > subsequent patch to his vdpa tool.
> > > So I think kernel has two options:
> > > - require a mac when device is created, we supply it to guest
> > Yes, the driver should always set VIRTIO_NET_F_MAC and provide a MAC -
> > either random or whatever configured using the vdpa too.
>=20
>=20
> A questions here, I think current mlx5 vdpa works for VF only. So I think
> the VF should have a given MAC? If yes, can we use that MAC?
>=20
The MAC assigned to VF is by the NIC implementation. Both ther regular
NIC driver and the VDPA implementation can co-exist so we can't use the
NIC's MAC for VDPA. We want to steer traffic based on its destination
MAC address to either VDPA or regular NIC.
