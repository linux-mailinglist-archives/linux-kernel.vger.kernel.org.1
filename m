Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F416224E6B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 02:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGSAbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 20:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgGSAbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:31:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B6C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JLA3czfYtsJTIItXxzku7s7UZythAu2vs3ASmM3vDxQ=; b=FZkahV+zlzdo1rwpLvS1X5amzK
        eXJUsJBCGw1Y0w0VJMSjoKMhUcKaSuvbpt7g6d/dUnJwPru2SWAvWC5Tcl/9hUqy4rQurmMrnY51A
        yyg2AvppZQmNdVLfhR+ojyU5JowmhiFVWO93tCuQdbCf+z7nr+WIiN694yl9MEi5sjyC97HmcnKH1
        dqHAQ40MYPQT72QTR27ggmkTktvJ/0q0TBwosO28c8uLTrFADAEzmo6nO2gh2QdMRx9tnIm0K3s9Y
        sAAQPENki3Cu+8bErZ0QrusRHt1sy4Mx0nlg/ZF/erl5cgHw5TvGsb4Ib60vbz9AJa/pg4oPhPJGy
        H7Iuy/5A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxEt-0002vw-R6; Sun, 19 Jul 2020 00:31:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] RMI: <linux/rmi.h>: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:31:31 -0700
Message-Id: <20200719003131.21050-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "to" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 include/linux/rmi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/rmi.h
+++ linux-next-20200717/include/linux/rmi.h
@@ -206,7 +206,7 @@ struct rmi_device_platform_data_spi {
  *
  * @reset_delay_ms - after issuing a reset command to the touch sensor, the
  * driver waits a few milliseconds to give the firmware a chance to
- * to re-initialize.  You can override the default wait period here.
+ * re-initialize.  You can override the default wait period here.
  * @irq: irq associated with the attn gpio line, or negative
  */
 struct rmi_device_platform_data {
