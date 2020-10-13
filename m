Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58F028C67E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 02:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgJMAvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 20:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgJMAvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 20:51:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E8C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:51:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x7so15727643eje.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 17:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pVrQdjc0e/ktldx4sQZ+nJAJs98miEhGJpNnCH/jdDo=;
        b=G6XN1We55tVJArCgFWhPmvmsjeks6vhOwtKRLW6tc3yQK8EKObUcxeA/vAQA1qq5h/
         MoUmtcWVte7X6Dvz0HDMGz+WvWsMh3kNtVRFwUv+tnfgqzN2ZPBglFay/Q1xoszt2dx2
         jeOVFNJ3PxjEYiixM23UlGWF2AFVG5jY1x1y3bFuBftpJPdq6tSOFzaEOjNqkn7Pqlsn
         SiNc3c+hX6l6x81+Dm5sH9z/W0TaKRgGH7uZNcUMQg+g6FVZw2brATQGbQqLW5yn6iBk
         4Ewxsi/JKN2r8gpFTNayRw+aN87AsluWy/A2ULRYWgYYB0f1362RR+7y3z+qNORumGRa
         wUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pVrQdjc0e/ktldx4sQZ+nJAJs98miEhGJpNnCH/jdDo=;
        b=CXStx+AN9TS4QqvG9rQ15oTiHQf8YbVOk3XTawRoMhvA+SwY5CadXKLNUGsTlnHC1i
         nZfuJTwdaAnHixPGj/Y34QoHGZ4oh+9NDPKFDViwTLtXYOYwbZ61fFhY6w8lfQOORpmU
         IriYe+3K6osS2482C/PMjpbnqHkbV1TWMHhK/l+8LRp41QWs30Pr8WuAV7wGoS2jizz2
         dw8DlEj3r998ofv7pPjxdF2YtMPh1thOeBfusvEWN9AbRNLkgeVAELK32CuoWgUdj/4d
         J3UHBzwWH9SBCt3KpZx0QcYzjMP6hoR9/aaJUjK+NzrxsDJz+Ab6AwgzGdux9dnbjhhk
         K5uA==
X-Gm-Message-State: AOAM531ORe4mHNEeT8ZnafgSMiVQ8BySGKYi+MWcwMlQk3lVyjm0ydAL
        9idAKfm7UYrhSpUa49IPf8CqawOPs2SiwFL5B8VU
X-Google-Smtp-Source: ABdhPJxYgfdVxCK9FNcCuB0YKS3usLBprBSUAoJGvuPI7J/d0z3AQQhqzf8gdJca+E/1DzVdmTvnMhpMBi8w1ri/1pI=
X-Received: by 2002:a17:906:c1d4:: with SMTP id bw20mr30257446ejb.91.1602550293651;
 Mon, 12 Oct 2020 17:51:33 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Oct 2020 20:51:22 -0400
Message-ID: <CAHC9VhTNqnzrtu1DHquVF7kK9v9tCAa8q=V3f9kUZi_nLTzfYg@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A small set of audit patches for v5.10.  There are only three patches
in total, and all three are trivial fixes that don't really warrant
any explanations beyond their descriptions.  As usual, all three
patches pass our test suite and as of a few minutes ago they applied
cleanly to your tree.  Please merge for v5.10.

Thanks,
-Paul

--
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

 Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   stable-5.10

for you to fetch changes up to c07203516439b9cd9f7b3cbed82a77164de5af40:

 audit: Remove redundant null check (2020-08-26 09:10:39 -0400)

----------------------------------------------------------------
Jules Irenge (2):
     audit: change unnecessary globals into statics
     audit: uninitialize variable audit_sig_sid

Xu Wang (1):
     audit: Remove redundant null check

kernel/audit.c | 9 ++++-----
kernel/audit.h | 4 ----
2 files changed, 4 insertions(+), 9 deletions(-)

-- 
paul moore
www.paul-moore.com
