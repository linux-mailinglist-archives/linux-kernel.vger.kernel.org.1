Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6570F1BF013
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 08:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD3GOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 02:14:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50026 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbgD3GOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:14:23 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A86498FB80CA7A31E1E1;
        Thu, 30 Apr 2020 14:14:21 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 14:14:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/3] clean up some functions in mm/swap_slots.c
Date:   Thu, 30 Apr 2020 14:11:40 +0800
Message-ID: <20200430061143.450-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.166.215.55]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I studied the code of mm/swap_slots.c, I found some places can be improved.

Zhen Lei (3):
  mm/swap: simplify alloc_swap_slot_cache()
  mm/swap: simplify enable_swap_slots_cache()
  mm/swap: remove redundant check for swap_slot_cache_initialized

 mm/swap_slots.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

-- 
2.26.0.106.g9fadedd


