Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC6D2D332B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgLHUQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbgLHUN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:13:29 -0500
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E93C06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:12:48 -0800 (PST)
Received: by mail-ua1-x949.google.com with SMTP id o5so4509292uad.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8F5s/OTyeDmdpMoZD83j1erdf6ekhgr72UZMkH/5UoY=;
        b=lBOev2SDljNxiUdbmPcqRW0kyvrpZBpN+7hHq1RdTPZZ+DlwBYU9Gsp62/a30ZSdIX
         7Fsx2yKXeBoP9qmFtxxMGvAFD68VLBB3/60ahPV0FE6H2tKgDocSqSvUDQUtGPweCJul
         LId8s496IO/FmlKSPW+1vGi4EYUyyDr69JsSAWxCIGD2Gf76j1hLl5OG+DE8Ctti9t34
         4lTuq5N+4FiE9yr8RXHTtVW83sa79iiwfH8MB6CDPYWS3l1n8uAfeDz0filyyWujONVp
         IRie2RcGGYqDKmjM1krEo1iLtxBN9Cme0SeHwYBwXxwHgXxEju/G+GioquZYBCc5+HZn
         qk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8F5s/OTyeDmdpMoZD83j1erdf6ekhgr72UZMkH/5UoY=;
        b=OhAJEtdOdUqasL1fJXuj0Hcb575x1HJqOWKeFr1AZxeZVagbKpuSpoIK0nqQ4p6A6G
         E8af3xKW87PuztbSnwbMoHdhYPj7kUf8BfuIteS28iYRYfneHGCR+XAWIoswSTGca/sb
         muMK3mS+cbd+L6zpvS0pTTnPE9jdbYekt89C4wzhkUy6198Ss1G2UY+7Y+X9gFLc7/8q
         KcNA+3sb0/BEZ20eNETWDt6Sw1N9y6ticdKPiu25ZWrmU6SdNxzbEt4IMOiDR+kJR4UW
         5j68R33mO+WsKdXLKcQ7MZJ81hWanHTfs73APyCVvb1W75P6heCJGK0BSDks3BV/pIzn
         lxIQ==
X-Gm-Message-State: AOAM533UTUwB9rChw3UXv415FVGQpa+qKiM1XmDhWHTNJnbuydAzM5eD
        tA/WAVWCrLnoUAbECgxEN041Y+/FkalhejnUHQ4=
X-Google-Smtp-Source: ABdhPJygoF1KeHbkdGMneDJT9DRhuQ2L978i7PFBJvZ5V5qsqRRCV4loE0x1P4ZVC+Vkfbg5rZHOOWUoWC6arzhM/dE=
Sender: "willmcvicker via sendgmr" <willmcvicker@willmcvicker.c.googlers.com>
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a25:9d06:: with SMTP id
 i6mr33391943ybp.224.1607457950048; Tue, 08 Dec 2020 12:05:50 -0800 (PST)
Date:   Tue,  8 Dec 2020 20:05:07 +0000
In-Reply-To: <20201208200508.4107399-1-willmcvicker@google.com>
Message-Id: <20201208200508.4107399-2-willmcvicker@google.com>
Mime-Version: 1.0
References: <20201207153116.GA15772@linux-8ccs> <20201208200508.4107399-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v3 1/2] scripts/setlocalversion: allow running in a subdir
From:   Will McVicker <willmcvicker@google.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com, Will McVicker <willmcvicker@google.com>
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
2.29.2.576.ga3fc446d84-goog

