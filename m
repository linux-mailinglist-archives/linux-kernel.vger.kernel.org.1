Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0AC224E63
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGSA3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgGSA3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:29:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C9C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PERUINphtkMIddRrqlYQzda0H+1HP2xVgzAXTTB4OIE=; b=h+xF67E6eHKndXF6XjB9EpXh+8
        0a16P9iHHbeOmfPrA2MuMOXVcO31LCPoxaTLaAl9IbwKvkuych8HznPZgIinyfgdDacmXVtEb1URK
        5W4MEVOL7wpR5yMUUy0VRXngg3KPsYsu4/xowmxXMsqHQm8cHgPHRG39F74dPu2jJZrgIu7lDWPks
        0Ho4BZbQ1n3UmVgO1+d++VUX16OqSMmtZuvkNxe18u6WyS47Cj9WTrE0BcB4pn3my2LsNbVWCHZxu
        4O/uv+hdGPskgvX9YMyevilX9Hdm0KmXxM1ogurlPWWQF83drvawp+naSC2qujlNqEoRpk7bsni2a
        BLHbGxUA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxD9-0002lO-Bo; Sun, 19 Jul 2020 00:29:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: mic: <linux/mic_bus.h>: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:29:43 -0700
Message-Id: <20200719002943.20624-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mic_bus.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/mic_bus.h
+++ linux-next-20200717/include/linux/mic_bus.h
@@ -6,7 +6,7 @@
  *
  * Intel MIC Bus driver.
  *
- * This implementation is very similar to the the virtio bus driver
+ * This implementation is very similar to the virtio bus driver
  * implementation @ include/linux/virtio.h.
  */
 #ifndef _MIC_BUS_H_
