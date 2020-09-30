Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF427E97B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgI3NZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730230AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EA523718;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472321;
        bh=F/igWQMYF60TqMCX77EDE30gK86DARBWqysFY8IO6a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcVVJt/nEsBa/5LBsgNF5olfu+YdlXPLexRzo6RRafdfznDtj1gpf64DTioKb1KlG
         5UoWKzcFAHFmgcKVxnuf1XTXRScHTSHKSyr6bhOs6GmmqZyUzjCxPxgEU/0zOgQTb8
         mBNN64WI/u2aDt8yZeYIpD7DS5kpYh6sa27d4wbQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6g-001XKB-VY; Wed, 30 Sep 2020 15:25:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 30/52] docs: scsi: target.rst: remove iSCSI transport class kernel-doc markup
Date:   Wed, 30 Sep 2020 15:24:53 +0200
Message-Id: <b79edb39d920b4cd13e0ca2baed20480bc70e501.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already included at scsi.rst. So, remove the duplication,
in order to avoid Sphinx warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/target.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/driver-api/target.rst b/Documentation/driver-api/target.rst
index 620ec6173a93..c70ca25171c0 100644
--- a/Documentation/driver-api/target.rst
+++ b/Documentation/driver-api/target.rst
@@ -41,18 +41,6 @@ iSCSI boot information
 .. kernel-doc:: drivers/scsi/iscsi_boot_sysfs.c
    :export:
 
-
-iSCSI transport class
-=====================
-
-The file drivers/scsi/scsi_transport_iscsi.c defines transport
-attributes for the iSCSI class, which sends SCSI packets over TCP/IP
-connections.
-
-.. kernel-doc:: drivers/scsi/scsi_transport_iscsi.c
-   :export:
-
-
 iSCSI TCP interfaces
 ====================
 
-- 
2.26.2

