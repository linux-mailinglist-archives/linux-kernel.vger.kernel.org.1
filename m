Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430B31B956B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 05:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgD0DY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 23:24:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbgD0DY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:24:27 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8DC01B4CCD3A16D4929B;
        Mon, 27 Apr 2020 11:24:24 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Apr 2020
 11:24:15 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <wambui.karugax@gmail.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 0/7] staging: rtl8723bs: some code cleanup
Date:   Mon, 27 Apr 2020 11:23:35 +0800
Message-ID: <20200427032342.27211-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some warnings of '-Wunused-but-set-variable'.

Jason Yan (7):
  staging: rtl8723bs: os_dep: remove set but not used 'uintRet'
  staging: rtl8723bs: os_dep: remove set but not used 'size'
  Staging: rtl8723bs: core: remove set but not used 'ptxservq'
  staging: rtl8723bs: core: remove set but not used 'algthm'
  staging: rtl8723bs: core: remove set but not used 'listen_interval'
  staging: rtl8723bs: core: remove set but not used 'pwrpriv'
  staging: rtl8723bs: core:  remove set but not used 'pframe'

 drivers/staging/rtl8723bs/core/rtw_mlme.c         |  6 +-----
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  7 ++-----
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c      |  2 --
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 11 -----------
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    |  6 ++++--
 5 files changed, 7 insertions(+), 25 deletions(-)

-- 
2.21.1

