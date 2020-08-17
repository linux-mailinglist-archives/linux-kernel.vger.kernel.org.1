Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463E2245D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHQHND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgHQHLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:43 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C57E22DBF;
        Mon, 17 Aug 2020 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648278;
        bh=LpI7CPhlAdoRLmDUn7wNA8GzncD0FgN2SN8GD26o+lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vYILsCgpJj0K51Xis65+jcgRq5tbMQQaDV5NViiJBwJNds6+fZbs5ik5Epj8AaIB/
         Z1SamyVN6SnWtyk7eY3XbVYKJGQVJAUiNIK1Fn0dM9G5ANBTZiVSw6SrezyhjfRU78
         T0LYSX8K7lJ5cK8cdJRGLlTM+o6Zx+ugodPPxAeU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIa-00BdlA-KV; Mon, 17 Aug 2020 09:11:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 41/44] staging: hikey9xx: add a TODO list
Date:   Mon, 17 Aug 2020 09:11:00 +0200
Message-Id: <bf3ebe32125646e0a87a59280392e8c6fda08488.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the things that are needed to be able to move those
drivers out of staging.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/TODO | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 drivers/staging/hikey9xx/TODO

diff --git a/drivers/staging/hikey9xx/TODO b/drivers/staging/hikey9xx/TODO
new file mode 100644
index 000000000000..65e7996a3066
--- /dev/null
+++ b/drivers/staging/hikey9xx/TODO
@@ -0,0 +1,5 @@
+ToDo list:
+
+- Port other drivers needed by Hikey 960/970;
+- Test drivers on Hikey 960;
+- Validate device tree bindings.
-- 
2.26.2

