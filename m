Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757DE2FD9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392497AbhATToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:44:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:59892 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392630AbhATTkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:40:05 -0500
IronPort-SDR: bb9BFarngYYjDuE8Ku+FK+3qdJChux06CiNlEYtw+y2sJUkypI0oHXNBBHGfE9mrgtJpeEmHAK
 JAeI1YIf3qCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="243236611"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="243236611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:38:52 -0800
IronPort-SDR: pzhuB8GNi4NcFuaNPvuKg3ijSwwxzX6vhRsPNgcaN3iWjTooCAwL1Ft65HVPryvJipqrsV6g1C
 Z27Es84BmAxw==
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="501708581"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:38:52 -0800
Subject: [PATCH 0/3] cdev: Generic shutdown handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hans Verkuil <hans.verkuil@cisco.com>, logang@deltatee.com,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Date:   Wed, 20 Jan 2021 11:38:52 -0800
Message-ID: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After reviewing driver submissions with new cdev + ioctl usages one
common stumbling block is coordinating the shutdown of the ioctl path,
or other file operations, at driver ->remove() time. While cdev_del()
guarantees that no new file descriptors will be established, operations
on existing file descriptors can proceed indefinitely.

Given the observation that the kernel spends the resources for a percpu_ref
per request_queue shared with all block_devices on a gendisk, do the
same for all the cdev instances that share the same
cdev_add()-to-cdev_del() lifetime.

With this in place cdev_del() not only guarantees 'no new opens', but it
also guarantees 'no new operations invocations' and 'all threads running
in an operation handler have exited that handler'.

As a proof point of the way driver implementations open-code around this
gap in the api the libnvdimm ioctl path is reworked with a result of:

    4 files changed, 101 insertions(+), 153 deletions(-)

---

Dan Williams (3):
      cdev: Finish the cdev api with queued mode support
      libnvdimm/ida: Switch to non-deprecated ida helpers
      libnvdimm/ioctl: Switch to cdev_register_queued()


 drivers/nvdimm/btt_devs.c       |    6 +
 drivers/nvdimm/bus.c            |  177 +++++++++------------------------------
 drivers/nvdimm/core.c           |   14 ++-
 drivers/nvdimm/dax_devs.c       |    4 -
 drivers/nvdimm/dimm_devs.c      |   53 +++++++++---
 drivers/nvdimm/namespace_devs.c |   14 +--
 drivers/nvdimm/nd-core.h        |   14 ++-
 drivers/nvdimm/pfn_devs.c       |    4 -
 fs/char_dev.c                   |  108 ++++++++++++++++++++++--
 include/linux/cdev.h            |   21 ++++-
 10 files changed, 238 insertions(+), 177 deletions(-)
