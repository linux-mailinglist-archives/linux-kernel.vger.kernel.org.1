Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4576A302C13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbhAYT4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:56:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731997AbhAYTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611603664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=77St/2pIleVFwEn5R0u17JSkV+PiEVZKe/zUbSvXECQ=;
        b=ASMZBELl62xIDIVDrddqP3ICz6oR6oa5Hox8NE45DrwIoAXlx5uei6ykDArVZkUpbcn6d4
        2phX9GhdjAOq0PDhA9piVENeEEKiKZMXmiNnHnBvvh9M3MxXgAkjigbghITDd6NJn+ClBw
        SDAf0JhthDZ2e9xh9pT5ZEuv019+tlI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-9MGAjcZyMte4AGAcr_9T_Q-1; Mon, 25 Jan 2021 14:41:02 -0500
X-MC-Unique: 9MGAjcZyMte4AGAcr_9T_Q-1
Received: by mail-qv1-f71.google.com with SMTP id ew14so1749965qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77St/2pIleVFwEn5R0u17JSkV+PiEVZKe/zUbSvXECQ=;
        b=WqiASFquV9570dTqkrbQPVD0NwwZ5tMJMmprrya0be8Zmw7j5y3qSHv/CV8WrnJNGY
         hVHTrONK8t8zhsXniKHMRA44I3i2X673ZAHyxtN964iAogB2KzIsE13AYnTFy4LRwHt+
         QzLRtB0rwSrz1ySI5yJrt8NQzhXAzJ/Y6Kf4BJf9T3XQbWa4N5Vaay9FA9aB2+LSrhQx
         TA/RgZzywo87VDybUA4gQnAVhCo5qb1QLHCLbMl1NkBQ9FjNnf3llRfOLlLh9J4dGokI
         MLIbazsQybYsC23X8SozvJJxbxoa0ns2jvm9xlZPSoi+dkgOVOy3kvZASGvx4y8x2oIg
         oiPA==
X-Gm-Message-State: AOAM530a6OiRotqUDzKqmacyXhjf+QtP4GsnF1+gQpzW2dN5CMzw1NsF
        a9bInRyOIGJLa7DwD+MHWUyXZpYxQdkGhH1cIlk/KsmielujdPAFcY+eftv0Gs4aiOiEDw0S1oa
        apyZqKINVeH4V/cn2/n53C4j9
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2321885qvi.48.1611603660316;
        Mon, 25 Jan 2021 11:41:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeWyuqh+JaKFJ1xqUU6SXIHkrrOLJPawhrtxXmDS0r1Vi15nggpu9AbTZjlBOBQdInBYXhhA==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2321866qvi.48.1611603660045;
        Mon, 25 Jan 2021 11:41:00 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 203sm12845898qkd.81.2021.01.25.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:40:59 -0800 (PST)
From:   trix@redhat.com
To:     shuah@kernel.org, mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4] selftests: drivers: fpga: A test for interrupt support
Date:   Mon, 25 Jan 2021 11:40:53 -0800
Message-Id: <20210125194053.2119041-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
 # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
 ...
 TAP version 13
 1..1
 # selftests: drivers/fpga: intr
 # TAP version 13
 # 1..1
 # # Starting 1 tests from 1 test cases.
 # #  RUN           global.afu_intr ...
 # #            OK  global.afu_intr
 # ok 1 global.afu_intr
 # # PASSED: 1 / 1 tests passed.
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/fpga: intr

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v1: Convert to kselftest_harness.h framework
v2: reverse xmas tree variables
v3: rebase to linux-kselftest, tag linux-kselftest-next-5.11-rc3
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  7 ++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 tools/testing/selftests/drivers/fpga/intr.c   | 36 +++++++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/config
 create mode 100644 tools/testing/selftests/drivers/fpga/intr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..10bea5417c82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6972,6 +6972,7 @@ F:	Documentation/driver-api/fpga/
 F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
+F:	tools/testing/selftests/drivers/fpga/
 
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index afbab4aeef3c..aad4763ec348 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/fpga
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
new file mode 100644
index 000000000000..eba35c405d5b
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../../include/uapi/
+
+TEST_GEN_PROGS := intr
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
new file mode 100644
index 000000000000..e2111b81d8d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/config
@@ -0,0 +1 @@
+CONFIG_FPGA_DFL_AFU=m
diff --git a/tools/testing/selftests/drivers/fpga/intr.c b/tools/testing/selftests/drivers/fpga/intr.c
new file mode 100644
index 000000000000..927dcc757f0b
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/intr.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/fpga-dfl.h>
+
+#include "../../kselftest_harness.h"
+
+TEST(afu_intr)
+{
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num = UINT32_MAX;
+	int devfd, status;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0)
+		SKIP(0, "no fpga afu device 0");
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	ASSERT_EQ(0, status) {
+		TH_LOG("ioctl() failed to get the number irqs");
+	}
+	ASSERT_LT(irq_num, 256) {
+		TH_LOG("unexpeced number of irqs");
+	}
+	close(devfd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.27.0

