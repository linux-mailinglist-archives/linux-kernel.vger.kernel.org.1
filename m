Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291B928CCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgJMLzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgJMLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5CC2226B;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590080;
        bh=KEhDi0VPgM7hCIhR/9xG2Kx3ZY+OBLtU3k7jdAK2xak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLm8tTqYOQA5HWI+r/o6a5WGTp0MOxUGtCsqVWL2O+24u6RA/BYf1Y331b1IT1+nS
         GeikgOGMsz5l0Sr28egd7y+h08ihUq+/MVvl14Jth+UAGDW2nqNFrEdI5ir/+2pJTC
         vGT5XCme+7pnb8mfD0pwWJCXK/ZsMHyG8fEKIKW8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CUb-HA; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 32/80] docs: device_link.rst: remove duplicated kernel-doc include
Date:   Tue, 13 Oct 2020 13:53:47 +0200
Message-Id: <837e18d5315072ed35298c7b10d36a28b25c9ed5.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infrastructure.rst file already includes the external
symbols from drivers/base/core.c.

Duplicating 3 functions there causes namespace collisions:

	Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
	Declaration is 'device_link_state'.
	Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
	Declaration is 'device_link_add'.
	Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
	Declaration is 'device_link_del'.
	Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
	Declaration is 'device_link_remove'.

So, drop the reference, adding just a mention to the functions
associated with device_link.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/device_link.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index 76950d061632..ee913ae16371 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -317,5 +317,4 @@ State machine
 API
 ===
 
-.. kernel-doc:: drivers/base/core.c
-   :functions: device_link_add device_link_del device_link_remove
+See device_link_add(), device_link_del() and device_link_remove().
-- 
2.26.2

