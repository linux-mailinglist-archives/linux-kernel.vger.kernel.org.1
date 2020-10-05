Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C01283F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgJETMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgJETMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:12:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3765AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ot1efaYDsvjq482gOdoiX5oT+UdfmdDcyr15Je6NkZQ=; b=PpQB70I4VaC3UCCrlmu+5H8l6F
        GOMwcinQddJahEiIJ29fsjwftgacq9j5vKrg1zl2WV+85YUGlQ6azUSjYx+jR3iPqjgeRW05g9WgG
        zqUP21XdU17RacM3lMUi6zuozZL9HABJSW5JZDRzpTlo0w6KMBCiRlITgCvXZMmrO/1G3dZB9Av7N
        WlEXwKqqUm8NlVGswUKe/6+Kf0Qc6EQhhGm1n/20QE8z6wDFH+uLWZBlaojMYNdrqJyU5tEZLHF33
        vl8mXcPNCemn8Sqzq0w90qRTue8o8Jc+vfocE5jKd6pJnn9Pb7auyG+fSFB+ag//kW5TxM43lLMui
        hXDdUTFA==;
Received: from [2601:1c0:6280:3f0::2c9a] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPVuY-00078v-TU; Mon, 05 Oct 2020 19:12:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH] sound: sparc: dbri: fix repeated word 'the'
Date:   Mon,  5 Oct 2020 12:12:34 -0700
Message-Id: <20201005191234.12715-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the duplicated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/sparc/dbri.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-59-rc8.orig/sound/sparc/dbri.c
+++ lnx-59-rc8/sound/sparc/dbri.c
@@ -620,7 +620,7 @@ A circular command buffer is used here.
 while another can be executed. The scheme works by adding two WAIT commands
 after each sent batch of commands. When the next batch is prepared it is
 added after the WAIT commands then the WAITs are replaced with single JUMP
-command to the new batch. The the DBRI is forced to reread the last WAIT
+command to the new batch. The DBRI is forced to reread the last WAIT
 command (replaced by the JUMP by then). If the DBRI is still executing
 previous commands the request to reread the WAIT command is ignored.
 
