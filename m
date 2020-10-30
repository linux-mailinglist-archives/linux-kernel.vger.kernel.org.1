Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CBF2A0D87
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJ3ShD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:37:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:34119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3ShD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:37:03 -0400
IronPort-SDR: K8z57+LgseWV2W7+cG4PCiHXgZ1DGDmnNTFz/oha5v2qeVFyjvG6JSd140k38ABT2FFy0aEYIz
 xpmr0Ifl+wZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="147935132"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="147935132"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 11:37:03 -0700
IronPort-SDR: RZeC37+x+MPof7qd/k5rlin+J81mHWeVHdF8jV41CdjtQ9f/8gndhSl50pBA257UsIlchEEQ9p
 V+7OOuMZUDwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="351956596"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2020 11:37:00 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com, willemb@google.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        xiaochen.shen@intel.com
Subject: [PATCH 0/3] Fix kernfs node reference count leak issues
Date:   Sat, 31 Oct 2020 03:02:10 +0800
Message-Id: <1604084530-31048-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several kernfs node reference count leak issues:
(1) Remove superfluous kernfs_get() calls to prevent refcount leak 
(2) Add necessary kernfs_put() calls to prevent refcount leak
(3) Follow-up cleanup for the change in previous patch.

Xiaochen Shen (3):
  x86/resctrl: Remove superfluous kernfs_get() calls to prevent refcount
    leak
  x86/resctrl: Add necessary kernfs_put() calls to prevent refcount leak
  x86/resctrl: Clean up unused function parameter in rmdir path

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 82 ++++++++++++++--------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

-- 
1.8.3.1

