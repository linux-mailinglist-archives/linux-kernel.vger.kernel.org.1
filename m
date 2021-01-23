Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B73017B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 19:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbhAWSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 13:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 13:43:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF55CC0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:43:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n6so10408096edt.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 10:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HtWUULD+AqAM7T9i0ash0maTbZaHA0HTT6y5oFghtDY=;
        b=cXczeMGfY9s9XYao4Ximr5BQuDurR5O++FPJ+CYgI2f4meOT9bUkkX/WkV34EEYYyI
         ipasFxgoRp66w6x2D7kThbWUTB/8PmKGF8rpEXshlSZnGVQL5hpK1A9jyMiTHZDTihXu
         mbDamduLQEExNeoX7rvfxsXyep38S8ulfE6Xew6HfAjRk+Rr0xdc4FYPUGMWQlftjuEr
         BEnUOvEUrU8y4rkAuSBL5eoUMOlVvPpZYCQhnPBN9c+7RHQ5ApYDu5/ul/RLi650ETBF
         ap/3wb8wZB2ddisIXUbHgNb6uQd6kdYOBFJ78qBt9o7XRDTsRZOrQsfQjgpncUBosolY
         gZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HtWUULD+AqAM7T9i0ash0maTbZaHA0HTT6y5oFghtDY=;
        b=Ard2IQX0qpbnFr/lS1w+5BnOR0PvsHz+yALFXkbUUiOKew/Q8knM40etWkTdeCsoWe
         s9eFwokJgb08MfIsSWuqXebbeniP+nD10z5hwlAw+28AH2HecqhH/iGKTpIS9TU5j7vh
         GKTkkTwIKfEW1fqAy5kGk1yBy4JgXsq0cqGkSe4etBw+SSagz+zwT/HRfhX+1/9SuWZw
         i03iAHewcdAlPDkT/7huy+ypzeK+FNAmnc5i7qUD1PM42OsOgIxzFfWYc1itf7Knfrz/
         SOntVAX+uYL4iauEwNNDvdCtnXmSda+x/2dGnMp+rVSYxyQIf/PvAEk00gSw9bgnJeEc
         psaQ==
X-Gm-Message-State: AOAM5306d8zPDQNWPT+1VKo3VBrvxvKldZOmJ8LPPhuCxtwsnl1jqbLG
        ozwEUZBrYv+NxadApPcgtQk=
X-Google-Smtp-Source: ABdhPJycl+scqeQDd4xouRA/sGeVpcIAvspo6fwlEkJbccyjKk+npd1nlpM3QXSKYpIx8GvsY74Akw==
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr7857015edd.129.1611427383695;
        Sat, 23 Jan 2021 10:43:03 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:78d8:2ef4:5ead:12bd])
        by smtp.gmail.com with ESMTPSA id y59sm8003109ede.59.2021.01.23.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 10:43:03 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kgdb: use new API for breakpoint tasklet
Date:   Sat, 23 Jan 2021 19:42:37 +0100
Message-Id: <20210123184237.6970-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the kgdb_tasklet_breakpoint to use the new API in
commit 12cc923f1ccc ("tasklet: Introduce new initialization API")

The new API changes the argument passed to the callback function, but
fortunately the argument isn't used so it is straight forward to use
DECLARE_TASKLET() rather than DECLARE_TASKLET_OLD().

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 kernel/debug/debug_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index af6e8b4fb359..98d44c2bb0a4 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1090,13 +1090,13 @@ static void kgdb_unregister_callbacks(void)
  * such as is the case with kgdboe, where calling a breakpoint in the
  * I/O driver itself would be fatal.
  */
-static void kgdb_tasklet_bpt(unsigned long ing)
+static void kgdb_tasklet_bpt(struct tasklet_struct *unused)
 {
 	kgdb_breakpoint();
 	atomic_set(&kgdb_break_tasklet_var, 0);
 }
 
-static DECLARE_TASKLET_OLD(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
+static DECLARE_TASKLET(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
 
 void kgdb_schedule_breakpoint(void)
 {
-- 
2.30.0

