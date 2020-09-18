Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDDC26EA64
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIRBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIRBUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:20:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA64C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QOyFuqFuoFRJREXHLPLsv6ehAQxmu8EWM0/aVtAEqw4=; b=ISjWHiWUWdHFNuLhg/4P+KsaVj
        W3yggqcP7tk74LUhe9FEWLBcoUgpoVeK+rpXFFNyRdfJX7zA089py91DqJWqjUjU6SAQ61Bp/xr80
        rdGLvEYfVz3WDTkzVs2QX/MKKKmB21vuCs8cTVPJB1Z0AK75Cr39mCF+2HHI51SZAjfVxzGm2Xrdh
        ZZV+6eQXjW31594qFvQs0NYwdD5VurQy1MkOFpB5YNMj+6q6/TQatYYD++g1DTBSN8gMQey4mmUev
        jb+7IVcrLeFgx18eq83BsgRchv69whQXuOumPeHZGDqzuOA1ZcUWmDa/vrvatCE9WXWIOAHSBWHAC
        3fTKbuAQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ54c-0007sT-NT; Fri, 18 Sep 2020 01:20:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] ntfs: layout.h: delete duplicated words
Date:   Thu, 17 Sep 2020 18:20:21 -0700
Message-Id: <20200918012021.6255-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words "the" and "in" in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Adding Andrew to recipients, otherwise this patch is lost/ignored.

 fs/ntfs/layout.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200917.orig/fs/ntfs/layout.h
+++ linux-next-20200917/fs/ntfs/layout.h
@@ -703,7 +703,7 @@ typedef struct {
 /* 14*/	le16 instance;		/* The instance of this attribute record. This
 				   number is unique within this mft record (see
 				   MFT_RECORD/next_attribute_instance notes in
-				   in mft.h for more details). */
+				   mft.h for more details). */
 /* 16*/	union {
 		/* Resident attributes. */
 		struct {
@@ -1838,7 +1838,7 @@ typedef struct {
  * Also, each security descriptor is stored twice in the $SDS stream with a
  * fixed offset of 0x40000 bytes (256kib, the Windows cache manager's max size)
  * between them; i.e. if a SDS_ENTRY specifies an offset of 0x51d0, then the
- * the first copy of the security descriptor will be at offset 0x51d0 in the
+ * first copy of the security descriptor will be at offset 0x51d0 in the
  * $SDS data stream and the second copy will be at offset 0x451d0.
  */
 typedef struct {
