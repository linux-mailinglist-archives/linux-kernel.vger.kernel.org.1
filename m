Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1252AF14B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKKMzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:55:35 -0500
Received: from mx4.veeam.com ([104.41.138.86]:58222 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgKKMzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:55:35 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id AFC0D8A762;
        Wed, 11 Nov 2020 15:55:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1605099333; bh=BJ878MTKDQbkkEJ1XRYs09vGep0OMAeBuML2LW0vYXM=;
        h=From:To:CC:Subject:Date:From;
        b=nXnuBlq3d7J6a8cbBHc00YRYmL+Y3glUoAUZVAK1AYzaAU5ekp5i8hiElFgDZ2Qa9
         K0qtbXMdgpRQvdj6+K5tOUjvPlOl7wipAaAYN9vtd8rc77dc7ZtccHIh3UIdBcR+F9
         4HOADBL5Ac0gTfzh0nlYaT6GeK9KUz807m88O6eA=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 11 Nov 2020 13:55:32 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 0/1] Bug with RCU locking in dm_blk_report_zones()
Date:   Wed, 11 Nov 2020 15:55:45 +0300
Message-ID: <1605099346-3199-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A617667
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dm_get_live_table() function makes RCU read lock and
dm_put_live_table() should call even when dm_table map was not found.

Sergei Shtepa (1):
  Fix bug with RCU locking in dm_blk_report_zones().

 drivers/md/dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1

