Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ADE2D36D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgLHXVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbgLHXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:21:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD7DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:21:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d4so368882ybs.20
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 15:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RkYejoYtU5rEdTUD5zzQDLUD6flQABfm3pjNRsDWnhw=;
        b=U5jd0SnK8ncssMH6v/nbhguQppOaI8JiKuk9Ope2/lds+NhUYZVeczzm4aKDm7vacL
         /3v0b1uPLR0A442K/bHuhlCr78ePFZUI9kpvrJhLpzwlbewFy+/uc9EU8iRFbuPvyMoj
         j7YLNxsTnlczNG7HHlA/wdbUNa7NyTDh6cxs/DBc77ePrKXnfFvInz7fupfr8zhgDDKh
         RE4nPUQD8u4jbOXTBxGRM9mZ2BEH405BL2sb6o/Bdmg2WgZLHuNoe5aUG4bE7iP0zbjf
         DUefTH2XxEQvl/4KCV0sQLhZgE80NEqtoy8eGzHkKjAHFTYkdpVzcQtoJYnNUkb3Mli/
         zeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RkYejoYtU5rEdTUD5zzQDLUD6flQABfm3pjNRsDWnhw=;
        b=J1yG9y5eTcN+t31TDanCnNxIpBbYHAP1N2cGW/OsBjdkwGqeFVoVIH3R48sXAo0aR9
         4/gJ2WNwa7LyfSYgEeYcPMIRze+moG7eTXmD0+tUzHiS6Ulw9ih+8fnKKc1VHEmrdUMp
         2+M3FEkSCmEjNI4QeaqrZjsJikz0zH2a7VF+7IJGsuGFamVg4ygbHCiGybfdv1ADRCd8
         eZU17GsUyKKSGLZGowjJ1ZcsM/R2RjZR7wqrNQq/W7SDjWZRejc6TtXUg1lrFloKvCU2
         AgSMOkEIKO097BHE75dt2N/A//1h3NZJH1s30ADQsYYCP57hAOZeWRzLpQjZfJ8g9/EL
         1/VQ==
X-Gm-Message-State: AOAM533mLv/uWVzd6v4HHiQANG20m/WfTqwYnF0IdfSddNJ/zF/dRSF3
        R3GC0U3pLKcL2pKJPcpSAL1PESc65qq6Wg==
X-Google-Smtp-Source: ABdhPJwOpnOwA59Us+sn/RxLRTa0nbDwj11pBl1GRIuAuovOsQgC4EAD/SxKC4Xjk1mXBodRpjQV9l9rMcUmWw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:5f49:: with SMTP id
 h9mr25542601ybm.99.1607469669726; Tue, 08 Dec 2020 15:21:09 -0800 (PST)
Date:   Tue,  8 Dec 2020 15:21:02 -0800
Message-Id: <20201208232102.339587-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] kunit: tool: simplify kconfig is_subset_of() logic
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use an O(nm) algorithm* and make it more readable by using a dict.

*Most obviously, it does a nested for-loop over the entire other config.
A bit more subtle, it calls .entries(), which constructs a set from the
list for _every_ outer iteration.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_config.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 02ffc3a3e5dc..f1101075d458 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -40,15 +40,14 @@ class Kconfig(object):
 		self._entries.append(entry)
 
 	def is_subset_of(self, other: 'Kconfig') -> bool:
+		other_dict = {e.name: e.value for e in other.entries()}
 		for a in self.entries():
-			found = False
-			for b in other.entries():
-				if a.name != b.name:
+			b = other_dict.get(a.name)
+			if b is None:
+				if a.value == 'n':
 					continue
-				if a.value != b.value:
-					return False
-				found = True
-			if a.value != 'n' and found == False:
+				return False
+			elif a.value != b:
 				return False
 		return True
 

base-commit: c6f7e1510b872c281ff603a3108c084b6548d35c
-- 
2.29.2.576.ga3fc446d84-goog

