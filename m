Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6802C2C2FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbgKXSYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387957AbgKXSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:24:34 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBF0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:24:34 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id w189so17868971qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=bd5sh7vQZeJyURROHVUKNFVm+4CMC4yXrKfm9zRiuIw=;
        b=jtRiTvw4fvJnd8DziMdUXlCVFNCxntTtTEvtSJrNcKeRrhRHR3K7WGYLLYdsza+f4N
         N/uGa/v/4xLQsMFh7RsLQiVtuG/ZXSiTDwH6O+ALWJbcqXrWWWwQ7Gc3tJtunK/zjxFr
         kjgSye0YAVBFhS8TrvTa2ZNIRGGM9akI1KCkUnPoOJRydoP2jYuYYYxq98bhA6Y81soc
         ttScEDR4AP3UcSRGoypJccYQb0thq5eHpjV/mV59aLdmw6NAp3epLeksBsojGYyXxRF7
         eMEdElBWlvfB35RzG0ijynD/W1zGbtLcLoSzLCZ6wQSivuIrsUmA438/yMznm0Us/uQn
         X32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=bd5sh7vQZeJyURROHVUKNFVm+4CMC4yXrKfm9zRiuIw=;
        b=fRn3vTd0KW//0P1RnY+sRV6IucfqUQk8d64zAF4hYi6G2klc7Z1zYzajwWSxKO6/KW
         QGXAEKBCtvqrJ5e5Jopneh1Q8ZTK4SpcUJ7D9xlRjFsX2bzkJygjt2Y+imhPqFZCLHYj
         BEQuWuwNyfHl/FqlPyUtSsRBqfoVtsxH7EyAUDs2yvildDvgM3akB9aPCHi8uxPkzlYw
         VVRIUBXK9B+96b8wueTVDGgC/COsaL4ya2jeSK3m+n94fthbrAj/HlIE9qOq3V2jOIKM
         rZkC0g8iTba3SkMbmW3jpbz8ufImCC7tuGzhw3hmBZCl5teszkAF9fGoV0As138qShTI
         HbOg==
X-Gm-Message-State: AOAM533KQB98rPSCTmhM2Oq4/H0AcWLCqxSPaDFhtV+bwqMU/WVtP/yq
        AyIHR5xTTpkDjcjvOR/GQmCp/ucWHGK1
X-Google-Smtp-Source: ABdhPJyWTjMfWiYOVU+tE9pGSMeFoQRdhPtgSC6RhFbVbNV7o45purcv6ubLeMy+ZrK1ckQQwFWmaw6YrQZY
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a0c:eac4:: with SMTP id
 y4mr6136966qvp.19.1606242273407; Tue, 24 Nov 2020 10:24:33 -0800 (PST)
Date:   Tue, 24 Nov 2020 18:24:09 +0000
Message-Id: <20201124182420.2202514-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] modpost: Make static exports fatal
From:   Quentin Perret <qperret@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using EXPORT_SYMBOL*() on static functions is fundamentally wrong.
Modpost currently reports that as a warning, but clearly this is not a
pattern we should allow, and all in-tree occurences should have been
fixed by now. So, promote the warn() message to fatal() to make sure
this never happens again.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 scripts/mod/modpost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f882ce0d9327..70b0e825a139 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2663,9 +2663,9 @@ int main(int argc, char **argv)
 
 		for (s = symbolhash[n]; s; s = s->next) {
 			if (s->is_static)
-				warn("\"%s\" [%s] is a static %s\n",
-				     s->name, s->module->name,
-				     export_str(s->export));
+				fatal("\"%s\" [%s] is a static %s\n",
+				      s->name, s->module->name,
+				      export_str(s->export));
 		}
 	}
 
-- 
2.29.2.454.gaff20da3a2-goog

