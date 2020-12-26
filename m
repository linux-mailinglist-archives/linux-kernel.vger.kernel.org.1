Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286F62E2E51
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 15:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgLZOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 09:07:30 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:54687 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbgLZOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 09:07:27 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D35GF6033z8v55;
        Sat, 26 Dec 2020 15:06:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608991605; bh=iNOT2JYpTFWhTDjGGfUfeYF9aHjIDqfHF2VFlSHPizc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=WtPgKxr/RH5oq7vdj/FReTaWhdk9xRre+ow4OqD18naiNVF+wxNEgQdDTbfmAeI4v
         cNhOjBeI6sOZSb+aKGy9QLNwkmrq4AvRFZ+SZSdM8Wpqe1LjeUHoXXS2zfH1O+GYtx
         DG0YJbbL7hJCDF8bJrpGdCBjE/MbP7tpANlQLcUF8s1efio4RfE+x5Y7cmiDOlXylI
         AEZ3paEuURuKsrEAaszSR/fu7sthAmbIPW/uyK6/F+xKQzJtr7dQSxRrFkgd8kfzI0
         vrG2ney8fDCq/PMfr2+FBx0CfgI5OR1/PRG94yCUS5iHLJzkZ5nYHNxwJ2R9DsUkpu
         Qt19//xkerekg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1276
Received: from x1.nicolai.tech (unknown [IPv6:2a02:810d:8080:2d9f::1276])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18/cHYsg9HsPckpzoqh40FeRv/9Kt6DISQ=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D35GC3W3Jz8sYn;
        Sat, 26 Dec 2020 15:06:43 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, joe@perches.com,
        akpm@linux-foundation.org
Subject: [PATCH v2 2/4] checkpatch: kconfig: add missing types to regex
Date:   Sat, 26 Dec 2020 15:05:09 +0100
Message-Id: <20201226140511.662368-3-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226140511.662368-1-nicolai.fischer@fau.de>
References: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
 <20201226140511.662368-1-nicolai.fischer@fau.de>
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

