Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480D32D9648
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407049AbgLNKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403999AbgLNKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:25:12 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47378C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 02:24:32 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4CvcvL5M4JzPkXL;
        Mon, 14 Dec 2020 11:24:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1607941470; bh=vLmHwyjVR3cGo8R3haiwkpdJDcdXTIM/h6lcdSnDy24=;
        h=From:Subject:To:Cc:Date:From:To:CC:Subject;
        b=oJmZKtUoeqdTUZKyhYoz7IjJlJUNs5/qIuCrSuhaL5IAxSMU03AI8hjeTkIex2RNe
         3G5z/x/0/yXt3unbw2LXzAybCXWZofEcRDYHYDC6c5iY5Vlf/fj0sQbfqNFvHvm7vN
         iklfSUuDRCWoYz5cqVSS9PYYa+JvVkyGG/xoesDEHKplajyLZ2yL5HcOC7a9nzFLOX
         VvuUkWs2V425US77ko2b1PLwuG7W1CfGjNywGTdUZzURbeX2i55ngj8d+zpxzUsrLc
         v9KRMcRqHqh3pFuFTQCEOek5iLXviba2PXI242XzwSGIsttn8J1F2eD9tNzBx9F2Do
         OeI6LSFZxcEZg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from [10.21.2.135] (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18EA+q0+mlMHVxP9GULIaYVhnBjFcKkn9s=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4CvcvJ3x8XzPk0M;
        Mon, 14 Dec 2020 11:24:28 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
Subject: [PATCH 2/2] checkpatch: kconfig: add missing types to regex
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Message-ID: <a9797282-84c3-2c8f-73a0-d751a8201541@fau.de>
Date:   Mon, 14 Dec 2020 11:24:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig parsing does not recognise all type attributes.
This adds the missing 'int', 'sting' and 'hex' types.

Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5cd98f2b75f6..442298cadab7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3321,7 +3321,7 @@ sub process {
 				next if ($f =~ /^-/);
 				last if (!$file && $f =~ /^\@\@/);
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*["']/) {
 					$is_start = 1;
 				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
 					$length = -1;
-- 
2.28.0
