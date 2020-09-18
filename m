Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82826F7B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRIKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:10:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52939 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbgIRIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600416613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=nn4mVXfrUSRgOT8MEs6N754ehCpTZG1A7BrNmYlopGM=;
        b=ZFI5K/L0kXUX0kWSgZnFu5VkAmJ0LXf7TU3f3hKO8PbtqRerJRYByi+TbUFbEc1SnTKYRw
        qqI1vUxxtviKB5kCIkkoSzZOPzEgdFe/dHGhDNEP6j17zEXfbtwap+N1Wn7v8zh8IqDe7o
        71HCuXbqbjlYVK54QmdaBvFyz+RHQIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-mPr4_xyANSi0M-pHjPS2EA-1; Fri, 18 Sep 2020 04:10:07 -0400
X-MC-Unique: mPr4_xyANSi0M-pHjPS2EA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2006510A7AE4;
        Fri, 18 Sep 2020 08:10:06 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C23A91001281;
        Fri, 18 Sep 2020 08:10:01 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bhe@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, vgoyal@redhat.com
Subject: [PATCH] docs: admin-guide: update kdump documentation due to change of crash URL
Date:   Fri, 18 Sep 2020 16:09:58 +0800
Message-Id: <20200918080958.19841-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since crash utility has moved to github, the original URL is no longer
available. Let's update it accordingly.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 2da65fef2a1c..75a9dd98e76e 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -509,9 +509,12 @@ ELF32-format headers using the --elf32-core-headers kernel option on the
 dump kernel.
 
 You can also use the Crash utility to analyze dump files in Kdump
-format. Crash is available on Dave Anderson's site at the following URL:
+format. Crash is available at the following URL:
 
-   http://people.redhat.com/~anderson/
+   https://github.com/crash-utility/crash
+
+Crash document can be found at:
+   https://crash-utility.github.io/
 
 Trigger Kdump on WARN()
 =======================
-- 
2.17.1

