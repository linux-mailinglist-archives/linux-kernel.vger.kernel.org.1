Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA072BBB74
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 02:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgKUBRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 20:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgKUBRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 20:17:03 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 17:17:03 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id c4so7493865pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 17:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TNX3l7PvITod9AihyAxf0YX+RSr83EEV++pnt+PpErM=;
        b=rrOCXQ7OHW2jSnsjpU3VGkPy5lRIPHSawzigfCWabrgQMh3mtEG1C6BApzF/r0gjgF
         4clCEUnxf1BOe4mR8I5kWg7wy0HmwVHmjKrtnbNFoot7Tvsj40gpwPqfO8IN8b7MeZG2
         bqPpnUwQnSM2aGyQ6PG+Z34sm8Yk0faGb/GT8p8EApc5P9XmwBhnhT3m7z1nfKj9wjKF
         OaQvCEBpUktVLHPL+Iq2BjZ6AejVja8HgvBPrMl2ARQplq1bEtoXejhNWpQnsMzRRFt/
         0Pz5XCiyo03caC30och2sRseMdFSShCMllfY5iBokkvpuGJv4lW/8iymoY64UgUP9FXH
         BG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TNX3l7PvITod9AihyAxf0YX+RSr83EEV++pnt+PpErM=;
        b=bv5ypxoALCpnt82EQAe8dk+fJsn5PtqAvSsG9mXK1ioV90VHnnq/Iu1arqtIcAwyGx
         6AtRGnlPCul1L7QfBvSN2C0/Z4qeLMauq4aBCStgDrw2N9uogzz/ooLHtiCT/Ct6Q2q7
         iC8i5idDQ6yyBSzOr8vabo2WFllb2o9NSVSdRc0eZOrtuwtAaLTnbgo6BcUZRfhf8Utr
         /lT07SFQFacpVGr9yqdwntuwz6TrvQtuLah0ePyy1GQ7yYsjStr8odeU2OJuwhRuhYS0
         zhdhPCfgOHpn8UXUk+9GLECABd1I6/lgoBzip2/caqoJPxvynaDrymQsHVNC7N6UhcwY
         /LEA==
X-Gm-Message-State: AOAM533J1prqw9AkG+CCB4dxiJ5pqxJ69xiKcGHWjmr0ekjDNVz+ThmB
        uShaGYlkFBV+qAA7dUqnSPxW8+JuX3Bya7wBEmw=
X-Google-Smtp-Source: ABdhPJzueX8rS/Go8MrAki9gFw6IiZ0+350kHGHWwk5pESmHkMzUcrIPdQZ4dtHkeJw75qDmUFBpmPd7X/xPFksqBUQ=
Sender: "willmcvicker via sendgmr" <willmcvicker@willmcvicker.c.googlers.com>
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:902:bf48:b029:d8:abd5:7670 with
 SMTP id u8-20020a170902bf48b02900d8abd57670mr15224060pls.85.1605921423003;
 Fri, 20 Nov 2020 17:17:03 -0800 (PST)
Date:   Sat, 21 Nov 2020 01:16:50 +0000
In-Reply-To: <20201121011652.2006613-1-willmcvicker@google.com>
Message-Id: <20201121011652.2006613-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20201121011652.2006613-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 1/2] scripts/setlocalversion: allow running in a subdir
From:   Will McVicker <willmcvicker@google.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@google.com, Will McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting the scmversion using scripts/setlocalversion currently only
works when run at the root of a git or mecurial project. This was
introduced in commit 8558f59edf93 ("setlocalversion: Ignote SCMs above
the linux source tree") so that if one is building within a subdir of
a git tree that isn't the kernel git project, then the vermagic wouldn't
include that git sha1. However, the proper solution to that is to just
set this config in your defconfig:

  # CONFIG_LOCALVERSION_AUTO is not set

which is already the default in many defconfigs:

  $ grep -r "CONFIG_LOCALVERSION_AUTO is not set" arch/* | wc -l
  89

So let's bring back this functionality so that we can use
scripts/setlocalversion to capture the SCM version of external modules
that reside within subdirectories of an SCM project.

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 scripts/setlocalversion | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index bb709eda96cd..cd42009e675b 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -44,8 +44,7 @@ scm_version()
 	fi
 
 	# Check for git and a git repo.
-	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
-	   head=$(git rev-parse --verify HEAD 2>/dev/null); then
+	if head=$(git rev-parse --verify HEAD 2>/dev/null); then
 
 		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
 		# it, because this version is defined in the top level Makefile.
@@ -102,7 +101,7 @@ scm_version()
 	fi
 
 	# Check for mercurial and a mercurial repo.
-	if test -d .hg && hgid=$(hg id 2>/dev/null); then
+	if hgid=$(hg id 2>/dev/null); then
 		# Do we have an tagged version?  If so, latesttagdistance == 1
 		if [ "$(hg log -r . --template '{latesttagdistance}')" = "1" ]; then
 			id=$(hg log -r . --template '{latesttag}')
-- 
2.29.2.454.gaff20da3a2-goog

