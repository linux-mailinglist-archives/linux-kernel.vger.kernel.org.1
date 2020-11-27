Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C5A2C6045
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405083AbgK0HAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:00:21 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:42269 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgK0HAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606460419; x=1637996419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=viVKit3dVbSrh340cOllYtKoraRGThxG51PkfUAAw6I=;
  b=rD2iqbo+Y0QcVjgiLo8rRijpLk+rjKwiLfDWLLMTslxNinkB+LNhbl9q
   tSRxb0DepHru7axJQrlI85UcYGhTfjtppCVSrTLqhTgHqxO5F6rQHDpV7
   eHvuFl/xBNxWrHYz8/+gT3gWrH+ufp9bY+FwncJZFuXnuKCoEKvPDC4Js
   4=;
X-IronPort-AV: E=Sophos;i="5.78,373,1599523200"; 
   d="scan'208";a="91359430"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 27 Nov 2020 07:00:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id BDAF8120DF6;
        Fri, 27 Nov 2020 07:00:07 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 07:00:00 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 07:00:00 +0000
Received: from localhost (10.85.0.203) by mail-relay.amazon.com (10.43.60.234)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 27 Nov
 2020 06:59:58 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v3 5/5] Documentation: Add L1D flushing Documentation
Date:   Fri, 27 Nov 2020 17:59:38 +1100
Message-ID: <20201127065938.8200-6-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201127065938.8200-1-sblbir@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of l1d flushing, explain the need for the
feature and how it can be used.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/admin-guide/hw-vuln/index.rst   |  1 +
 .../admin-guide/hw-vuln/l1d_flush.rst         | 69 +++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         | 17 +++++
 Documentation/userspace-api/spec_ctrl.rst     |  8 +++
 4 files changed, 95 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/l1d_flush.rst

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ca4dbdd9016d..21710f8609fe 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
    tsx_async_abort
    multihit.rst
    special-register-buffer-data-sampling.rst
+   l1d_flush.rst
diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
new file mode 100644
index 000000000000..9db0f5e568cb
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -0,0 +1,69 @@
+L1D Flushing
+============
+
+With an increasing number of vulnerabilities being reported around data
+leaks from the Level 1 Data cache (L1D) the kernel provides an opt-in
+mechanism to flush the L1D cache on context switch.
+
+This mechanism can be used to address e.g. CVE-2020-0550. For applications
+the mechanism keeps them safe from vulnerabilities, related to leaks
+(snooping of) from the L1D cache.
+
+
+Related CVEs
+------------
+The following CVEs can be addressed by this
+mechanism
+
+    =============       ========================     ==================
+    CVE-2020-0550       Improper Data Forwarding     OS related aspects
+    =============       ========================     ==================
+
+Usage Guidelines
+----------------
+
+Please see document: :ref:`Documentation/userspace-api/spec_ctrl.rst
+<set_spec_ctrl>` for details.
+
+**NOTE**: The feature is disabled by default, applications need to
+specifically opt into the feature to enable it.
+
+Mitigation
+----------
+
+When PR_SET_L1D_FLUSH is enabled for a task a flush of the L1D cache is
+performed when the task is scheduled out and the incoming task belongs to a
+different process and therefore to a different address space.
+
+If the underlying CPU supports L1D flushing in hardware, the hardware
+mechanism is used, software fallback for the mitigation, is not supported.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+
+The kernel command line allows to control the L1D flush mitigations at boot
+time with the option "l1d_flush_out=". The valid arguments for this option are:
+
+  ============  =============================================================
+  off		Disables the prctl interface, applications trying to use
+                the prctl() will fail with an error
+  ============  =============================================================
+
+By default the API is enabled and applications opt-in by using the prctl
+API.
+
+Limitations
+-----------
+
+The mechanism does not mitigate L1D data leaks between tasks belonging to
+different processes which are concurrently executing on sibling threads of
+a physical CPU core when SMT is enabled on the system.
+
+This can be addressed by controlled placement of processes on physical CPU
+cores or by disabling SMT. See the relevant chapter in the L1TF mitigation
+document: :ref:`Documentation/admin-guide/hw-vuln/l1tf.rst <smt_control>`.
+
+**NOTE** : The opt-in of a task for L1D flushing will work only when the
+tasks affinity is limited to cores running in non-SMT mode. Running the task
+on a CPU with SMT enabled would result in the task getting a SIGBUS when 
+t executes on the non-SMT core.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..e3ed24af91d1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2320,6 +2320,23 @@
 			feature (tagged TLBs) on capable Intel chips.
 			Default is 1 (enabled)
 
+	l1d_flush_out=	[X86,INTEL]
+			Control mitigation for L1D based snooping vulnerability.
+
+			Certain CPUs are vulnerable to an exploit against CPU
+			internal buffers which can forward information to a
+			disclosure gadget under certain conditions.
+
+			In vulnerable processors, the speculatively
+			forwarded data can be used in a cache side channel
+			attack, to access data to which the attacker does
+			not have direct access.
+
+			This parameter controls the mitigation. The
+			options are:
+
+			off        - Unconditionally disable the mitigation
+
 	l1tf=           [X86] Control mitigation of the L1TF vulnerability on
 			      affected CPUs
 
diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/userspace-api/spec_ctrl.rst
index 7ddd8f667459..f39744ef8810 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -106,3 +106,11 @@ Speculation misfeature controls
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_ENABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_DISABLE, 0, 0);
    * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_INDIRECT_BRANCH, PR_SPEC_FORCE_DISABLE, 0, 0);
+
+- PR_SPEC_L1D_FLUSH_OUT: Flush L1D Cache on context switch out of the task
+                        (works only when tasks run on non SMT cores)
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_DISABLE, 0, 0);
-- 
2.17.1

