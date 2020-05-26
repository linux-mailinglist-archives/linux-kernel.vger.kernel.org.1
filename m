Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4FA1BEA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 23:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgD2Vgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 17:36:31 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:32962 "EHLO
        8.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgD2Vgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:36:31 -0400
Received: from player693.ha.ovh.net (unknown [10.108.57.188])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 1787A8CA3C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 22:58:36 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id AF9A011DB2FEA;
        Wed, 29 Apr 2020 20:58:25 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 2/2] docs: sysctl/kernel: document firmware_config
Date:   Wed, 29 Apr 2020 22:57:57 +0200
Message-Id: <20200429205757.8677-2-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429205757.8677-1-steve@sk2.org>
References: <20200429205757.8677-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16896098430082108805
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeejleelvdefieeiuddtfeevkeegueehkeekvdffgedvhedugeekgfejjeekgfeugeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the firmware fallback mechanisms documentation and the
implementation in drivers/base/firmware_loader/fallback.c.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index b1ad4c86274d..1779455fb2c5 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -265,6 +265,19 @@ domain names are in general different. For a detailed discussion
 see the ``hostname(1)`` man page.
 
 
+firmware_config
+===============
+
+See :doc:`/driver-api/firmware/fallback-mechanisms`.
+
+The entries in this directory allow the firmware loader helper
+fallback to be controlled:
+
+* ``force_sysfs_fallback``, when set to 1, forces the use of the
+  fallback;
+* ``ignore_sysfs_fallback``, when set to 1, ignores any fallback.
+
+
 ftrace_dump_on_oops
 ===================
 
-- 
2.20.1

