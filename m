Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853C52A2732
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgKBJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:41:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6730 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgKBJk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:40:59 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPnwR56YYzkdXc;
        Mon,  2 Nov 2020 17:40:55 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 17:40:50 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <gregkh@linuxfoundation.org>, <zhangfei.gao@linaro.org>
Subject: [RESEND PATCH v3 0/2] uacce: fix some coding styles
Date:   Mon, 2 Nov 2020 17:39:23 +0800
Message-ID: <1604309965-21752-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: y00501072 <y00501072@huawei.com>

1. delete some redundant code.
2. modify the module author information. "Hisilicon"
spelling is error.

Changes v2 -> v3:
	Two things, splited to two patches.
Changes v1 -> v2:
	deleted extra NULL pointer check in uacce_fops.

Kai Ye (2):
  uacce: delete some redundant code.
  uacce: modify the module author information.

 drivers/misc/uacce/uacce.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

-- 
2.8.1

