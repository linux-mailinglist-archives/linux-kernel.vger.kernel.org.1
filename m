Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10B5268CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgINOHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:07:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbgINN7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:59:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93EFCBB7559C96A72334;
        Mon, 14 Sep 2020 21:59:48 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 21:59:42 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 0/4] ubifs: Fix some kernel-doc warnings for ubifs
Date:   Mon, 14 Sep 2020 21:56:50 +0800
Message-ID: <20200914135654.55120-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ubifs module, there are some kernel-doc warnings,
this series of patches can fix these warnings.

Wang Hai (4):
  ubifs: Fix 'hash' kernel-doc warning in auth.c
  ubifs: Fix some kernel-doc warnings in gc.c
  ubifs: Fix some kernel-doc warnings in replay.c
  ubifs: Fix some kernel-doc warnings in tnc.c

 fs/ubifs/auth.c   | 2 +-
 fs/ubifs/gc.c     | 4 ----
 fs/ubifs/replay.c | 2 --
 fs/ubifs/tnc.c    | 3 +--
 4 files changed, 2 insertions(+), 9 deletions(-)

-- 
2.17.1

