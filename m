Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E926128B051
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgJLIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:32:34 -0400
Received: from ns.lineo.co.jp ([203.141.200.203]:47592 "EHLO mail.lineo.co.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgJLIcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:32:33 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 04:32:33 EDT
Received: from naokihayama-desktop (unknown [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id EA91C8035CE48;
        Mon, 12 Oct 2020 17:24:46 +0900 (JST)
Received: by naokihayama-desktop (Postfix, from userid 1000)
        id C94DE50040BA; Mon, 12 Oct 2020 17:24:46 +0900 (JST)
From:   Naoki Hayama <naoki.hayama@lineo.co.jp>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Naoki Hayama <naoki.hayama@lineo.co.jp>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/admin-guide: tainted-kernels: Fix typo occured
Date:   Mon, 12 Oct 2020 17:24:41 +0900
Message-Id: <20201012082441.5831-1-naoki.hayama@lineo.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo.
s/occured/occurred/

Signed-off-by: Naoki Hayama <naoki.hayama@lineo.co.jp>
---
 Documentation/admin-guide/tainted-kernels.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index abf804719890..f718a2eaf1f6 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -130,7 +130,7 @@ More detailed explanation for tainting
  5)  ``B`` If a page-release function has found a bad page reference or some
      unexpected page flags. This indicates a hardware problem or a kernel bug;
      there should be other information in the log indicating why this tainting
-     occured.
+     occurred.
 
  6)  ``U`` if a user or user application specifically requested that the
      Tainted flag be set, ``' '`` otherwise.
-- 
2.17.1

