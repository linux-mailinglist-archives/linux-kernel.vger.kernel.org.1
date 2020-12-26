Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A014D2E2E52
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgLZOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 09:07:31 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:51007 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbgLZOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 09:07:25 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D35GC3w38z8v52;
        Sat, 26 Dec 2020 15:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608991603; bh=TEWbuRyr0YPjOJdlBNFwNm7XKYQy6WV0BXEjNpiv67w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=VrSCsha2cyCLjVVBPbwQqLBKmNKmdLUBUYtpu2axSAzAwAf1ZDWco8P+TcTYScR75
         L4FkuYnS7/ivIEuJP5o6KnhVp5jVAfXIzIUe4WjJMSX2TKpZEMV9QPL8ee1fQp3laR
         2KbrpH8sIIogxPDnc+3LaZ1E8PiFtEWUX0r2E/D+siO/eg9wNokmuvNkG5xK52vWHj
         J9VdF+ayAtQASsZntV3s8RISz1vWZdEmGFPTAFBiDUY/TVSrS+JcGy7ol/3FXl7Tuq
         knEN36YpQP2FWU7BpeGSvwkButQqOdIxgyFS50CvFwnvRb0YCmDMKERIwpAVvIxGPf
         zQA1DB7VSvB0A==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1276
Received: from x1.nicolai.tech (unknown [IPv6:2a02:810d:8080:2d9f::1276])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18X8FgN4y+S0hcZaNnR5b1qR1WB6THWK4I=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D35G91Pvgz8spV;
        Sat, 26 Dec 2020 15:06:41 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, joe@perches.com,
        akpm@linux-foundation.org
Subject: [PATCH v2 1/4] checkpatch: kconfig: replace '---help---' with 'help'
Date:   Sat, 26 Dec 2020 15:05:08 +0100
Message-Id: <20201226140511.662368-2-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226140511.662368-1-nicolai.fischer@fau.de>
References: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
 <20201226140511.662368-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All '---help---' lines have been replaced by just 'help'.
Therefore it is no longer necessary to include '---' in the regex.

Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
Acked-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 00085308ed9d..f6fd811c54a0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3323,7 +3323,7 @@ sub process {
 
 				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
 					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
+				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
 					$length = -1;
 				}
 
-- 
2.29.2

