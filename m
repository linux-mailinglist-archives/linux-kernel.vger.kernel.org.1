Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064AD27E99F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgI3N0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730272AbgI3NZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:22 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A763223A74;
        Wed, 30 Sep 2020 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=/yU7lDdXaYHcK+bMjDe7N+/1v4CnA3kWBBNj3sy6md0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmYxS/8Ai/jVE6Z7MvKdxYPBMm+MJjk6snYUvxEpgup1cGOP6dFaSRzqUeK4JoH+x
         AX3Efu+/RzqC8aWpkj41jnUP3Q3lQ1Xfx7lWWed+9DHg8tt/1fljSs/W1vdBlXXZGR
         SdGptY/otQzc3JrOZvvRk2/OyXNtuRKbwTIdqLfU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6h-001XKx-OD; Wed, 30 Sep 2020 15:25:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 45/52] docs: devices.rst: fix a C reference markup
Date:   Wed, 30 Sep 2020 15:25:08 +0200
Message-Id: <d9a55318a3c52b860f5009b3144b30697fb85359.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
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

