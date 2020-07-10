Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9B821B1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGJJFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:05:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727818AbgGJJFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:05:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C9362584F401E791179;
        Fri, 10 Jul 2020 17:02:41 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Jul 2020
 17:02:31 +0800
From:   Lu Wei <luwei32@huawei.com>
To:     <alex.hung@canonical.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <acelan.kao@canonical.com>,
        <andy.shevchenko@gmail.com>, <luwei32@huawei.com>
Subject: [PATCH v3 0/2] Fix return value check
Date:   Fri, 10 Jul 2020 17:04:21 +0800
Message-ID: <1594371863-20827-1-git-send-email-luwei32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function check_acpi_dev(), if it fails to create
platform device, the return value is ERR_PTR() or NULL.
Thus it must use IS_ERR_OR_NULL to check return value.

*** BLURB HERE ***

Lu Wei (2):
  intel-hid: Fix return value check in check_acpi_dev()
  intel-vbtn: Fix return value check in check_acpi_dev()

 drivers/platform/x86/intel-hid.c  | 2 +-
 drivers/platform/x86/intel-vbtn.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

