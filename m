Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D512020448C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 01:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgFVXj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 19:39:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18846 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgFVXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:39:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef140cc0000>; Mon, 22 Jun 2020 16:37:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 16:39:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 16:39:19 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 23:39:09 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 22 Jun 2020 23:39:09 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef1411c0004>; Mon, 22 Jun 2020 16:39:09 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [RESEND PATCH 0/3] nouveau: fixes for SVM
Date:   Mon, 22 Jun 2020 16:38:51 -0700
Message-ID: <20200622233854.10889-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592869068; bh=3+JCLyZE1OpqsNZIQQX5Dapnb/sVr1kQHRfm+bmM/qI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=kzixr8lqLvDysmZK4S9/RHRATrbqfgRx6qAibDxoItencKNjTAmEXdsCeayZR6ObG
         t8VRXYsVePr8FSTSMa0Laea5FC4I4XxAqHK6BunPMmQi/gNOH1unRiwEUx/RBAdyCr
         N4+kqMK0UZH5orr84HaIpPMg7ZiSdWu6fzj3ByiHYy60AspCo3w9YvJlky/lrqfvHT
         CHnWXuHAVP2zc4eSRy9QQFALB9yqi1o0sivI3EGgeoBvHLDih9qVv/0YkbgprVAeGL
         Ziq5M2GaXzW/shX8M1O+6gfaVxiMtIYP4Ev8OiOQ8OPbYv5bglzEFCmQ4L4ELgctqi
         9WDc3eAYVorDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are based on 5.8.0-rc2 and intended for Ben Skeggs' nouveau tree.
I believe the changes can be queued for 5.8-rcX after being reviewed.
These were part of a larger series but I'm resending them separately as
suggested by Jason Gunthorpe.
https://lore.kernel.org/linux-mm/20200619215649.32297-1-rcampbell@nvidia.co=
m/
Note that in order to exercise/test patch 2 here, you will need a
kernel with patch 1 from the original series (the fix to mm/migrate.c).
It is safe to apply these changes before the fix to mm/migrate.c
though.

Ralph Campbell (3):
  nouveau: fix migrate page regression
  nouveau: fix mixed normal and device private page migration
  nouveau: make nvkm_vmm_ctor() and nvkm_mmu_ptp_get() static

 drivers/gpu/drm/nouveau/nouveau_dmem.c         | 10 +++++++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c  |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h  |  3 ---
 4 files changed, 11 insertions(+), 6 deletions(-)

--=20
2.20.1

