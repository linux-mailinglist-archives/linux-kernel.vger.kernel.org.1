Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F08283F5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgJETMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgJETMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:12:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684BC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4qwGoWMDW+eDJ7rMkFSl3AojjjIn6fVSxG9MxGWKgck=; b=wsbqVU22bJNIPJDvhKodU7Rc7y
        zrzunvZlJaCrlf+a7WJGeh7HLvIXiJ8+nbMvUB4Um9dx8JIi5tyG5rFRcJxALEC5IetzhmKs3UPzy
        1Y0BRMlZ7avfz8/2A4xFr4gYlzdraCBQWqd4+lzYfG2rJ+Vt2T4aRlhRvEeG19nu4KdYTt9Ed/CpR
        Sl24wJSyxL8iP9ZZkPgskIa1qLRhvLM7GGiJAavf7KH6tDRHxHP9YRvsgcW46VWQXHAXfhKVdfBbv
        lOGeLm9UnnNrS5oyxKKchzT3uoL8k7p2u73qUh3ZMhNOk4h2dT/ZgIPzQGAdO2I4lr3PEcFoJQB7u
        nWe2/CAQ==;
Received: from [2601:1c0:6280:3f0::2c9a] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPVui-0007AD-Mg; Mon, 05 Oct 2020 19:12:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] sound: usb: endpoint.c: fix repeated word 'there'
Date:   Mon,  5 Oct 2020 12:12:44 -0700
Message-Id: <20201005191244.23902-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the duplicated word "there".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/usb/endpoint.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-59-rc8.orig/sound/usb/endpoint.c
+++ lnx-59-rc8/sound/usb/endpoint.c
@@ -318,7 +318,7 @@ static inline void prepare_inbound_urb(s
 
 /*
  * Send output urbs that have been prepared previously. URBs are dequeued
- * from ep->ready_playback_urbs and in case there there aren't any available
+ * from ep->ready_playback_urbs and in case there aren't any available
  * or there are no packets that have been prepared, this function does
  * nothing.
  *
