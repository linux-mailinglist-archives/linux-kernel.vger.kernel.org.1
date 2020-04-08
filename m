Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEF1A263B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgDHPsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8AD215A4;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=pkQRKk4Q3BJwEsZPq9Rvl8GhUQxw4EhOBSPeWUeyTXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVsYDw/hg1IPkOLfiOqWetfXQhzaJ8qZ7bJQHbLy6BAC9Fa6hVGzFYBXLTOU5Jnhd
         VrLtZCyT8j0ovJNGbnwkz78SjqV/8DtXAdXC15UTBDy8OrQxx8JrIe9KMr0+uXmC5J
         Q/wLE6rbh+xTqCCqrIZ/ZQFSSqO0K/HLYN+W+w+E=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBI-IH; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH 13/35] ata: libata-core: fix a doc warning
Date:   Wed,  8 Apr 2020 17:46:05 +0200
Message-Id: <5fd12ef049c330fe62eb0c23b61e8bea2812e445.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The docs toolchain doesn't recognise this pattern:

	@link->[hw_]sata_spd_limit

As it can't really process it. So, instead, let's mark it with
a literal block markup:

	``link->[hw_]sata_spd_limit``

in order to get rid of the following warning:

	./drivers/ata/libata-core.c:5974: WARNING: Unknown target name: "hw".

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beca5f91bb4c..69361ec43db5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5209,7 +5209,7 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
  *	sata_link_init_spd - Initialize link->sata_spd_limit
  *	@link: Link to configure sata_spd_limit for
  *
- *	Initialize @link->[hw_]sata_spd_limit to the currently
+ *	Initialize ``link->[hw_]sata_spd_limit`` to the currently
  *	configured value.
  *
  *	LOCKING:
-- 
2.25.2

