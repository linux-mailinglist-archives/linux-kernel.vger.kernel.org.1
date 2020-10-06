Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BE284D44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJFOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgJFODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:55 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4075821974;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993034;
        bh=F/igWQMYF60TqMCX77EDE30gK86DARBWqysFY8IO6a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keEzqcQknvLrceO3s2G2btbl/vPA2BY2g/E3SeZQDPBFkpnvwnNU+xc9JzFkEPMB/
         VhX7chkJRW51JPxZ/tmtX0bLeQ6joVdTv3AE1sE0AR47aoMerQSdh6DAZCxqcyt9Vh
         Cdf7diX0Sxy9XlPWa20KbgVH9QWUMKIIDZ7S9dS0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZI-0019Fp-CA; Tue, 06 Oct 2020 16:03:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 30/52] docs: scsi: target.rst: remove iSCSI transport class kernel-doc markup
Date:   Tue,  6 Oct 2020 16:03:27 +0200
Message-Id: <620534cacc8090a67c43a4998e7039e4030e8835.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601992016.git.mchehab+huawei@kernel.org>
References: <cover.1601992016.git.mchehab+huawei@kernel.org>
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

