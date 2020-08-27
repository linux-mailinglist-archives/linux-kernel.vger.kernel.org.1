Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D705A254CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgH0SUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 14:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgH0SUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:20:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406372087C;
        Thu, 27 Aug 2020 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598552435;
        bh=JhM6FPCbA4g1z4X4hZMMnSc4eTsjqr+y2d9PBalJfoE=;
        h=From:To:Cc:Subject:Date:From;
        b=GHiQMeaIk65r2UV1/jqLWfcHN5K9tNcqt6fAMkuc9mFSQl+EGf4OFMw3jAVFMN3SG
         PgVJXu0JZnQWMMJqw8v3gG3uiKGm9V/aSMoGc4FcdEiSe3cupExXE6OtX8ewMYIdPf
         Nelj9ozSWjzGKjfjtlHpKgOG1epskzT92/jwKXN4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Security Officers <security@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] MAINTAINERS: Add the security document to SECURITY CONTACT
Date:   Thu, 27 Aug 2020 20:20:29 +0200
Message-Id: <20200827182029.3458-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing the document related to kernel security workflow, notify
the security mailing list as its concerned by this.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <security@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Changed order - F: go to end of entry,
2. Remove embargoed-hardware-issues
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8107b3d5d6df..19064a4ae9b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15621,6 +15621,7 @@ F:	include/uapi/linux/sed*
 SECURITY CONTACT
 M:	Security Officers <security@kernel.org>
 S:	Supported
+F:	Documentation/admin-guide/security-bugs.rst
 
 SECURITY SUBSYSTEM
 M:	James Morris <jmorris@namei.org>
-- 
2.17.1

