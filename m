Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1505227E9A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgI3N0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730263AbgI3NZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:22 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A642023A6A;
        Wed, 30 Sep 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=mf156XDS+RQ7mgP8yKK2xLh7kHg77GTlwBg64jsL3eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQtb8IK3FbSBPPWh7EUUGDTwR/GAKGsda61wD5jvsCnnKhVxRM/olzlVe7cNmM2m7
         KsN6STQVOt+0ZN9P9IW5OpWxhp0ze/38UefLDPfL8BhTuLIuE1+zURhw8bnle3yUrL
         6vNIYwDzUShR76/PDeEHOdMzsLsLaXYE83MN7LHs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XL3-Qd; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 47/52] docs: mei.rst: fix a C expression markup
Date:   Wed, 30 Sep 2020 15:25:10 +0200
Message-Id: <34a9c9aaf8d5f922eac76fbd66a1a20da6b80714.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx 3.x doesn't allow expressions using :c:func markup:

	./Documentation/driver-api/mei/mei.rst:41: WARNING: Unparseable C cross-reference: 'close(int fd)'
	Invalid C declaration: Expected end of definition. [error at 5]
	  close(int fd)
	  -----^

So, convert it into a :c:expr.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/mei/mei.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/mei/mei.rst b/Documentation/driver-api/mei/mei.rst
index cea0b69ec216..4f2ced4ccdc6 100644
--- a/Documentation/driver-api/mei/mei.rst
+++ b/Documentation/driver-api/mei/mei.rst
@@ -38,7 +38,7 @@ Because some of the Intel ME features can change the system
 configuration, the driver by default allows only a privileged
 user to access it.
 
-The session is terminated calling :c:func:`close(int fd)`.
+The session is terminated calling :c:expr:`close(fd)`.
 
 A code snippet for an application communicating with Intel AMTHI client:
 
-- 
2.26.2

