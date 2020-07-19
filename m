Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A102254A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgGSXLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 19:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgGSXLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:23 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65416C0619D2;
        Sun, 19 Jul 2020 16:11:23 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n24so10801854otr.13;
        Sun, 19 Jul 2020 16:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ps1bO1kQHItdDmcSsrlnZa+L4139j2nCHXNY+hwPMZE=;
        b=DDVE4yA18ijDFc2YZeKrVyMF2cOx68cBlqDv3E+AILURtRPdCBdILesbumwuVtHSzm
         6mFWq/34asKt+r2lOjzk/OZmNLOTHuy0BP2e/yuUD1ZDEBgulXpfxDA3gc6zvR7Rc+Cd
         CqksVrPFz/6PAqJ8jQAFTJz8iRtk5uCEoMQW79QUhoitLKRMHTdcy4TqQOD0EZCwgWdU
         Z6iZC/YpXbafNWspIdS9FhA1bG4qhxTjoVFqMkpTevrNZUslW9/qeIOs9/CTQuAIhiGT
         8JjqkeJdtNwrDpeAOJlmQVhRLIcRsVAHgSI+iUmG8LTqYpfBzh1GkqUo6DcOPtDVKtRl
         rzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ps1bO1kQHItdDmcSsrlnZa+L4139j2nCHXNY+hwPMZE=;
        b=TVh3E9wm+r0ifXLDAvljaJTsFUy3sFtELIgXokYjeP8OLKf8dTyRhvJnfIIniPNXUk
         D1RDcnogNy4hSitLicZju7X3aElbYQ6HBVGphyIjn6RuGRw25JIoBYEYsL5WNQgwDXql
         NkXj8CEqR8ZLX+AKrztXjKlFhs1/wESTF74r/vdayassiHSZpOSmHhkrNsmt5TIKOmjZ
         y7hBRLFtjDku7BN/0jGU8Tiav9WmEERF/Aadq9ufXWd3vogmHHmyBFzOwmGX0BMEbTTT
         XRLXYqJDKUOWVEggWLp1lpHO3U6hIbi07P+T+j8cWWFh6LFSONJ4abLYUOeOr/ggJGCy
         Rrgg==
X-Gm-Message-State: AOAM530Nn1UZLnEIPSc+iTOOVILyWwFh1UUhaTEEGmEXCBqDOsEC234f
        yKLabPzSyuTVWECzKzfjIys=
X-Google-Smtp-Source: ABdhPJxyWjjS/C2b8OmXwJrCR6YkkiPecMxQmI/MCR9MQXlFVdzbrrSsln/ZX+JC9kZHOVokpsEjxQ==
X-Received: by 2002:a05:6830:4d9:: with SMTP id s25mr18390048otd.153.1595200282814;
        Sun, 19 Jul 2020 16:11:22 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:22 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: [PATCH v5 02/18] dyndbg-docs: initialization is done early, not arch
Date:   Sun, 19 Jul 2020 17:10:42 -0600
Message-Id: <20200719231058.1586423-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since cf964976484 in 2012, initialization is done with early_initcall,
update the Docs, which still say arch_initcall.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 57108f64afc8..1423af580bed 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -250,8 +250,8 @@ the syntax described above, but must not exceed 1023 characters.  Your
 bootloader may impose lower limits.
 
 These ``dyndbg`` params are processed just after the ddebug tables are
-processed, as part of the arch_initcall.  Thus you can enable debug
-messages in all code run after this arch_initcall via this boot
+processed, as part of the early_initcall.  Thus you can enable debug
+messages in all code run after this early_initcall via this boot
 parameter.
 
 On an x86 system for example ACPI enablement is a subsys_initcall and::
-- 
2.26.2

