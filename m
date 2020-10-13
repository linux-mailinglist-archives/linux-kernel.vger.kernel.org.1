Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9228CCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgJMLzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgJMLzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:55:04 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81877225AA;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=w9XTQzW+lIXOGTToFt4mfhe3JwT7CZ5RMQX3rwQsPcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4IWZBdLav79IFemdL5iBoB+pe/8Bls7d6ryKfKYMs4tZ4qRLFWbc/3z/owILMWZb
         TPu5pbIgIYrpX2K42t0aLEU2JjklkK0IttwBsqRh1kkdQE7K/r0z/CdpUh5mptat4B
         3DLE3ye6twHTaLmFm/9Cs8Iyxx/yqJHpN13oFyXE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CW9-G0; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 63/80] drivers: core: fix kernel-doc markup for dev_err_probe()
Date:   Tue, 13 Oct 2020 13:54:18 +0200
Message-Id: <e0d6c52c64e11e80514551720f88726581b88141.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two literal blocks there. Fix the markups, in order
to produce the right html output and solve those warnings:

	./drivers/base/core.c:4218: WARNING: Unexpected indentation.
	./drivers/base/core.c:4222: WARNING: Definition list ends without a blank line; unexpected unindent.
	./drivers/base/core.c:4223: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: a787e5400a1c ("driver core: add device probe log helper")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/base/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bb5806a2bd4c..eb5cb88bf194 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4211,13 +4211,16 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  * -EPROBE_DEFER and propagate error upwards.
  * In case of -EPROBE_DEFER it sets also defer probe reason, which can be
  * checked later by reading devices_deferred debugfs attribute.
- * It replaces code sequence:
+ * It replaces code sequence::
+ *
  * 	if (err != -EPROBE_DEFER)
  * 		dev_err(dev, ...);
  * 	else
  * 		dev_dbg(dev, ...);
  * 	return err;
- * with
+ *
+ * with::
+ *
  * 	return dev_err_probe(dev, err, ...);
  *
  * Returns @err.
-- 
2.26.2

