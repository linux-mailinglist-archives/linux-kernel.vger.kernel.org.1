Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAE258A5A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIAIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 04:33:37 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:20459 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAIde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1598949214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZgbkUHppbVaFHJoTWftMMI+riUpDxpQUtdzYOwYpFo=;
  b=db4fqPaWpKS7305zTqX3qOenpDB734uM8XeFfiqeCkaLqYHp2v+C4h25
   WwcH1s4UGv6e/0DsNewpm47PjHAznU+siceAeugo+dNFxFRa2mRDrUVtw
   elnSTVIoxPy9Ge4PcJH8LyFnIrtdsxrF/0e6J8q8QNlwPhndGk643OAq3
   U=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: cM4zDigjOx5W+U9PfM8X4dGURvU3pFhihoT4/kzOKFmMv+VWCTdQtas5xawpzM5dwmh2WBKCXD
 J3KgPKcLbPgw/J/AkETo5yRrRgHNYQIrptYe+E50/om0jSsflT+YVVnASwQuMo1fFGRw4+nBTr
 ljhngveVpU4IYDSm4yJjDG6vwD7oF6qJPhIgYFNbB0Zb9a+Dymp+msraD2fMi6DETOnlCYESgp
 QmP+eeUBO+E/wVGBOpQyyIBPA+z+lI9RyM9K7oZQwXlfKzK7qq+r8UujL3yFwrGttfqOGADEB4
 1q0=
X-SBRS: 2.7
X-MesageID: 26017046
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,378,1592884800"; 
   d="scan'208";a="26017046"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v5 1/3] xen/balloon: add header guard
Date:   Tue, 1 Sep 2020 10:33:24 +0200
Message-ID: <20200901083326.21264-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901083326.21264-1-roger.pau@citrix.com>
References: <20200901083326.21264-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to protect against the header being included multiple times
on the same compilation unit.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
This is required as a pre-patch to use ZONE_DEVICE, or else the
fallback of including the balloon header might not work properly.
---
 include/xen/balloon.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 6fb95aa19405..6dbdb0b3fd03 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -2,6 +2,8 @@
 /******************************************************************************
  * Xen balloon functionality
  */
+#ifndef _XEN_BALLOON_H
+#define _XEN_BALLOON_H
 
 #define RETRY_UNLIMITED	0
 
@@ -34,3 +36,5 @@ static inline void xen_balloon_init(void)
 {
 }
 #endif
+
+#endif	/* _XEN_BALLOON_H */
-- 
2.28.0

