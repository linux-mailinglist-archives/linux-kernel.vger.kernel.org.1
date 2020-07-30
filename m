Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA82330A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 12:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgG3K6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 06:58:52 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42631
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgG3K6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:58:51 -0400
X-IronPort-AV: E=Sophos;i="5.75,414,1589234400"; 
   d="scan'208";a="355625807"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 30 Jul 2020 12:58:49 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Tony Luck <tony.luck@intel.com>
Cc:     kernel-janitors@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: ia64: correct typo
Date:   Thu, 30 Jul 2020 12:17:30 +0200
Message-Id: <1596104250-32673-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace RTC_WKLAM_RD with RTC_WKALM_RD.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/ia64/efirtc.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ia64/efirtc.rst b/Documentation/ia64/efirtc.rst
index 2f7ff50..fd83284 100644
--- a/Documentation/ia64/efirtc.rst
+++ b/Documentation/ia64/efirtc.rst
@@ -113,7 +113,7 @@ We have added 2 new ioctl()s that are specific to the EFI driver:
 
 	Read the current state of the alarm::
 
-		ioctl(d, RTC_WKLAM_RD, &wkt)
+		ioctl(d, RTC_WKALM_RD, &wkt)
 
 	Set the alarm or change its status::
 

