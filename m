Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194FE302C18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbhAYT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732209AbhAYTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:51:24 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C60C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JCt8Xz6iMYYmXPAUHZqX3DBBjm5slw3913VPH4LauYk=; b=SaSrZLN8K9AmzmEiVTTHtuO2li
        FWqXP1Z7b9whcLdQ8Rwk8hUDEWtZW5QDigILcgXusCEvfNBX2S1iIhI48Ws8nWA1OZox7YXNlidh4
        ke8enUzMOE1jBpw2YHQHGDVTnmA0wmwNhEQrQN02QEbY9tX7P0iVEtWhwOwskXz0t1W+eHTAOMliJ
        GR8uUPypLCXJGklC7F5vUi2npA8RJ5hzAcmkSU7BUf+LzqJ6oP3WacKDzcsyjzfDAmdSic3TS2nmy
        BOVr7tuWwjcDlVw6+JvnngL08UMmfUnPsH+/yyhin6KLo24oHFtwJug+c2WV14YBSQ2lZFXtCxnqB
        LQaI5ADg==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l47rr-0006un-3u; Mon, 25 Jan 2021 19:49:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND2] ntfs: layout.h: delete duplicated words
Date:   Mon, 25 Jan 2021 11:49:37 -0800
Message-Id: <20210125194937.24627-1-rdunlap@infradead.org>
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
Acked-by: Anton Altaparmakov <anton@tuxera.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Andrew, Anton asked you to merge this patch:
  https://lore.kernel.org/lkml/7CF99C49-7EB0-455C-808A-72EA117E113B@tuxera.com/

 fs/ntfs/layout.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/fs/ntfs/layout.h
+++ linux-next-20200717/fs/ntfs/layout.h
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
