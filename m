Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F672E8B4A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbhACHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:51:36 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:38785 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbhACHvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:51:35 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D7rXs7582zPk3y;
        Sun,  3 Jan 2021 08:50:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1609660254; bh=iNOT2JYpTFWhTDjGGfUfeYF9aHjIDqfHF2VFlSHPizc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=oB2bWtucLc1aFEvTPTJUXYcB0VQ69Qtd1gIahagj29rRJ5nmFBtIUuRllY4iO+MNM
         Lck69fWBjw7tEOxGPIV0onfyJ3wLA+CTCzQ26vMFuKMuriGUO2Ts0/Z1tMDtYntO1C
         cJKTQSTxQstUXECsoIpywYXW/Zu9xytYwpfOkll85A9kXp8+YMEQ6KGwiKgJY1svcg
         WVeZTRo8y+A3iRTccNHuMoDb+pbeXFv0vUdoacaNV9/5GTW7o9BaF5+zlwqrMjWwsr
         8nuHci3nOM6SVEEt3hA7DuZ9Uv1gyddjuMHF1h5ELQFXBhjerbeESNXaCxFdCHwlO0
         hcTsxmcoTEVVQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from localhost.localdomain (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18vGxUtu2mJ0UMy7IxlVqK3jCOeLnV2GBU=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D7rXq5VBFzPjhV;
        Sun,  3 Jan 2021 08:50:51 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, akpm@linux-foundation.org,
        nicolai.fischer@fau.de, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH v3 2/5] checkpatch: kconfig: add missing types to regex
Date:   Sun,  3 Jan 2021 08:50:12 +0100
Message-Id: <20210103075015.23946-3-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103075015.23946-1-nicolai.fischer@fau.de>
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
 <20210103075015.23946-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig parsing does not recognise all type attributes.
This adds the missing 'int', 'string' and 'hex' types.

Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f6fd811c54a0..c86a971a3205 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3321,7 +3321,7 @@ sub process {
 				next if ($f =~ /^-/);
 				last if (!$file && $f =~ /^\@\@/);
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*(?:["'].*)?$/) {
 					$is_start = 1;
 				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
 					$length = -1;
-- 
2.29.2

