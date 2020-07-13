Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81B21E2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGMVzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 17:55:17 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:47562 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMVzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:55:16 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 28AF3BC097;
        Mon, 13 Jul 2020 21:55:12 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     tony.luck@intel.com, fenghua.yu@intel.com, corbet@lwn.net,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] ia64: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 23:55:06 +0200
Message-Id: <20200713215506.44327-1-grandmaster@al2klimov.de>
In-Reply-To: <20200713083408.38154746@lwn.net>
References: <20200713083408.38154746@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 As you said I should not HTTPSify broken links...

 Documentation/ia64/xen.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ia64/xen.rst b/Documentation/ia64/xen.rst
index 831339c74441..9da6abb02a2c 100644
--- a/Documentation/ia64/xen.rst
+++ b/Documentation/ia64/xen.rst
@@ -28,7 +28,7 @@ Getting and Building Xen and Dom0
 
 	# hg clone http://xenbits.xensource.com/ext/ia64/xen-unstable.hg
 	# cd xen-unstable.hg
-	# hg clone http://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
+	# hg clone https://xenbits.xensource.com/ext/ia64/linux-2.6.18-xen.hg
 
  2. # make world
 
-- 
2.27.0

