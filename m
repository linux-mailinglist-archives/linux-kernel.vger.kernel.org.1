Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE37322044F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 07:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGOFXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 01:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgGOFXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:23:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BEDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HXh3ski+GPcGZpvJ68cKeSX8JRfurQWDErJFFmRJGeg=; b=BAxPo9MnajgoZdIO8PwLphY/qr
        8t2T/7knbH63dDEaFnE9kDzUlLPRHzN3jNlg9NQRMjoikd3/+CAsxqkrHEqr1av/yjXWKL/VIbps/
        S4EOTAAmcaYdtGc7ctlc6E9OoeUqT/TJ//lnfBAyEG9aRHGagotNllFmG9I2W81ZjoG+tWbndlqt2
        31eGzF4IHaSKdGEIVNgfRBf50V9s+TDL4jGk8OkP+Yk+0la/xxSW63O6kRTq8EneCrEKLYdQK7pKD
        hXXige4rGDEW3IDBQeY28bDuQViKSH8Bf7gkRAL3sKlFDv+/iVsB7XTP8UwSWn54zst0qBwNfXsJ8
        yaz9JT5Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZtX-0006Vd-Th; Wed, 15 Jul 2020 05:23:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/7] drm: drm_atomic.h: delete duplicated word in comment
Date:   Tue, 14 Jul 2020 22:23:43 -0700
Message-Id: <20200715052349.23319-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled word "than" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/drm/drm_atomic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/drm/drm_atomic.h
+++ linux-next-20200714/include/drm/drm_atomic.h
@@ -103,7 +103,7 @@ struct drm_crtc_commit {
 	 *
 	 * Will be signalled when all hw register changes for this commit have
 	 * been written out. Especially when disabling a pipe this can be much
-	 * later than than @flip_done, since that can signal already when the
+	 * later than @flip_done, since that can signal already when the
 	 * screen goes black, whereas to fully shut down a pipe more register
 	 * I/O is required.
 	 *
