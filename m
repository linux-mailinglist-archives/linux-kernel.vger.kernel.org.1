Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48B28CD77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgJML7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbgJMLyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:43 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA922240A;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=uaW4C+I+Tu+DdiBRbypIkyBAmHzHYL3ISOLOIWi0ZTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jxv7HSmmnfarOXt56K2CKEs7FapeshUVwwY+Eg/bNBHbPnH5QDrnldK3HmzLNxREU
         o/LERtoU/8HVffNjY+mwhgJxynjhTtv+Y1OHasamMFfpR1B+PxjghpnI/3OzKPxqpf
         U1jE57cjdiyKvozL22lnhfM8vANst4qp6a4UiQmw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt4-006CV5-SQ; Tue, 13 Oct 2020 13:54:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 42/80] docs: libata.rst: fix a wrong usage of :c:type: tag
Date:   Tue, 13 Oct 2020 13:53:57 +0200
Message-Id: <854e3df68b24570e9271ebe3fd0d9d8c5470672b.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of :c:type: to reference to a struct member is wrong,
as pointed by Sphinx 3:

	./Documentation/driver-api/libata.rst:511: WARNING: Unparseable C cross-reference: 'qc->complete_fn'
	Invalid C declaration: Expected end of definition. [error at 2]
	  qc->complete_fn
	  --^

Instead, let's use :c:expr: for such purpose.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/libata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index e2f87b82b074..d477e296bda5 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -508,7 +508,7 @@ also complete commands.
 
 2. ATA_QCFLAG_ACTIVE is cleared from qc->flags.
 
-3. :c:func:`qc->complete_fn` callback is invoked. If the return value of the
+3. :c:expr:`qc->complete_fn` callback is invoked. If the return value of the
    callback is not zero. Completion is short circuited and
    :c:func:`ata_qc_complete` returns.
 
-- 
2.26.2

