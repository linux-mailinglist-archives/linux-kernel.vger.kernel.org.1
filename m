Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ECB1EFDC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgFEQ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 12:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgFEQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:27:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34029C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:27:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i74so8725984oib.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsghsgs3o6p26cXTJcYADQy0fn2tlURxksrc3R6HUEs=;
        b=BGrxrWRBEaSLYtrFAOo8azyZv0IQuPz3+69bUtcuLmUYdIT9tVStkf+06TJQV764LP
         FI3ECni5kt5IjzsI/B5VX48P3SiWLJqJsVS8bULhvh3Oqnnvjh96RmbptaKdUMFg1kg8
         01IfriBDRX2MjUMxNEzA2ClbcWYokzpm9aEcL6ooG1qvyvQGS+y3y6/HVvWdfxb1nJNj
         c2nxEjqdGaha+o3kMyI1uccqJ5gSkY0BQ5A8Kuglij337mzrpMrt+kSaiegUW4+kDo+k
         xXyJDLNRabNXCwP7uk5NyJcauUH95KiurbWQzVJf9TMQuW7j4g1ttHHhTbRZL9eNxZwz
         hXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsghsgs3o6p26cXTJcYADQy0fn2tlURxksrc3R6HUEs=;
        b=Sl5IFvUCyxUBJ+/mSjfypdVV4DZWNNCV67jqhXlhrXdjNZsio/C7DfjdPgXWLNmTFx
         Vj68xsrekOCcAmB/CKwyCi8TBLQiK/kJ++8zteHcZG+4pavvZH5yecuWiy09ckt7fUNO
         Diu6AvCHMBOsBEHQx/fit6TbW/34jv/lnf0tKpe47sjJ5qYmEX3x+qT3eP7GOUC1gaCQ
         64X0eyiXF8SFFgx8tTAlNvI6O2C/n16SDA+UEEUNkFAkrPonV+EvhNqpjjXATfqxvuwi
         EYD6JvpVnx6Kz7665YxylTJmN0yFhQ0HiNejjLpJkDw3IPY+YtQIoP/fC3HkH3CLBrfs
         bEtA==
X-Gm-Message-State: AOAM531TjG0fF+3ZHf6kXZzOAMQVXwAHdU/wH+8ulKtY4RRwUmaU/CdD
        JNLp3GbIWgjLShe9GfkwvmIVawX2
X-Google-Smtp-Source: ABdhPJxrM/8cSVClnS7UxWOtZqFaF8PseHPl+2ZlqzYbTVYdYMhjRKDIOOVgBH67l63041CqIUN+2w==
X-Received: by 2002:a54:4795:: with SMTP id o21mr2321606oic.74.1591374452565;
        Fri, 05 Jun 2020 09:27:32 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id z13sm813894ooa.28.2020.06.05.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 09:27:32 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 02/16] dyndbg: drop obsolete comment on ddebug_proc_open
Date:   Fri,  5 Jun 2020 10:26:31 -0600
Message-Id: <20200605162645.289174-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605162645.289174-1-jim.cromie@gmail.com>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4bad78c55002 ("lib/dynamic_debug.c: use seq_open_private() instead of seq_open()")'

The commit was one of a tree-wide set which replaced open-coded
boilerplate with a single tail-call.  It therefore obsoleted the
comment about that boilerplate, clean that up now.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8f199f403ab5..b877774dba96 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -853,13 +853,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 	.stop = ddebug_proc_stop
 };
 
-/*
- * File_ops->open method for <debugfs>/dynamic_debug/control.  Does
- * the seq_file setup dance, and also creates an iterator to walk the
- * _ddebugs.  Note that we create a seq_file always, even for O_WRONLY
- * files where it's not needed, as doing so simplifies the ->release
- * method.
- */
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
 	vpr_info("called\n");
-- 
2.26.2

