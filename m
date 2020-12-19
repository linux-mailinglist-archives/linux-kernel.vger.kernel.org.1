Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00462DEDD4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgLSIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 03:20:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9230 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgLSIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 03:20:07 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cydsh31pmzksDV;
        Sat, 19 Dec 2020 16:18:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 19 Dec 2020 16:19:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] device-dax: avoid an unnecessary check in alloc_dev_dax_range()
Date:   Sat, 19 Dec 2020 16:18:39 +0800
Message-ID: <20201219081840.1149-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
In v1, I use the "goto" statement to merge two identical __release_region() calls.
However, the new patch https://lkml.org/lkml/2020/12/18/735 deletes one of them, the
"goto" becomes worthless. So when krealloc() failed, directly call __release_region()
and return error code.


Zhen Lei (1):
  device-dax: avoid an unnecessary check in alloc_dev_dax_range()

 drivers/dax/bus.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

-- 
2.26.0.106.g9fadedd


