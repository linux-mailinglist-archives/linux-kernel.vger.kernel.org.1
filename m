Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB2271E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIUIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIUIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:55:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C3EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:55:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 7so8420793pgm.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmCn5vOKz8H6U5hdnAJ3cL1ug+bt2KAFmZOtUuB/JUM=;
        b=ZyQf3hoXqTydB3dwB2Cja6PaaTTT69mUNmDEzXdGk2LsZrbC/+viWG4DgI5ZdW18iL
         Ucw1klDOpt9whPgMftqZitC5fJFHqGsfQeOZYiG9kvT4o+/E1XjDSeBg4hFS2Je/eDtX
         qo7tvCOSDjgCcDXqK6JTNUZO0jk0qaxmVmD7zeB6IXIoSajsmAEhOyp5iiITH5xEkMFM
         9CvES7ov4LZOlNDny1IQ3DBzfX7/q+jc365viuul3UhIAkeafDR2S1YPss0MF586kOgz
         7IzZyNvjjio32XyR91WzsmylMfbgD0dxNp4+ig6n+x4sxhUHTxDdAEYIjKZ00NKyGh5N
         XjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmCn5vOKz8H6U5hdnAJ3cL1ug+bt2KAFmZOtUuB/JUM=;
        b=CoXDBULplykb37FSP4Uxjct9iH7vPAQchnCaxWbyDwEmLM57sFq618YP3SJOWwWksL
         6mKezSDfyH0Kb2//uyqpJqk3TGdjs+STcdGFZxCX1UtHbkC1QviCqPmismyruRQ48+n/
         EUmGMhcRQqaIi0dY4WzUVMf1LgBdd9WHUojFkCEaaseCnNSRYybhlj82Zx3lgoLECA/+
         KqyFeQw8nvGyEPTmAqFPnvoPd8fgvhRHvPKU+DPxFTi3RgCdj+mhD9T0jJ1o+Cmkp6ba
         ln8GIRcni5cjhrfvYxvgkv9pPPppAseQgMp2v7/H85VQ2e54iwHIb53xHC6efx3DDBBi
         vnEQ==
X-Gm-Message-State: AOAM530u9pstmgZQ/pgieRh6CSNusDFgzywAF64tw+u33pvVlOWiTwij
        RJP2iCERqwytYvwlSRUaGZI=
X-Google-Smtp-Source: ABdhPJwNIS+f1pLqc8PxeUKxyiWNS30Ht6l2/58kvVWVED2slhSbfH22NPMmUiaVz+IF/AlsdA7LHg==
X-Received: by 2002:a17:902:d909:b029:d0:cbe1:e716 with SMTP id c9-20020a170902d909b02900d0cbe1e716mr43828585plz.36.1600678511222;
        Mon, 21 Sep 2020 01:55:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:606c:9848:4bbe:6238:289])
        by smtp.gmail.com with ESMTPSA id gj6sm10080572pjb.10.2020.09.21.01.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:55:10 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     akpm@linux-foundation.org
Cc:     dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: extend author Signed-off-by check for split From: header
Date:   Mon, 21 Sep 2020 14:24:35 +0530
Message-Id: <20200921085436.63003-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch did not handle cases where the author From: header
was split into multiple lines. The author identity could not
be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
warning.

A typical example is commit e33bcbab16d1 ("tee: add support for
session's client UUID generation"). When checkpatch was run on
this commit, it displayed:

"WARNING:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal
patch author ''"

This was due to split header lines not being handled properly and
the author himself wrote in commit cd2614967d8b ("checkpatch: warn
if missing author Signed-off-by"):

"Split From: headers are not fully handled: only the first part
is compared."

Support split From: headers by correctly parsing the header
extension lines. RFC 5322, Section-2.2.3 stated that each extended
line must start with a WSP character (a space or htab). The solution
was therefore to concatenate the lines which start with a WSP to
get the correct long header.

Link: https://lore.kernel.org/linux-kernel-mentees/f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com/
Suggested-by: Joe Perches <joe@perches.com>
Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Joe Perches <joe@perches.com>
Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 504d2e431c60..9e65d21456f1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2661,6 +2661,10 @@ sub process {
 # Check the patch for a From:
 		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
 			$author = $1;
+			my $curline = $linenr;
+			while(defined($rawlines[$curline]) && ($rawlines[$curline++] =~ /^[ \t]\s*(.*)/)) {
+				$author .= $1;
+			}
 			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
 			$author =~ s/"//g;
 			$author = reformat_email($author);
-- 
2.27.0

