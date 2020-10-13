Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59528CD41
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgJML6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbgJMLyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:45 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D8E2242E;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=/yU7lDdXaYHcK+bMjDe7N+/1v4CnA3kWBBNj3sy6md0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAnH7Eayr+ddM55jTPRixsxKygdnedNBoPC/UiLVlj6peHYBJpxChjPfq4f9/aowj
         A3Uhlm2wcb3c2Njvokqi9vZHzg1LbEHP/YHSzl73n5hWR4CiAzLmCQrdeR9MetOPTR
         nZdC/WJ+2GXPDr3aRALwGx7XuVo/l9o8OPypp3Sk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CVC-VY; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 45/80] docs: devices.rst: fix a C reference markup
Date:   Tue, 13 Oct 2020 13:54:00 +0200
Message-Id: <5d8db6b471801d324bfe1f36bc1ff317c8ad0306.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C domain parser of Sphinx3 expects just function names
for :c:func: markups:

	./Documentation/driver-api/pm/devices.rst:413: WARNING: Unparseable C cross-reference: 'device_may_wakeup(dev)'
	Invalid C declaration: Expected end of definition. [error at 17]
	  device_may_wakeup(dev)
	  -----------------^

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/pm/devices.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
index 4bda8a21f5d1..6b3bfd29fd84 100644
--- a/Documentation/driver-api/pm/devices.rst
+++ b/Documentation/driver-api/pm/devices.rst
@@ -410,7 +410,7 @@ On many platforms they will gate off one or more clock sources; sometimes they
 will also switch off power supplies or reduce voltages.  [Drivers supporting
 runtime PM may already have performed some or all of these steps.]
 
-If :c:func:`device_may_wakeup(dev)` returns ``true``, the device should be
+If :c:func:`device_may_wakeup()` returns ``true``, the device should be
 prepared for generating hardware wakeup signals to trigger a system wakeup event
 when the system is in the sleep state.  For example, :c:func:`enable_irq_wake()`
 might identify GPIO signals hooked up to a switch or other external hardware,
-- 
2.26.2

