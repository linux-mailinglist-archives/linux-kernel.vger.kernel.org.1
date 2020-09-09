Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDBA263354
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgIIRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbgIIPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:50 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D2A21D91;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=2ybAv5AUSr/9AXTd/F5iA77kKZOVn7+1fkhHLl5o5j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sjl3Ag0CZTPyedcDzQOTAHI8YcSNPCpmzAow/XXVN9RuFXLDxz8Tip5JE3H+YrqUD
         Pr20AFOkd5GNck1VVzz+v0QrKg5bmAY+RG/qpXTqco8mfEXF1mQ+3JifRMdCXPGCEX
         2PDsAO5AUndyGtJn4gHXUxqWK8besViaDjyN0oH4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWi-4c; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/30] docs: scheduler: fix the directory name on two files
Date:   Wed,  9 Sep 2020 16:10:36 +0200
Message-Id: <a32c2bba17aa69dc18670b7de1a3a35bfa1e1f88.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the directory where the schedule docs are
stored are wrong on those files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scheduler/sched-capacity.rst | 2 +-
 Documentation/scheduler/sched-energy.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 00bf0d011e2a..9b7cbe43b2d1 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -365,7 +365,7 @@ giving it a high uclamp.min value.
 .. note::
 
   Wakeup CPU selection in CFS can be eclipsed by Energy Aware Scheduling
-  (EAS), which is described in Documentation/scheduling/sched-energy.rst.
+  (EAS), which is described in Documentation/scheduler/sched-energy.rst.
 
 5.1.3 Load balancing
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 78f850778982..001e09c95e1d 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -331,7 +331,7 @@ asymmetric CPU topologies for now. This requirement is checked at run-time by
 looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
 domains are built.
 
-See Documentation/sched/sched-capacity.rst for requirements to be met for this
+See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
 flag to be set in the sched_domain hierarchy.
 
 Please note that EAS is not fundamentally incompatible with SMP, but no
-- 
2.26.2

