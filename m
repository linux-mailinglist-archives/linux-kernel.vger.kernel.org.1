Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44E263353
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgIIRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 13:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbgIIPuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:50 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F18222246;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=hi1aczpcTujPkeB1XjLIT9pw1YvDNzWxbCRXWh+zmzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PAOPNSU7PZLRYcxfKYvB6irFXTnLKl4yDt4ElhNaFw5wkAlcG+iuAQRNH5/eZF33m
         Bnee4+mzj+gSc5XZTe8tG1zUFTHkV4EFZuno5Jo77PCiPis5xvkTlI12K9q5kpjkP5
         6GhYI7BH8CygUJ5tkt4YoCd7BceJdY/4/vCcvHK0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUXh-OS; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] docs: admin-guide: net.rst: add a missing blank line
Date:   Wed,  9 Sep 2020 16:10:56 +0200
Message-Id: <6207e85187596f1de4f178414f741965e32f4b7d.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing blank line after a literal block, which
causes this warning:

	Documentation/admin-guide/sysctl/net.rst:303: WARNING: Literal block ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/net.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 57fd6ce68fe0..f2ab8a5b6a4b 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -300,6 +300,7 @@ Note:
       0:    0     1     2     3     4     5     6     7
   RSS hash key:
   84:50:f4:00:a8:15:d1:a7:e9:7f:1d:60:35:c7:47:25:42:97:74:ca:56:bb:b6:a1:d8:43:e3:c9:0c:fd:17:55:c2:3a:4d:69:ed:f1:42:89
+
 netdev_tstamp_prequeue
 ----------------------
 
-- 
2.26.2

