Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3545B2D9E96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440651AbgLNSJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440624AbgLNSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:08:36 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B9AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:07:53 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id 15so20166664oix.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hqM1QqKek5Stjrm2s9QbhrJb51ijk6id9KDJs8a9Grs=;
        b=WZoEYA4q9rA3kw5q0YftWLtidKXiJF09Hrz1wT557UKnRUwiMwz7S2TNSNCXNZoDzv
         ViwJHL4siuujNgH+OD+AIRVskJvpd4kWl0gum8zl4GmN5/9SHl6ps9HKf/M9B8JsmtWq
         9CVPRLmk8p6ah6+hOVzzg47IjmPJIPBSE4H6hAN+A4DzU9eYFwjfZNStZl5ZIeM7+iyc
         JRmo44diyTFTc63qWxhBa4cjU3E1V9oqRnphuSYNTH0avwqsnZrANk9OK7sp7ZWnQtQ0
         IGcoi2hA5jvisz4Bb6IdQDOZ+nyaNswjnuOhoS59X8ghjHzALyYmzTGn6g+pw7H7nw+7
         hVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hqM1QqKek5Stjrm2s9QbhrJb51ijk6id9KDJs8a9Grs=;
        b=m/KQJaZR/WLVKsgi74iPB6D/92qSLd8sCZAD1+qaWzhs2edTP7nVQottke+o/yRj/o
         MaUBSsfPMcpblpPq/WTzXi4L34HJB5y2gdpVuHX0gdCOwizRa8k/0AuXAVvi2Kkoq/+1
         U7rSC0iYzH5EciqDBBj1F4I4w/72gDzRI2AjrdmDon6HsDQJR0feUQZ45wp7A/hq/SIX
         x2VH2Mc0F9N1d3y4WE8gZc2FobRXhkQj8WdT6J308X01ns22cuiF84Cw9x48Y+JzuYRv
         sI7lCY8fH6Gfp7hPx7YGfpuCMp2rAGbr2N7uZEMg4zi6Zov0rCa7XiFBlYxOSjzNjynH
         N72A==
X-Gm-Message-State: AOAM531ugsd/SJTTMRAjZWiXazO2aBGWWcAWil5/c8orOnjI0+G1SpOL
        TRC8r+ko8YjLtIgLiqrNZjY=
X-Google-Smtp-Source: ABdhPJzfSiqe6ltdpwfO5/Va5dTpFhXc03Wu3o1LM44aH+KJMLScTSXpZOKYNIWBuLRTkXGCgw0wdQ==
X-Received: by 2002:aca:e007:: with SMTP id x7mr2338911oig.8.1607969273153;
        Mon, 14 Dec 2020 10:07:53 -0800 (PST)
Received: from [192.168.0.190] (cpe-68-201-65-98.stx.res.rr.com. [68.201.65.98])
        by smtp.googlemail.com with ESMTPSA id o6sm4056123oon.7.2020.12.14.10.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 10:07:51 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
From:   Dave Kleikamp <dkleikamp@gmail.com>
Subject: [GIT PULL] jfs updates for 5.11
Message-ID: <819c9249-ee95-7d67-0577-b9b1f7c09832@gmail.com>
Date:   Mon, 14 Dec 2020 12:07:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba:

   Merge tag 'fscrypt-for-linus' of git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt (2020-11-12 16:39:58 -0800)

are available in the Git repository at:

   git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.11

for you to fetch changes up to c61b3e4839007668360ed8b87d7da96d2e59fc6c:

   jfs: Fix array index bounds check in dbAdjTree (2020-11-13 16:03:07 -0600)

----------------------------------------------------------------
A few jfs fixes

----------------------------------------------------------------
Dave Kleikamp (1):
       jfs: Fix array index bounds check in dbAdjTree

Dinghao Liu (1):
       jfs: Fix memleak in dbAdjCtl

Randy Dunlap (1):
       jfs: delete duplicated words + other fixes

  fs/jfs/jfs_dmap.c   | 10 +++++++---
  fs/jfs/jfs_dmap.h   |  2 +-
  fs/jfs/jfs_extent.c |  2 +-
  fs/jfs/jfs_extent.h |  2 +-
  fs/jfs/jfs_logmgr.h |  2 +-
  fs/jfs/jfs_txnmgr.c |  2 +-
  fs/jfs/jfs_xtree.c  |  2 +-
  7 files changed, 13 insertions(+), 9 deletions(-)
