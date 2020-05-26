Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E80F1D7092
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 07:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgERFzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 01:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgERFzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:55:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C2C05BD0D
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:55:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so4515936pjd.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APDZcTihvmp7cHgWc/okOQoKAjV6ESC0p6FoG4/I2RA=;
        b=B9zQ4JN8AYIxyezeNdzE6GbwPImYuyTUTkgaOcnyMLt8drlkAFBp16GCi7zqrrzQLS
         8cfO9dxZUQ1n2upwY50jdxeXPLHMYTEgyOk5KPR1DbyAlCJGW0UAcLW7PB3jp/iRXGsT
         B9XN9hHhnUnR6ItW4QHqc4AmFpJzkGeqGudHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APDZcTihvmp7cHgWc/okOQoKAjV6ESC0p6FoG4/I2RA=;
        b=j1bsj+F7y85Om8RBkC+SINSndIcQxVqw0TiQVg49L1mRa74VV9aqRlKFlrfk95tX6R
         5O9UCvHLjGSz2Vlt7MleexMGINaQpmYz0O9IKM0aKGMNwNZCmGKH3AmAK1Rxz7BBTgQs
         nSK0RR+wypBkIG82sJ1Go4jFcSZJWPTRFwzmkOIN3pvsXPWzlGPkUVG9v2uw4Li/Y/A1
         R0x8rz0E2m1AIpvSr5N97ASIkofefAhu8GVbdhn6SpPiu+THTVejkQ1s9bVVs0qd1aSi
         CHobTv3//jRNiVDzl/Us+djumeY9kqhUNuMkK26udj7HKnkwzmZiL79yhB+1O+HLj/VS
         2ODQ==
X-Gm-Message-State: AOAM533UeFBmhxtxAgHQu4KzLPpV2agfp2vsIisiGzwpGNGQoBdabuIj
        IESI6oyNRZDnKfVIllQP+ofIuw==
X-Google-Smtp-Source: ABdhPJxQAZtu/2s0TyYmdgb6LuY/0MGp2laY52exkkKqAzqWmG8gDpAARGenRF6/As3BMdDnDVFHyQ==
X-Received: by 2002:a17:90b:3650:: with SMTP id nh16mr16068611pjb.135.1589781305588;
        Sun, 17 May 2020 22:55:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g14sm6734674pfk.174.2020.05.17.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:55:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Relocate execve() sanity checks
Date:   Sun, 17 May 2020 22:54:53 -0700
Message-Id: <20200518055457.12302-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking at the code paths for the proposed O_MAYEXEC flag, I saw
some things that looked like they should be fixed up.

  exec: Change uselib(2) IS_SREG() failure to EACCES
	This just regularizes the return code on uselib(2).

  exec: Relocate S_ISREG() check
	This moves the S_ISREG() check even earlier than it was already.

  exec: Relocate path_noexec() check
	This adds the path_noexec() check to the same place as the
	S_ISREG() check.

  fs: Include FMODE_EXEC when converting flags to f_mode
	This seemed like an oversight, but I suspect there is some
	reason I couldn't find for why FMODE_EXEC doesn't get set in
	f_mode and just stays in f_flags.

Thanks!

-Kees


Kees Cook (4):
  exec: Change uselib(2) IS_SREG() failure to EACCES
  exec: Relocate S_ISREG() check
  exec: Relocate path_noexec() check
  fs: Include FMODE_EXEC when converting flags to f_mode

 fs/exec.c                | 13 +++++++++----
 fs/namei.c               |  5 +++++
 fs/open.c                |  6 ------
 include/linux/fs.h       |  3 ++-
 include/linux/fsnotify.h |  4 ++--
 5 files changed, 18 insertions(+), 13 deletions(-)

-- 
2.20.1

