Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6852B3D98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKPHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKPHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:19:41 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74DDC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 23:19:41 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so12393332pgg.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 23:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ile4Ueq+/H9c/6jUa0JhYl+yDKP365ziXuBYqJNeYSA=;
        b=JA0DAUBsEcHXWmqdQ3n39F1dG4ciBapQmokLnbyPs9+YFQI/TI5x1RHhdDDGaYeVX6
         U9yut+5D6c1klXCFLHR5So3CcGIWwTneMTAZK/aWoDvEJOzOF/9/ctwPYu8skltM/sb7
         qGnDc/krLon9EaD7C4MsfAtxpW4RhxvypkcAqWXeBaGRBoQ6Z0SLqK09j6gvJ1Hl4XFP
         64lrwyS1z7/QFknaDlOkRKyVdu/kHvvpvnocYtw3HXCltryGqWjBeTWRiYwu6PSQIlYr
         /R0JLthmSd/75GWl1B4uEw8ORmo2wKh19UzwfG5g0wJ2CSbaXJLjKgc9IMRDD3I5hGPP
         cwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ile4Ueq+/H9c/6jUa0JhYl+yDKP365ziXuBYqJNeYSA=;
        b=N3k1CFZInCU/HckJf18IRMujJlXvVgxV413Dpq0hPNlxN0/QeHuw1NxS3qobhr60VQ
         nNHMiUcNEPZZNrUpWlpIykFl/aHYvb73CzvubaLH/2uQOqWFH5RFgw/92m2RPuWc0sym
         nOs8eyvTeQ35OaKi8RAjAPDZ32VFtLi2co4OvG0/FPc9iSP1+cum5aNulu5p+hnuQ5u5
         tBy5QuG1zzKZjD9GIzTomzMSWbzqiP+ivlCUixPRxbHx84KNQuP41qR5sPBw9A1+xmeG
         EWSF4WKS4mtqHtwQuqnVrS19SIIx6MROAhO+ZLIYpn9P44IORFBxV2fiDuC4Ax7MiIfD
         R3zw==
X-Gm-Message-State: AOAM532L0ajvItZwFyAYpEs/+FrnAqsmL4u3GDwTBpHggljSWa/f3l3N
        rTYzQdl1E+cbbgqV3kw8xlY=
X-Google-Smtp-Source: ABdhPJxHTMwYDWcUfrvbDbM3Sq5ARMULdkdn2bGTpryXXxout4M6vS1+u+JMvdz3frmMtGuGYhxMEg==
X-Received: by 2002:a17:90a:ca0b:: with SMTP id x11mr14352394pjt.155.1605511181163;
        Sun, 15 Nov 2020 23:19:41 -0800 (PST)
Received: from localhost.localdomain ([42.111.137.21])
        by smtp.googlemail.com with ESMTPSA id t13sm5030298pjq.15.2020.11.15.23.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 23:19:40 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: [PATCH v2] checkpatch: add fix option for MAINTAINERS_STYLE
Date:   Mon, 16 Nov 2020 12:49:30 +0530
Message-Id: <20201116071930.7733-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch expects entries in MAINTAINERS file in a specific order and
warns if the changes made do not follow the specified order.

E.g., running checkpatch on commit 6f736909f0a4 ("MAINTAINERS: Add
patchwork link for PWM entry") reports this warning:

WARNING: Misordered MAINTAINERS entry - list 'Q:' before 'T:'
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
+Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/

Provide a simple fix by swapping the unordered lines

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
modified commit message

 scripts/checkpatch.pl | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2749f32dffe9..c9aaaa443265 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3299,13 +3299,22 @@ sub process {
 					     "Unknown MAINTAINERS entry type: '$cur'\n" . $herecurr);
 				} else {
 					if ($previndex >= 0 && $curindex < $previndex) {
-						WARN("MAINTAINERS_STYLE",
-						     "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
+						if (WARN("MAINTAINERS_STYLE",
+							 "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev) &&
+						    $fix) {
+							# swap these lines
+							$fixed[$fixlinenr - 1] = $rawline;
+							$fixed[$fixlinenr] = $prevrawline;
+						}
 					} elsif ((($prev eq 'F' && $cur eq 'F') ||
 						  ($prev eq 'X' && $cur eq 'X')) &&
 						 ($prevval cmp $curval) > 0) {
-						WARN("MAINTAINERS_STYLE",
-						     "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev);
+						if (WARN("MAINTAINERS_STYLE",
+							 "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev) &&
+						    $fix) {
+							$fixed[$fixlinenr - 1] = $rawline;
+							$fixed[$fixlinenr] = $prevrawline;
+						}
 					}
 				}
 			}
-- 
2.17.1

