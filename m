Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCF2FB71A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbhASKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbhASJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:54:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E630C0613CF;
        Tue, 19 Jan 2021 01:53:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f1so6624981edr.12;
        Tue, 19 Jan 2021 01:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/z2s2KReLWcfABIGgx+T2H5a0KcybizOYnqI2zx5L7g=;
        b=JFAufC9TCuGfd1Drt91CAvfcPhG47NLebHKCfVKql2xRiKjEfFFGgHcAbmGjEr+VIF
         7SmyfPNmpGoCDOGlEI/f7KrOQ871aaa/kE5N/JxmVXX3FZChwQViqa0DLCqbCZy24uey
         FXNXql4fjl4DvEe/VJ47Y4UA3KJArzW5hs6WMNEavgYxX/HtpIDlgkdg9O77ycfLf0d5
         PTqVCg1IplPzPCktfSjT71w2OFUACQGZaJ8ibLOk9xL9H/2+c6X5VyF6jvRNts4/UYmk
         imXdCZu3uPEzTIPjYSW6cv8wwi6lxG5RbkMKgEgGX972RD4FqlyK1FbJdc9REzwogODq
         jxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/z2s2KReLWcfABIGgx+T2H5a0KcybizOYnqI2zx5L7g=;
        b=M+e8YC/FznoogW7WsU9TC8L2Wi3aTnnuME0GhWmIwcYPbRT+JIyPVwKRKCaPaNJWv6
         Vmx2AVmJ5eOBq3CbzlOIiP9HygUZGroKYFGFviBoIKMuXpOCPPe9hFjbZxeN53V+dGtF
         ERgfQh2fu2/eIgxqKNXGLsswvzpoBi3WrWydi06ZxWB3FUuHD7Q1RSDGsLszGR1AnWxI
         2E1l7Y6nheUKp6Z/AWByRy9hxi//f/vs5BzUnUucH+gfUY+l+WQLBstZ1v1gaqUkta1s
         NQhjkxd25sVxAy8VlttRNiCs0O49MuMU2fpceUAr7I224+Csfm9aS2mZoNlLBExUWAyX
         u0WA==
X-Gm-Message-State: AOAM533r6zbsvR9dEboyIyOdKn6NWCO//S5CJZUf7nzHktWAA9COCBuf
        PnRPvqPyNIIw0yUbmsWJBvbQKeDFzGcBNw==
X-Google-Smtp-Source: ABdhPJzTvs9qNX1hl10cmUhbLNpnvAeavuosxPgGvXWqx+5jlzBYNsL9oPc5zNREIvn6nAeMASpJxA==
X-Received: by 2002:a05:6402:4d6:: with SMTP id n22mr2813409edw.27.1611050015274;
        Tue, 19 Jan 2021 01:53:35 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dee:e100:71f9:d08b:59b4:3a8f])
        by smtp.gmail.com with ESMTPSA id cy13sm2834449edb.27.2021.01.19.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 01:53:34 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arch/Kconfig: update a broken file reference
Date:   Tue, 19 Jan 2021 10:53:26 +0100
Message-Id: <20210119095326.13896-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit adab66b71abf ("Revert: "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"")
added the config HAVE_64BIT_ALIGNED_ACCESS back into arch/Kconfig with this
revert. In the meantime, commit c9b54d6f362c ("docs: move other kAPI
documents to core-api") changed ./Documentation/unaligned-memory-access.txt
to ./Documentation/core-api/unaligned-memory-access.rst.

Fortunately, ./scripts/documentation-file-ref-check detects this and warns
about this broken reference.

Update the file reference in arch/Kconfig.

Fixes: adab66b71abf ("Revert: "ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS"")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20210118

Steven, could you pick this fix to your commit or, at least, ack it so that
Jonathan can pick it?

 arch/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 24862d15f3a3..dc104b8270c0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -156,8 +156,8 @@ config HAVE_64BIT_ALIGNED_ACCESS
 	  accesses are required to be 64 bit aligned in this way even
 	  though it is not a 64 bit architecture.
 
-	  See Documentation/unaligned-memory-access.txt for more
-	  information on the topic of unaligned memory accesses.
+	  See Documentation/core-api/unaligned-memory-access.rst for
+	  more information on the topic of unaligned memory accesses.
 
 config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	bool
-- 
2.17.1

