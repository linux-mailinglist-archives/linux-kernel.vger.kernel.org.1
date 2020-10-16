Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E790A290AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbgJPRoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgJPRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:44:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E77C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ulZhfOaT326t3jGYse1j4xMTDwyENBzxSWrUOICpdO0=; b=quJJfzfnf2yaTN/ghqHd4IS8j1
        Qr0FYhlAtq0SkYxc82uQo+8qU+XouBmOdnQvkP9GvhrFYQM5liTSxedt1OLPwG5cTb2VvU/4rVZAV
        siLHLWjQnxzlCyWjblJDdOiO3i62CImUeobXVuHg89702qFRSV8lj6qgI6fyV4Z5kHtn2/iEJ4Rdi
        x1MadF5GDGpsBQCWV2JUj6/9CoeVYSVafwO7Xj1KDQp/l20cVWhEyMvV8bHCNn5qK1dYWONPZJR2J
        frmH6ahoMYQNNIuHdrTQ8bk6k2EJrl85ZciACqeg2S39UMEGvw95CWJtZzQx2F0k7+3duyg5SQ5ww
        TJVhEZzA==;
Received: from [2601:1c0:6280:3f0::507c] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTTlx-0002zY-JA; Fri, 16 Oct 2020 17:44:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] sound: sparc: dbri: fix repeated word 'the'
Date:   Fri, 16 Oct 2020 10:44:05 -0700
Message-Id: <20201016174405.17745-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the duplicated word "the" to "Then the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Joe Perches <joe@perches.com>
---
v2: use "Then the" instead of just "The". (Joe Perches)

 sound/sparc/dbri.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201016.orig/sound/sparc/dbri.c
+++ linux-next-20201016/sound/sparc/dbri.c
@@ -620,7 +620,7 @@ A circular command buffer is used here.
 while another can be executed. The scheme works by adding two WAIT commands
 after each sent batch of commands. When the next batch is prepared it is
 added after the WAIT commands then the WAITs are replaced with single JUMP
-command to the new batch. The the DBRI is forced to reread the last WAIT
+command to the new batch. Then the DBRI is forced to reread the last WAIT
 command (replaced by the JUMP by then). If the DBRI is still executing
 previous commands the request to reread the WAIT command is ignored.
 
