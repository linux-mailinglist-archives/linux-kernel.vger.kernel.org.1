Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B13C1CAA42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 14:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEHMHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 08:07:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgEHMHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:07:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C23DB3F53B1E064EA9C;
        Fri,  8 May 2020 20:07:19 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.166.215.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 20:07:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] mm/page_io.c: remove an unnecessary goto in generic_swapfile_activate()
Date:   Fri, 8 May 2020 20:06:39 +0800
Message-ID: <20200508120640.1852-1-thunder.leizhen@huawei.com>
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

v1 --> v2:
1. rename subject
2. give up adding an newline to seperate two labels

Zhen Lei (1):
  mm/page_io.c: remove an unnecessary goto in
    generic_swapfile_activate()

 mm/page_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.26.0.106.g9fadedd


