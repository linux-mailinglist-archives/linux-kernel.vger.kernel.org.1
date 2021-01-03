Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4172E8B49
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbhACHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbhACHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:51:34 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B17C0613C1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 23:50:53 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D7rXq65bpzPjlR;
        Sun,  3 Jan 2021 08:50:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1609660252; bh=TEWbuRyr0YPjOJdlBNFwNm7XKYQy6WV0BXEjNpiv67w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=AKtwNi7zDMNbbxZDj0py8w+D2THva4KJoJKAnTcQP+0rcQJNP9L/4CBijlgvnxbIG
         DivUjKomd4ocU+XcmjXeb/DI/fJPLIp9rMwqq38wzNL/omSYVaXQhG8bwQWv71r2sd
         4l+M1TPvVxsrjcZItbDh0YBAe0rzsJOQXPaBZ0P15DGL4i6QIv+0fuX84wcyyMMRvQ
         CgjNQAggC2Di2y7SAbvMQAHaE3oE/VfOwaanw1C/mqwBDduJiKKHFjsPAmunWNacvL
         Nxb9yKXb/IgLchEii8q1WNeB806C4XEDT2QkVnEKtregeh8oqL5fJfoAXZUiDN5q2U
         GkxHcGjDbN4Cg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from localhost.localdomain (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+pCKFbAtdRbo0VPCqOutM7NclDWA3FUWA=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D7rXn4gwpzPk0d;
        Sun,  3 Jan 2021 08:50:49 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, akpm@linux-foundation.org,
        nicolai.fischer@fau.de, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH v3 1/5] checkpatch: kconfig: replace '---help---' with 'help'
Date:   Sun,  3 Jan 2021 08:50:11 +0100
Message-Id: <20210103075015.23946-2-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103075015.23946-1-nicolai.fischer@fau.de>
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
 <20210103075015.23946-1-nicolai.fischer@fau.de>
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

