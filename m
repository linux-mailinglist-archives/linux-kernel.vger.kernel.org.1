Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0C28CCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgJMLzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgJMLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:41 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7821322266;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=F/igWQMYF60TqMCX77EDE30gK86DARBWqysFY8IO6a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXV6E+DvbTXkjZ4Ma5DtaTtmwSoBZi4Il/AJHjrh+pg0r1VmC++QRFv0d+j4u5f/e
         6wJ0x55v6vO+tPRYjiU/LlQq0fS4PDvkU/cbghZhEPVtfGG2g59fYzvkAoILGXsm9r
         e+UKlnoNCiSCdBasFFBtCml7D+GqZJsHZjzwWs2k=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUY-GH; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 31/80] docs: scsi: target.rst: remove iSCSI transport class kernel-doc markup
Date:   Tue, 13 Oct 2020 13:53:46 +0200
Message-Id: <8084da7084af1a3e9b0d2aa4e59d85d0805f2a7a.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
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

