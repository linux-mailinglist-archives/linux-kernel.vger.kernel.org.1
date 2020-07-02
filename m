Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA1212FED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 01:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGBXLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 19:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:11:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C458EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:11:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so13132929ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iQrFRXDP8rXNHQcWYNSe+JctoXgQP0kT+O7TInIWU9c=;
        b=TOMWbjMVIn9IVlD4bOb95+46duntSSoLV3Mv7jyub3f5t7xZRuZYtqM1tZnvlTq7c4
         o1k76FNodOrAj9t5WHLJnboL+oVusERVKKzsVYYUxjz2kqS8DgevhJBZjn5WqsEd5Odi
         P5s0GhLQOJIZalykBXi7fbt6fT7s+Z17L21v+cpvDzEI8Z6jZSvK0ICLoQhbYFTUVFV/
         aqDGj1vV3TZ4AU49fZNjQ2qYa/k/Z10fzXxXmnbRGqBa6Rm1KuAPK/3Xg8kUj0g+ekTU
         6J/TIoHXgzkgnF7JNyl8eFb7PKbtp0BZ76cqsEAEaLCAqhLMWjpfvBJrgvEFDSbKZmuS
         no6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iQrFRXDP8rXNHQcWYNSe+JctoXgQP0kT+O7TInIWU9c=;
        b=nk8G0Ju+A4ubQeji7QAjCrRONKzhUr1gv53ty3G4e0uJd4UMmFFlTuZQrmV6sTVY9E
         H0PMJ54hdVF6Be2Cczzz0BgAcyBzNoleGY+LKxp4oPRS03zUs1jgjbOAYOcCanUDfhSL
         Ky6kvkt1OEYXkP9KuF+7z8g89XzRij/cEe0OyeTNnnhgnlUGjbRdbCJdqjSKzRrrEaSN
         FwXOP4TLPiTupksk9oG+mqiNeyIM5InnEASS6uHYfKnPwvrKYqhV85ONWWIBCEDhg92n
         CPafk/dBNqeD9JIRwuSxKbnMr3q+kTANWBxnlbsBAHMusqG6u0DpFjyz77ql1KjmxIPz
         9/2A==
X-Gm-Message-State: AOAM532EEgSMB6PvrJGZgWI+mRjevrWvCek3vP0tE4jjAIdXCbRpbPGQ
        frj0NqZ8QWdRz1ItLDjBD9+7uytN
X-Google-Smtp-Source: ABdhPJwlo+4YWYopbw0PHWtDBiItabn2pgOPb1Y41N6EutYSdZ2SYWvnZruVlmAGv/3KS3xbXcKrCg==
X-Received: by 2002:a17:906:3984:: with SMTP id h4mr23306251eje.254.1593731469288;
        Thu, 02 Jul 2020 16:11:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:bd38:c82d:5283:9f1])
        by smtp.gmail.com with ESMTPSA id x9sm8214031ejw.28.2020.07.02.16.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:11:08 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/15] options: make Wsparse_error less special
Date:   Fri,  3 Jul 2020 01:10:28 +0200
Message-Id: <20200702231039.55015-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
References: <20200702231039.55015-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-Wsparse-error should not be enabled with -Wsparse-all, this is
special cased in the condition in loop handling -Wsparse-all.

However, the condition already handle warnings forced to off.
So instead of explicitly checking for &Wsparse_error, it's enough
to force Wsparse_error off.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index 43d55a0648ee..9acdc60fc416 100644
--- a/lib.c
+++ b/lib.c
@@ -276,7 +276,6 @@ int Winit_cstring = 0;
 int Wint_to_pointer_cast = 1;
 int Wenum_mismatch = 1;
 int Wexternal_function_has_definition = 1;
-int Wsparse_error = 0;
 int Wmemcpy_max_count = 1;
 int Wnewline_eof = 1;
 int Wnon_pointer_null = 1;
@@ -296,6 +295,7 @@ int Wshadow = 0;
 int Wshift_count_negative = 1;
 int Wshift_count_overflow = 1;
 int Wsizeof_bool = 0;
+int Wsparse_error = WARNING_FORCE_OFF;
 int Wstrict_prototypes = 1;
 int Wtautological_compare = 0;
 int Wtransparent_union = 0;
@@ -793,7 +793,7 @@ static char **handle_switch_W(char *arg, char **next)
 	if (!strcmp(arg, "Wsparse-all")) {
 		int i;
 		for (i = 0; warnings[i].name; i++) {
-			if (*warnings[i].flag != WARNING_FORCE_OFF && warnings[i].flag != &Wsparse_error)
+			if (*warnings[i].flag != WARNING_FORCE_OFF)
 				*warnings[i].flag = WARNING_ON;
 		}
 	}
-- 
2.27.0

