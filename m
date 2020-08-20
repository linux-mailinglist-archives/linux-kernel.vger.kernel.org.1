Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF924AEA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHTFru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 01:47:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55879 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgHTFro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902463; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=tj2fm+Q+kXlQbFIh4MgRdSOi/5Fm5Bw82GG2/KF9wGA=; b=w485U6T61txMXwn+ukirhXLHc55dLldG7t2sK5Wl+UttORwmQ3hEn1xuvEXCxZbxZyXBjh3j
 KC5ASTQqvUpRG2tZ9+Bz59LsXdlozxcrQYTtz228ecwC/wbwDPXHAGivUv0LAxG7C15q5hRw
 8n9Kc4GHo7X6n6kA1RCh4EEn5bo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f3e0e797eb4541d938101ba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:47:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35501C433AF; Thu, 20 Aug 2020 05:47:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D5DCC433CA;
        Thu, 20 Aug 2020 05:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D5DCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/24] coresight: allow to build coresight as modules
Date:   Thu, 20 Aug 2020 13:46:54 +0800
Message-Id: <20200820054718.20115-1-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to build coresight as modules. This gives developers the feasibility to
test their code without reboot.

This series is based on below two series.

 - "coresight: allow to build components as modules"
   https://lkml.org/lkml/2018/6/5/989
 - "coresight: make drivers modular"
   https://lkml.org/lkml/2020/1/17/468

Change from v8:
Protect etmdrvdata[] by modifying it on relevant CPU  (Mathieu and Suzuki)
Grab the device before allocating memory for the node (Mathieu)
Add author of coresight core driver (Mathieu)

Change from v7:
Depends on below change for ETM hotplug (Sai)
https://lore.kernel.org/linux-arm-kernel/20200729051310.18436-1-saiprakash.ranjan@codeaurora.org/
Add mutex lock to protect etmdrvdata[] (Suzuki)
Add helper function coresight_get_ref()	(Suzuki)
Reorg replicator and funnel change. Use two patches to support these
two drivers. (Suzuki)
Add fix tag to "coresight: etm: perf: Fix warning caused by etm_setup_aux
failure" (Suzuki)
Update author of "coresight: cti: Fix bug clearing sysfs links on callback"

Change from v6:
Correct module description for CATU (Mike)
Check ect_ret equals 0 and set ect_enabled flag (Mike)
Add Tested-by and Reviewed-by from Mike

Change from v5:
Add below CTI clean up change from Mike into series
 -https://lists.linaro.org/pipermail/coresight/2020-July/004349.html
Increase module reference count when enabling CTI device (Mike)

Change from v4:
Fix error handling in coresight_grab_devicei() (Greg)
Add coresight: cti: Fix remove sysfs link error from Mike
 -https://lists.linaro.org/pipermail/coresight/2020-July/004275.html
Move cti_remove_conn_xrefs() into cti_remove() (Mike)
Align patch subject to coresight: <component>: <description> (Mike)

Change from v3:
Rebase to coresight-next (Mike and Mathieu)
Reorder try_get_module() (Suzuki)
Clean up etmdrvdata[] in device remote path (Mike)
Move cti_remove_conn_xrefs to cti_remove (Mike)

Change from v2:
Rebase to 5.8-rc5. Export coresight_add_sysfs_link and
coresight_remove_sysfs_link
Fix one cut and paste error on MODULE_DESCRIPTION of CTI

Change from v1:
Use try_module_get() to avoid module to be unloaded when device is used
in active trace session. (Mathieu P)

Change from above two series.
This series adds the support to dynamically remove module when the device in
that module is enabled and used by some trace path. It disables all trace
paths with that device and release the trace path.

Kim Phillips (8):
  coresight: use IS_ENABLED for CONFIGs that may be modules
  coresight: etm3x: allow etm3x to be built as a module
  coresight: etm4x: allow etm4x to be built as a module
  coresight: etb: allow etb to be built as a module
  coresight: tpiu: allow tpiu to be built as a module
  coresight: tmc: allow tmc to be built as a module
  coresight: allow funnel driver to be built as module
  coresight: allow replicator driver to be built as module

Mian Yousaf Kaukab (2):
  coresight: export global symbols
  coresight: tmc-etr: add function to register catu ops

Mike Leach (2):
  coresight: cti: Fix remove sysfs link error
  coresight: cti: Fix bug clearing sysfs links on callback

Tingwei Zhang (12):
  coresight: cpu_debug: add module name in Kconfig
  coresight: cpu_debug: define MODULE_DEVICE_TABLE
  coresight: add coresight prefix to barrier_pkt
  coresight: add try_get_module() in coresight_grab_device()
  coresight: stm: allow to build coresight-stm as a module
  coresight: etm: perf: Fix warning caused by etm_setup_aux failure
  coresight: cti: add function to register cti associate ops
  coresight: cti: don't disable ect device if it's not enabled
  coresight: cti: increase reference count when enabling cti
  coresight: cti: allow cti to be built as a module
  coresight: catu: allow catu drivers to be built as modules
  coresight: allow the coresight core driver to be built as a module

 drivers/hwtracing/coresight/Kconfig           |  54 ++++--
 drivers/hwtracing/coresight/Makefile          |  22 +--
 drivers/hwtracing/coresight/coresight-catu.c  |  37 ++++-
 drivers/hwtracing/coresight/coresight-catu.h  |   2 -
 .../{coresight.c => coresight-core.c}         | 154 +++++++++++++++---
 .../hwtracing/coresight/coresight-cpu-debug.c |   2 +
 .../{coresight-cti.c => coresight-cti-core.c} |  63 ++++++-
 drivers/hwtracing/coresight/coresight-etb10.c |  28 +++-
 .../hwtracing/coresight/coresight-etm-perf.c  |  13 +-
 .../hwtracing/coresight/coresight-etm-perf.h  |   5 +-
 ...resight-etm3x.c => coresight-etm3x-core.c} |  28 +++-
 ...resight-etm4x.c => coresight-etm4x-core.c} |  84 +++++++---
 .../hwtracing/coresight/coresight-funnel.c    |  64 +++++++-
 .../hwtracing/coresight/coresight-platform.c  |   1 +
 drivers/hwtracing/coresight/coresight-priv.h  |  24 ++-
 .../coresight/coresight-replicator.c          |  65 +++++++-
 drivers/hwtracing/coresight/coresight-stm.c   |  20 ++-
 drivers/hwtracing/coresight/coresight-sysfs.c |   2 +
 .../{coresight-tmc.c => coresight-tmc-core.c} |  25 ++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  21 ++-
 drivers/hwtracing/coresight/coresight-tmc.h   |   3 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |  20 ++-
 include/linux/coresight.h                     |   3 +-
 24 files changed, 634 insertions(+), 108 deletions(-)
 rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (92%)
 rename drivers/hwtracing/coresight/{coresight-cti.c => coresight-cti-core.c} (94%)
 rename drivers/hwtracing/coresight/{coresight-etm3x.c => coresight-etm3x-core.c} (97%)
 rename drivers/hwtracing/coresight/{coresight-etm4x.c => coresight-etm4x-core.c} (96%)
 rename drivers/hwtracing/coresight/{coresight-tmc.c => coresight-tmc-core.c} (95%)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

