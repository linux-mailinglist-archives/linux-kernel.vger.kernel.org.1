Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78AB284D03
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgJFOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgJFOD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:56 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB66235F8;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993035;
        bh=/yU7lDdXaYHcK+bMjDe7N+/1v4CnA3kWBBNj3sy6md0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdDegMP0mkdehRnjZZa15TtzOWud3y76vwTrkmnZ2bRB6gPCaCBKFK5k6E6GI/oi+
         H0mlwtmMlNOxU4RMWAHBB1Qb/6AtnX3lnTizJucgimTmURHztpOedoeUuWQW3TaajP
         N0+nKdmfGSiZdjZbAlovBSZxTgzzyE8IsA0uE0Ew=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019GY-TA; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alex Deucher <alexander.deucher@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 45/52] docs: devices.rst: fix a C reference markup
Date:   Tue,  6 Oct 2020 16:03:42 +0200
Message-Id: <1e8e06cf23a519116a882888475d37dfc5ab49b2.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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

