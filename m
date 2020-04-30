Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B581C0237
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgD3QTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgD3QSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:39 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0053B2495E;
        Thu, 30 Apr 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263518;
        bh=ZBq13Jcm44mbBQFwt73lg+FwJeqOBomSiYK/tB11xow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B0M+zAZvp4pFYj3QaAa4+WpzJNksSoQcGWcMhyOfXVIjcX5w5eDBiLXPE0YNoqOtK
         17kYO/2NTzPSUP8b4e/NrLZfr5Xpw3h1q7SFP8DcLMmKW3UiKFfn/d2u0Smi1O4F+D
         kMciKyt9S+csWHmdc11BGIR2SForSbkQg22WyofQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtU-00Axhh-89; Thu, 30 Apr 2020 18:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 14/19] docs: powerpc: convert vcpudispatch_stats.txt to ReST
Date:   Thu, 30 Apr 2020 18:18:28 +0200
Message-Id: <ca3e8c71845b81df0814c018da5c6c9386f47070.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Use standard markup for document title;
- Adjust identation on lists and add blank lines where
  needed;
- Add it to the powerpc index.rst file.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> # powerpc
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/powerpc/index.rst                 |  1 +
 ...ispatch_stats.txt => vcpudispatch_stats.rst} | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)
 rename Documentation/powerpc/{vcpudispatch_stats.txt => vcpudispatch_stats.rst} (94%)

diff --git a/Documentation/powerpc/index.rst b/Documentation/powerpc/index.rst
index afe2d5e54db6..748bf483b1c2 100644
--- a/Documentation/powerpc/index.rst
+++ b/Documentation/powerpc/index.rst
@@ -31,6 +31,7 @@ powerpc
     transactional_memory
     ultravisor
     vas-api
+    vcpudispatch_stats
 
 .. only::  subproject and html
 
diff --git a/Documentation/powerpc/vcpudispatch_stats.txt b/Documentation/powerpc/vcpudispatch_stats.rst
similarity index 94%
rename from Documentation/powerpc/vcpudispatch_stats.txt
rename to Documentation/powerpc/vcpudispatch_stats.rst
index e21476bfd78c..5704657a5987 100644
--- a/Documentation/powerpc/vcpudispatch_stats.txt
+++ b/Documentation/powerpc/vcpudispatch_stats.rst
@@ -1,5 +1,8 @@
-VCPU Dispatch Statistics:
-=========================
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+VCPU Dispatch Statistics
+========================
 
 For Shared Processor LPARs, the POWER Hypervisor maintains a relatively
 static mapping of the LPAR processors (vcpus) to physical processor
@@ -20,25 +23,29 @@ The statistics themselves are available by reading the procfs file
 a vcpu as represented by the first field, followed by 8 numbers.
 
 The first number corresponds to:
+
 1. total vcpu dispatches since the beginning of statistics collection
 
 The next 4 numbers represent vcpu dispatch dispersions:
+
 2. number of times this vcpu was dispatched on the same processor as last
    time
 3. number of times this vcpu was dispatched on a different processor core
    as last time, but within the same chip
 4. number of times this vcpu was dispatched on a different chip
 5. number of times this vcpu was dispatches on a different socket/drawer
-(next numa boundary)
+   (next numa boundary)
 
 The final 3 numbers represent statistics in relation to the home node of
 the vcpu:
+
 6. number of times this vcpu was dispatched in its home node (chip)
 7. number of times this vcpu was dispatched in a different node
 8. number of times this vcpu was dispatched in a node further away (numa
-distance)
+   distance)
+
+An example output::
 
-An example output:
     $ sudo cat /proc/powerpc/vcpudispatch_stats
     cpu0 6839 4126 2683 30 0 6821 18 0
     cpu1 2515 1274 1229 12 0 2509 6 0
-- 
2.25.4

