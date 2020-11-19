Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2922B9387
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgKSNO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgKSNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:14:25 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70939C0613CF;
        Thu, 19 Nov 2020 05:14:25 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id j19so4180748pgg.5;
        Thu, 19 Nov 2020 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=y39Ja2Qa+p03XEnu3YP7k8KD0CyXh3oLYmik5VnqQLk=;
        b=bTyNnkBySDQVrsd4b1nzl2+6VTopPh8yIZSxu/mVi46eMI2/wbHEgidQbJlfH1XkKC
         /RI/t9gk29e64kidByzhHiBM0m28q+BnK5X4zPEy1v7lLj62UBznWAVhXL6I1iJJGcpA
         ZBRdWpj5u9Y1E211iG9NkevS8yWY7qCxsFc3VLw9AGBUXNhXAPBbONKcMGv2r91Ect6N
         5RtxQlyNBtTIvAYcDoPHUAi8CUOIbz5QsmqIxwkhY1+vSYwu0LVQPWuazBxCtAB6//IV
         JVw5+fgrw0kfB340cpTCMW1v7XMYmbBVzPqLHIDEABtoapm1kaJ11iM0tOu8lzB7sMuJ
         bxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=y39Ja2Qa+p03XEnu3YP7k8KD0CyXh3oLYmik5VnqQLk=;
        b=E/hySzQ+IzRnhDEOH9lCSfPVJx0JFK63iRRtWprkslqYlm9uLpO5tPFt6vzM6EYJ2v
         4PimJ9mdav6QrqbsbpdirbKjzyrZ8Io8LQ9U6ILScR4k+epWOeNJQpS+ymuuZNZRxAYk
         f/HSVkEgMJ8xaMi70wSrw0JdbwTwfIjc+TfTarRn4zbv72JtrKBDUay9QTJEtTYgjoE7
         2TMiQAnMXe7bNRcZxYmv3cC0+OncCNyEs2kRNB174lOq7tED+7Eh3lAfR7t6rcv0hG1c
         9/2XSJzCxEavI5RWZGUgLi7ZDWLZM1V4VWc98ayiXbiQ80eAzuxXLn9L9KFFmrzltUvQ
         6fZA==
X-Gm-Message-State: AOAM532Q6tjB1TwlcYw0W0bSDt0HSJeDyqWg9CZF86mbnoq0Q7IRsqLX
        BeLeqfPX1+fzMmboy+y+THE=
X-Google-Smtp-Source: ABdhPJz7MdA1FnKj4U1mGcgh4hr8O84BT6MlKvOaenxlYMFBIb+X16cP7QwujL2rK3DkCnb+rrY9lw==
X-Received: by 2002:a17:90a:b782:: with SMTP id m2mr4608363pjr.185.1605791664993;
        Thu, 19 Nov 2020 05:14:24 -0800 (PST)
Received: from adolin ([49.207.204.100])
        by smtp.gmail.com with ESMTPSA id m2sm5218994pgv.0.2020.11.19.05.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 05:14:24 -0800 (PST)
Date:   Thu, 19 Nov 2020 18:44:19 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, cocci@systeme.lip6.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, Gilles.Muller@lip6.fr
Subject: [PATCH] Documentation: Coccinelle: Improve command example for
 debugging patches
Message-ID: <20201119131419.ygiqhzg5cezif5ow@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify Coccinelle documentation to clarify usage of make command to
run coccicheck on a single file.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..9e60cf175fd6 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -224,7 +224,7 @@ you may want to use::
 
     rm -f err.log
     export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
-    make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+    make C=2 CHECK=scripts/coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" ./drivers/mfd/arizona-irq.c
 
 err.log will now have the profiling information, while stdout will
 provide some progress information as Coccinelle moves forward with
-- 
2.25.1

