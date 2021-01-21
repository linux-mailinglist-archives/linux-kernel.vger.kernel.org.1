Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085852FE92A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbhAULq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:46:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:34585 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbhAULo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:44:58 -0500
IronPort-SDR: DJRglo1xkDYhwZwdllSjl2DpdZHPBrBJ7nFOA5P/iCAlPRILqwkQ9EkVTu2stvl4jtnP/WeAyA
 zZGkJo5UG6vQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166927233"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="166927233"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 03:44:10 -0800
IronPort-SDR: fpiFMNWJdv+kNBcat3hUI51nNJ3fyv2YaW+Eqz0AFrLPcOV9EM4nIYSVPtWFfnSZMXEb2r1mUs
 /CvXfPJHJgBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="354727258"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Jan 2021 03:44:08 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2YNj-0006U3-Lv; Thu, 21 Jan 2021 11:44:07 +0000
Date:   Thu, 21 Jan 2021 19:43:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
        Sihang Chen <chensihang1@hisilicon.com>
Subject: [RFC PATCH] uacce: uacce_ctrl_open() can be static
Message-ID: <20210121114328.GA80090@0beca8d15ecb>
References: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611220154-90232-1-git-send-email-wangzhou1@hisilicon.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 uacce.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index b8ac4080a7d6f76..11cbb69422221a5 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -508,7 +508,7 @@ void uacce_remove(struct uacce_device *uacce)
 }
 EXPORT_SYMBOL_GPL(uacce_remove);
 
-int uacce_ctrl_open(struct inode *inode, struct file *file)
+static int uacce_ctrl_open(struct inode *inode, struct file *file)
 {
 	struct uacce_pin_container *p;
 
@@ -522,7 +522,7 @@ int uacce_ctrl_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-int uacce_ctrl_release(struct inode *inode, struct file *file)
+static int uacce_ctrl_release(struct inode *inode, struct file *file)
 {
 	struct uacce_pin_container *priv = file->private_data;
 	struct pin_pages *p;
