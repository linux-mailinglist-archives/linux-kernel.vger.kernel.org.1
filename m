Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676F62433D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 08:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgHMGRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 02:17:40 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:31258 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgHMGRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:17:40 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2020 02:17:38 EDT
X-AuditID: 0a650161-e51ff70000001043-83-5f34d77908e6
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id A1.78.04163.977D43F5; Thu, 13 Aug 2020 14:02:33 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1597298553; h=from:subject:to:date:message-id;
        bh=CRCpeSDD/Q1z0NWVZIHyintmmxS3rMDB/iZhCFDn9Fc=;
        b=bqVTvUuy7pGSyFbqJxgYTv30FfaPiO1rnAtSUCgBhTY2U4brQN2jqsuuEWnJWMRRvV5SM/le7ew
        fjNR3e4uwEHUPVNSbpQ7r3aNFdCoB8wK+jrZuK+CLYDKbRHw+v+6GtxowcDAKohKmYv8sXQ1yU7jQ
        Jhp1bX7r4kz41JnCjgo=
Received: from hsj-OptiPlex-5060.iluvatar.local (10.101.199.252) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Thu, 13 Aug 2020 14:02:33 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <peterz@infradead.org>
CC:     <mingo@redhat.com>, <will@kernel.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] Documentation/locking/locktypes: fix the typo
Date:   Thu, 13 Aug 2020 14:02:20 +0800
Message-ID: <20200813060220.18199-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.252]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have three categories locks, not two.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 Documentation/locking/locktypes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 1b577a8bf982..4cefed8048ca 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -10,7 +10,7 @@ Introduction
 ============
 
 The kernel provides a variety of locking primitives which can be divided
-into two categories:
+into three categories:
 
  - Sleeping locks
  - CPU local locks
-- 
2.17.1

