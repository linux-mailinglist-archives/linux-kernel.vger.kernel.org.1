Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47571A263D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgDHPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:48:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729620AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F34B212CC;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=kEy4QClsDKqYpuy6jSsVkkfgbzM9x8NxA08DUYZUD4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLF4PpVLKQgEDnLiFuvvYM5lBC5QFyyZMVUMwonVPgxMLClLz4EpGaIJ3J85vqcKB
         UXZ96AaqI2utO+Qg8nwHHIOV+uZkusgZycq2y25KeRpptuyhzkytPQIuHnlkB0hNeC
         yTOCYnzfaSVEy3btF5hkKOcCocZP+3opjC2TAWTI=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cB1-ES; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH 10/35] firewire: firewire-cdev.hL get rid of a docs warning
Date:   Wed,  8 Apr 2020 17:46:02 +0200
Message-Id: <9953f9ef2982babd4c6128af4566a8bb3e416fba.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning:

	./include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.

is because %FOO doesn't work if there's a parenthesis at the
string (as a parenthesis may indicate a function). So, mark
the literal block using the alternate ``FOO`` syntax.

Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/uapi/linux/firewire-cdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
index 1acd2b179aef..7e5b5c10a49c 100644
--- a/include/uapi/linux/firewire-cdev.h
+++ b/include/uapi/linux/firewire-cdev.h
@@ -308,7 +308,7 @@ struct fw_cdev_event_iso_interrupt_mc {
 /**
  * struct fw_cdev_event_iso_resource - Iso resources were allocated or freed
  * @closure:	See &fw_cdev_event_common;
- *		set by %FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE) ioctl
+ *		set by``FW_CDEV_IOC_(DE)ALLOCATE_ISO_RESOURCE(_ONCE)`` ioctl
  * @type:	%FW_CDEV_EVENT_ISO_RESOURCE_ALLOCATED or
  *		%FW_CDEV_EVENT_ISO_RESOURCE_DEALLOCATED
  * @handle:	Reference by which an allocated resource can be deallocated
-- 
2.25.2

