Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8A222534A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgGSSIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 14:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:08:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F261C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gKFpR8jAPzcYmVRLFz/KkDA7PdkxDdgLZsiVDwET5tU=; b=SLXT6wz61CjPbZIWN1cyqrV2g/
        Ejj3ZUrfnezTDp7Q1IidCJjVt4d2dNY9RL6t2K41cpGsKTZrGwWGyp8jE1YPPAfmZyuUQPLvnSy65
        r6H/EyaaQfHdl7uHLbJTDUe7MuJKDJTepxB7KDDQAwsYtrmqq09Ple4baY5RRogICGQOANUJRYKiB
        Bv9DES0NpM2NlIoWill8700heQlds4VlERuwCpwnVnEKbgDEU2R00sZOFWpltHSyDN9PzCXhDxkqE
        zEUtZGrPqvu9ZL5wC/wuhlMBbjwC7VMPQ7AkP2QSER6QUjrfI7V/e5XMwmsbGDQpb50xgGd32zJg9
        0f9hV/Cg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxDk3-0006D6-KE; Sun, 19 Jul 2020 18:08:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Subject: [PATCH] sound: asihpi: delete duplicated word
Date:   Sun, 19 Jul 2020 11:08:48 -0700
Message-Id: <20200719180848.22572-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the doubled word "of" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/asihpi/hpi_internal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/sound/pci/asihpi/hpi_internal.h
+++ linux-next-20200717/sound/pci/asihpi/hpi_internal.h
@@ -53,7 +53,7 @@ If handle is invalid *pPhysicalAddr is s
 u16 hpios_locked_mem_get_phys_addr(struct consistent_dma_area
 	*locked_mem_handle, u32 *p_physical_addr);
 
-/** Get the CPU address of of memory represented by LockedMemHandle.
+/** Get the CPU address of memory represented by LockedMemHandle.
 
 If handle is NULL *ppvVirtualAddr is set to NULL and return 1
 */
