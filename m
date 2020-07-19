Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE9225345
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgGSSIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:08:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D589C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=PAx/+9RU+aVAmEL3qldgG4FzyQkJ920RlAj2ob/fuxM=; b=sQC86ok7JRwckcLcDsUe1AIDVz
        wMX5LDzPuVNH5f/HVaQdwuEwRzw/y1SOgd5xTDC88o4Ny6p6vn2wVwdt4ptD1vUw7VhxFn2kkJdy6
        Nx5Ss4u4TC9j5GP5i3Eu/UDhdq8esrZLqzy3CQgfRYclsFYUp+qvNt3Ok39556LKlrlreQX+aDXPs
        Oz8i3nhvllRgNdb9x6Tv1DyL26qcsOgMJjSgeu91pY5WxSe/zgDfw40Fqti1I4hrLUgAjttRsL3Cf
        r2oDX1pKvkvZieVAsxEBJvx1C7HsHWWbR5KI5/ekY24uXeP0LFifMQmYImHyfnRPcGoo9tiofXFFj
        bBEHrxIg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxDjS-0006AC-G9; Sun, 19 Jul 2020 18:08:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH] net: batman-adv: types.h: delete duplicated words
Date:   Sun, 19 Jul 2020 11:08:11 -0700
Message-Id: <20200719180811.11964-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the doubled word "time" in a comment.
Delete the doubled word "address" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
---
 net/batman-adv/types.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/net/batman-adv/types.h
+++ linux-next-20200717/net/batman-adv/types.h
@@ -1492,7 +1492,7 @@ struct batadv_tp_vars {
 	/** @unacked_lock: protect unacked_list */
 	spinlock_t unacked_lock;
 
-	/** @last_recv_time: time time (jiffies) a msg was received */
+	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
 
 	/** @refcount: number of context where the object is used */
@@ -1996,7 +1996,7 @@ struct batadv_tt_change_node {
  */
 struct batadv_tt_req_node {
 	/**
-	 * @addr: mac address address of the originator this request was sent to
+	 * @addr: mac address of the originator this request was sent to
 	 */
 	u8 addr[ETH_ALEN];
 
