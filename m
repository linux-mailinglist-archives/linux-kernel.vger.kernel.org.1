Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701941CDAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgEKNCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:02:18 -0400
Received: from foss.arm.com ([217.140.110.172]:60046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgEKNCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:02:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC39F1045;
        Mon, 11 May 2020 06:02:16 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.17.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B7D53F68F;
        Mon, 11 May 2020 06:02:13 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/2] Documentation/vmcoreinfo: Add documentation for 'KERNELPACMASK'
Date:   Mon, 11 May 2020 18:31:56 +0530
Message-Id: <1589202116-18265-2-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589202116-18265-1-git-send-email-amit.kachhap@arm.com>
References: <1589202116-18265-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for KERNELPACMASK variable being added to the vmcoreinfo.

It indicates the PAC bits mask information of signed kernel pointers if
Armv8.3-A Pointer Authentication feature is present.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 007a6b8..e4ee8b2 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -393,6 +393,12 @@ KERNELOFFSET
 The kernel randomization offset. Used to compute the page offset. If
 KASLR is disabled, this value is zero.
 
+KERNELPACMASK
+-------------
+
+The mask to extract the Pointer Authentication Code from a kernel virtual
+address.
+
 arm
 ===
 
-- 
2.7.4

