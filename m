Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF02E2E6DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgL2DzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 22:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2DzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 22:55:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DCCC0613D6;
        Mon, 28 Dec 2020 19:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nfSJJiBRRh3gR0oJDJf5MDGnGvnvpbyxOsiI4umA4Q0=; b=RriK5QGVdQwfz6XAzPD2YMGgT5
        4PNhr/Vh4FKKAeKfoUPtG7Zc/ryLfhKfoYVSIcMoJrJC+Gu5PuTPPYUpq0WvHmn73++ehuv098bpb
        RQLXVF7xrPMY2OAnEbqFVW+Y1+I3enmd2JrIGMs0o9KZ6s+W5RiReG6sAK0gmObGpzgWOUJ+t2BBD
        HNR27KM4GLxkL3WBC8AT0fbHoJ/4RekM5KuZqeS+J/YB/v1CDBsAkGE5LJ8LIvolg/FMCW76qSm/x
        JUCmar38OOql1O9ugJ4HpCNZTAbul/gekiwytDKuPAz2rn8jKmjshHtHpbLOyADs6crPQTd/Yhyyn
        l7D5qa9Q==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ku65g-0000j1-HE; Tue, 29 Dec 2020 03:54:33 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Kun Yi <kunyi@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: fix sbtsi_temp Documenation kernel-doc warning
Date:   Mon, 28 Dec 2020 19:54:28 -0800
Message-Id: <20201229035428.31270-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Documentation/hwmon/ kernel-doc warning in 5.11-rc1:

lnx-511-rc1/Documentation/hwmon/sbtsi_temp.rst:4: WARNING: Title underline too short.

Kernel driver sbtsi_temp
==================

Fixes: 6ec3fcf556fe ("hwmon: (sbtsi) Add documentation")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kun Yi <kunyi@google.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
---
 Documentation/hwmon/sbtsi_temp.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-511-rc1.orig/Documentation/hwmon/sbtsi_temp.rst
+++ lnx-511-rc1/Documentation/hwmon/sbtsi_temp.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
 Kernel driver sbtsi_temp
-==================
+========================
 
 Supported hardware:
 
