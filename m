Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF22CB829
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgLBJJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgLBJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:09:21 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805DDC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:08:41 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r20so658369pjp.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mcUM6oeEmRge/4wz3fLnB/v0v3NUBVG/sr+eT0f5yE=;
        b=K+6yaLfjFFmoCPFG2eFHLYhErQC5d56aj03yC7JvGWi6qAxOrZ/En3fsSQJpOpoFqU
         b1ajv7az/h7vDJlwK5wmU2x7QoFx3Ukt18CDtNI6OS1bi6gBcLzD+a6eKYfDx88RqVR1
         G2Z2iduixYkMK9m3t014zntz19Yd+7pGunLlA9qCOmXRiVjSgaO35FgP4cEevI7UuicS
         DoDBucfGOlSDrlaF2/tMBzuoqJrpazXF9k5erzqkgE1p5mtzTDDjadd6MsSuG2rhGsBw
         T7LgRy3jCKA/lkbwnyUPGH2thOK8l8QTYJPPY8GGIhRCyjcPWR72s2BQFNDcUlgvc++F
         6AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mcUM6oeEmRge/4wz3fLnB/v0v3NUBVG/sr+eT0f5yE=;
        b=CI6GNxP/l+ir2f//55mi7+P1D7Q0SgiuF4eaRsDghrj4/v3KIm7rMGQyvbS0zJWWdK
         YR0oQ/OiIIuZ2tLYXpY8L37Z2juSE0zytsIBwIYpb2HggUYLBu6zLizAmezD9gStWHIS
         u3Pg743sMTdb9Tg03ujeIN2/Ob/01P9M0aPQZnFPXcLfbmV8fP6YV59w3KKcP+3PvfyH
         J47wxmWKgP614ksyl2Y27p6/BpclnBGV2e8cZp+It6toIEkPn734OriNt8IPsQFGPMNi
         MYqBHow7XFUaGhg1J9qO7n5ymUDg2UFH8xhikMzI4pvoS4ksOEJALxHi4g2+MRwk3uAi
         UqtA==
X-Gm-Message-State: AOAM5313LRE+ALhR2k+op9aFeDX7Y6U+tutyLznk2tFCupyIFkYI2V6l
        FPnSJO0Z4fAWl3YW1RAwRI4=
X-Google-Smtp-Source: ABdhPJy6/quREt9/+mnXIv96ZPnZKmwPzXGfnDi4SZh+iljxcsMqy5DD0AHJ7unRABAEltyytAKIVA==
X-Received: by 2002:a17:90b:1888:: with SMTP id mn8mr1572830pjb.158.1606900120751;
        Wed, 02 Dec 2020 01:08:40 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:430:be3c:9984:8aed:2f75:bf22])
        by smtp.googlemail.com with ESMTPSA id d7sm1578010pfd.214.2020.12.02.01.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:08:40 -0800 (PST)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     joe@perches.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] checkpatch: add fix for non-standard signature - co-authored-by
Date:   Wed,  2 Dec 2020 14:38:28 +0530
Message-Id: <20201202090828.12934-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ceb3ffcdae151d6ea1d7f1a45bf61b3d2a1c183c.camel@perches.com>
References: <ceb3ffcdae151d6ea1d7f1a45bf61b3d2a1c183c.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, checkpatch.pl warns for BAD_SIGN_OFF on the usage of
non-standard signatures.

An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
non-standard signatures, 43 are due to the use of 'Co-authored-by'
tag, which may seem correct, but is not standard.

The standard signature equivalent for 'Co-authored-by' is
'Co-developed-by'.

Provide a fix by suggesting users with this signature alternative and
replacing.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 scripts/checkpatch.pl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4a026926139f..fc036d545d2d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2832,6 +2832,9 @@ sub process {
 
 			if ($sign_off !~ /$signature_tags/) {
 				my $suggested_signature = find_standard_signature($sign_off);
+				if ($sign_off =~ /co-authored-by:/i) {
+					$suggested_signature = "Co-developed-by:";
+				}
 				if ($suggested_signature eq "") {
 					WARN("BAD_SIGN_OFF",
 					     "Non-standard signature: $sign_off\n" . $herecurr);
-- 
2.17.1

