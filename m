Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55D026DB53
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgIQMSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:18:54 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18975 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgIQMSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:18:44 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:18:43 EDT
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6352bb0002>; Thu, 17 Sep 2020 05:12:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 05:13:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 05:13:26 -0700
Received: from mtl-vdi-166.wap.labs.mlnx (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 12:13:24 +0000
Date:   Thu, 17 Sep 2020 15:13:20 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <lulu@redhat.com>
Subject: [vhost next 0/2] mlx5 vdpa fix netdev status
Message-ID: <20200917121320.GA98085@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600344763; bh=TV630daYKfZVHKy/EjDdlWy6AWFDka0GZ8oSSgf2Eps=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:MIME-Version:
         Content-Type:Content-Disposition:User-Agent:X-Originating-IP:
         X-ClientProxiedBy;
        b=J3OhaB8CSv+4rM7wAKQEkv2B+f23uDFRHwUJe227kZbXDOi30E/08glx/M+QTrrso
         Kv/nKebPA1485mIaXLiHoaaVK8Pg0vzPWSglLTncPI70WTjkzAL0o05cPgczkmucZk
         THYPnPF6J5/V3dvQjnKgiMAtvg2LSp00yDjginenH4qAKzcgVmnqNM+OR/hGW6VxCK
         jNmJ0+B5rPJSV4VtUtqW0cY+8IT045RY/NZ7/3euRBZqb01LJnHpkgYdcjLULekePg
         Z3eIpM2EpcjB08waD4LEXZpodCa0NMU0RUN96KYnm8JswLPY4oF27XtimThHG5X64w
         C5oZyy/QKjnig==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

the following two patches aim to fix a failure to set the vdpa driver
status bit VIRTIO_NET_S_LINK_UP thus causing failure to bring the link
up. I break it to two patches:

1. Introduce proper mlx5 API to set 16 bit status fields per virtio
requirements.
2. Fix the failure to set the bit

Eli Cohen (2):
  vdpa/mlx5: Make use of a specific 16 bit endianness API
  vdpa/mlx5: Fix failure to bring link up

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.27.0

