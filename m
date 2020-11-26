Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A82A2C4FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbgKZH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbgKZH5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:57:37 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B358C0613D4;
        Wed, 25 Nov 2020 23:57:37 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x15so762884pll.2;
        Wed, 25 Nov 2020 23:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AmZyur3dqLRwt7CJZ9S3po1AfiI2akYIsVedoPBwE7w=;
        b=SiXKaMYgvMErrwMXKGeTftOQWdQCu+a9i7O7lFlvF4dznPEEJ5eocPrTSm1EIfSwwm
         CAj+BKOTrwQiqpxmHIdn44ryjPBuB0vdVxBGdYGjZHtDRQuvnht1eDfZHdshBF2Ofq9U
         yKUXRRgNPtaXARZDK4hPq9erJPpJztujgA31U5Qo4DOUVted0BYXv6vJcf986vQ0RTQM
         TtLWahAJjM3lpQZkFgFEg2rXT+w6mpZx47Dx9utPY81q7MNePcFLk8poaLM03Wy+JsvC
         3l+TKUVsFNdnSuDf0XtON6y5VIwSvsBBAycCY/HHtBCwdh/q9+MFmOaCjfGpJ7MrwDxD
         a0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AmZyur3dqLRwt7CJZ9S3po1AfiI2akYIsVedoPBwE7w=;
        b=JOs0aErx/jJDgsqw8sLDwu71VdR77baxojk/Dj5idBy1HT+aGwK+9dSUD7UvY6dqt8
         W4wDceqWZLfoiCGuAtlMDP8YG3quEnOO9IZ70OIEFfRi/61JsjQg7ZL0ib0lNzBn8317
         SAdGCJjFVcK+R4AIlj6lkSo5xreRI+Szyv4crfeu/hG6zo0Rbs1oUFGrcbNn48bYdh1m
         Jv9ZnQQxEgS+mUj/sztYi22PkevPYLQYPz5zfO0akpSTSFIhdv1C/lAc0mfjYbm9ae/D
         QAFwkSrHroWLF22pDV3A6eYcW2d2guLQB7Y1jg9SCSB7oVMnuAdweB3/+gSslA1wSJQN
         OuoQ==
X-Gm-Message-State: AOAM530lnd3eQAzP7zsxX0o8WyxAZiUR7fAiT7tbSmjE4CbMuGxD9cpM
        MNQW4G3qV3xjHllCzNxT+E0=
X-Google-Smtp-Source: ABdhPJz640wG66IGDjYOa+fF/lDDn07TkbqINzHI/+LOB8n1+kd77ugQHZBzK4TP9BeeqV3Taenmpg==
X-Received: by 2002:a17:902:b182:b029:da:d0c:abac with SMTP id s2-20020a170902b182b02900da0d0cabacmr1787002plr.40.1606377456773;
        Wed, 25 Nov 2020 23:57:36 -0800 (PST)
Received: from adolin ([49.207.211.158])
        by smtp.gmail.com with ESMTPSA id fh22sm5726642pjb.45.2020.11.25.23.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:57:36 -0800 (PST)
Date:   Thu, 26 Nov 2020 13:27:30 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, cocci@systeme.lip6.fr, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, Gilles.Muller@lip6.fr
Subject: [PATCH v2] Documentation: Coccinelle: Improve command example for
 debugging patches
Message-ID: <20201126075730.w6brpeuviefmsxhl@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify Coccinelle documentation to clarify usage of make command to
run coccicheck on a folder.

Changes in v2:
- Give example of folder instead of file
- Add note

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 Documentation/dev-tools/coccinelle.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 74c5e6aeeff5..9c454de5a7f7 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -224,14 +224,21 @@ you may want to use::
 
     rm -f err.log
     export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
-    make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+    make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd
 
 err.log will now have the profiling information, while stdout will
 provide some progress information as Coccinelle moves forward with
 work.
 
+NOTE:
+
 DEBUG_FILE support is only supported when using coccinelle >= 1.0.2.
 
+Currently, DEBUG_FILE support is only available to check folders, and
+not single files. This is because checking a single file requires spatch
+to be called twice leading to DEBUG_FILE being set both times to the same value,
+giving rise to an error.
+
 .cocciconfig support
 --------------------
 
-- 
2.25.1

