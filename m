Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5265A2B72A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgKQXuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:50:06 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64396 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgKQXuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605657005; x=1637193005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=yVijNXJfZpB9jcbWLbG3sANy1ieOt38EwuJJVRwYsWQ=;
  b=lyz/gKGizT3kIt3ADM1jG31G/sVjpMJW6iTeczTXu4xJOhQhgdak0o0T
   fWjAPDA5xa0JfoqunR08mlN2Ijsjtv78+ZPcA79gp2/6L28hwemy8TYNI
   oa/jD82kxXd27uxfinhQ56pyFFlWF7fnto+CW/R1EPx6JdvPzQJ9je0wq
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,486,1596499200"; 
   d="scan'208";a="95124746"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 17 Nov 2020 23:49:57 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 90E5DA1E01;
        Tue, 17 Nov 2020 23:49:55 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:54 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 23:49:54 +0000
Received: from localhost (10.143.193.228) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Nov 2020 23:49:47 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v1 2/3] Documentation: Update the new SIGBUS behaviour for tasks
Date:   Wed, 18 Nov 2020 10:49:33 +1100
Message-ID: <20201117234934.25985-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117234934.25985-1-sblbir@amazon.com>
References: <20201117234934.25985-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to mention that a SIGBUS will be sent
to tasks that opt-into L1D flushing and execute on non-SMT cores.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
To be applied on top of tip commit id
767d46ab566dd489733666efe48732d523c8c332

 Documentation/admin-guide/hw-vuln/l1d_flush.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/l1d_flush.rst b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
index adc4ecc72361..c6a0713c8271 100644
--- a/Documentation/admin-guide/hw-vuln/l1d_flush.rst
+++ b/Documentation/admin-guide/hw-vuln/l1d_flush.rst
@@ -63,8 +63,8 @@ This can be addressed by controlled placement of processes on physical CPU
 cores or by disabling SMT. See the relevant chapter in the L1TF mitigation
 document: :ref:`Documentation/admin-guide/hw-vuln/l1tf.rst <smt_control>`.
 
-**NOTE** : Checks have been added to ensure that the prctl API associated
+**NOTE** : Checks have been added to ensure that the L1D flush associated
 with the opt-in will work only when the task affinity of the task opting
-in, is limited to cores running in non-SMT mode. The same checks are made
-when L1D is flushed.  Changing the affinity after opting in, would result
-in flushes not working on cores that are in non-SMT mode.
+in, is limited to cores running in non-SMT mode. Changing the affinity after
+opting in, would result in the task getting a SIGBUS when it executes on
+the flush is needed and the task is executing on the non-SMT core.
-- 
2.17.1

