Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9759E2CF894
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgLEBYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEBYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:24:07 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C0AC0613D1;
        Fri,  4 Dec 2020 17:23:19 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so10205084lfc.4;
        Fri, 04 Dec 2020 17:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=y8ky6Rv6hAa1Gu/ILPlAB7lXWruU4VgldfIMu9D7dag=;
        b=ux14E9SdZPm99PdnA4kCxD1Zl3RU9x8jcTWPQE/tjHNbNGnsjnZBTj5bcAl6qvUTHl
         kCDUYoZ4TUoga9xXYOGZLE5SW7aWKJqQFa+Fmo6MAA7DIIfOFNqeKqDdVxGHmfNDhbKR
         OmpUqGsi3Mi0L5ERBpKr5tgR0Yb1EA7xkfMT7A+6Uaf0GXaIIDn1bkpmXiG/hFoB1ucH
         oEsMrDSMc951GAIYFd/mSg2wZ0uCdwnG1uFURXvr6TvwirogITqZ8QluqthHqSfWu+mR
         54jXmtYn/a4QVw9Hh6LJRT8Macno07+Y3t5hGwmrKTSfmx3r0pU9kZ2NwPrgLHWgqGVm
         dZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=y8ky6Rv6hAa1Gu/ILPlAB7lXWruU4VgldfIMu9D7dag=;
        b=W6Mokn3LFhkICy6nK7DoC1y9E0Op6zBsVkddfLBbtPdVUxrUpMnbc2cFzE1ydmTNQo
         FEZ+GLZdlVuuDPPQE8W5yfWRir8OeSkRtKJHnT2Pr5LhkaCuYSlvaBc+PX7fC8Tp8jW5
         AR3NjH85Yvhw54ITw23m3fjuupyhJPbB0Gu/5JJnlEiczB6iE8CxXRujpSvhpGAURYBL
         WLEC55E9lVa8OYPL8pURY0JYQVrJ7frAXtLy9vlNz4OsHI/qGMdovYb0nlJwUizDKcoC
         cv/tLDjUa1xuZCGyF12VVaqSB47FgSlgvbSSoodthYxgfGA2jXbv0LZkgYi/MDyTV4Yb
         +EyQ==
X-Gm-Message-State: AOAM53250HhBrGOo8Jxwc1uFcNeW+oD8TWwhKrD9lxfZN3GTK0fZ0O6l
        QM6roL44eUK8C4G4S9la7UYMK6SqFHGTgAqnuDqPWeN5X6JEXg==
X-Google-Smtp-Source: ABdhPJx6/P9fszLhqEC6jBgiZZxNsg864C4scTH89lb4fmkNRwC5/T16jICLAfeC+OoFiWrpwNgw6lvDXHTAUpLdWUw=
X-Received: by 2002:ac2:4d0c:: with SMTP id r12mr4220790lfi.47.1607131398313;
 Fri, 04 Dec 2020 17:23:18 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 4 Dec 2020 19:23:07 -0600
Message-ID: <CAH2r5mso+e44kRcGVf4aQ6qc5iwLp4gr6AsQGpLA06phqRA+ew@mail.gmail.com>
Subject: [GIT PULL] SMB3 Fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
509a15421674b9e1a3e1916939d0d0efd3e578da:

  Merge tag '5.10-rc6-smb3-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2020-12-01 15:43:53 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.10-rc6-smb3-fixes-part2

for you to fetch changes up to ea64370bcae126a88cd26a16f1abcc23ab2b9a55:

  cifs: refactor create_sd_buf() and and avoid corrupting the buffer
(2020-12-03 17:12:14 -0600)

----------------------------------------------------------------
Three smb3 fixes (two for stable) addressing
- a null pointer issue in a DFS error path
- a problem with excessive padding when mounted with "idsfromsid"
causing owner fields to get corrupted
- a more recent problem with compounded reparse point query found in
testing to the Linux kernel server

Test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/445
----------------------------------------------------------------
Aurelien Aptel (1):
      cifs: add NULL check for ses->tcon_ipc

Namjae Jeon (1):
      smb3: set COMPOUND_FID to FileID field of subsequent compound request

Ronnie Sahlberg (1):
      cifs: refactor create_sd_buf() and and avoid corrupting the buffer

 fs/cifs/connect.c |  3 ++-
 fs/cifs/smb2ops.c |  4 ++--
 fs/cifs/smb2pdu.c | 71 +++++++++++++++++++++++++++++--------------------------
 fs/cifs/smb2pdu.h |  2 --
 4 files changed, 42 insertions(+), 38 deletions(-)

-- 
Thanks,

Steve
