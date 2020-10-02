Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6572818DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbgJBRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:09:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56630 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJBRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:09:37 -0400
Received: from [222.129.36.226] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1kOOYi-00038m-V4; Fri, 02 Oct 2020 17:09:29 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     aaron.ma@canonical.com, mapengyu@gmail.com, ibm-acpi@hmh.eng.br,
        dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: thinkpad_acpi: re-initialize ACPI buffer size when reuse
Date:   Sat,  3 Oct 2020 01:09:16 +0800
Message-Id: <20201002170916.64328-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929082025.51446-1-aaron.ma@canonical.com>
References: <20200929082025.51446-1-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Evaluating ACPI _BCL could fail, then ACPI buffer size will be set to 0.
When reuse this ACPI buffer, AE_BUFFER_OVERFLOW will be triggered.

Re-initialize buffer size will make ACPI evaluate successfully.

Fixes: 46445b6b896fd ("thinkpad-acpi: fix handle locate for video and query of _BCL")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9c4df41687a3..477d63c49c04 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6829,8 +6829,10 @@ static int __init tpacpi_query_bcl_levels(acpi_handle handle)
 	list_for_each_entry(child, &device->children, node) {
 		acpi_status status = acpi_evaluate_object(child->handle, "_BCL",
 							  NULL, &buffer);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			buffer.length = ACPI_ALLOCATE_BUFFER;
 			continue;
+		}
 
 		obj = (union acpi_object *)buffer.pointer;
 		if (!obj || (obj->type != ACPI_TYPE_PACKAGE)) {
-- 
2.28.0

