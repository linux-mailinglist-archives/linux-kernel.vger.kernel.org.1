Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11CF2DC22D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgLPOao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgLPOan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:30:43 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F32BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:30:03 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id q25so27650041oij.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=qvfIzg0tm1m+AFhSUpAZevgD7eFyHsFFNkS9ttpBzhw=;
        b=nxFTfemYmcqfVVLjl2TgjmdpttZMv16V1QEhRs+u7AMK4z2VGIsmNstm6C+OI9rmgE
         XKfJqt+QS0E0EdkDaNoDLKTSNj/2H6VXH+TOZxaMFcNewd5yFSr5U3yCpRwBKh+Ba9xo
         ao8lPl2JzYhl7RbHXQjMQn+UsIR3UTTTB3DziR8IxhksgJOQfPf/u+yTtGN71Eszks+1
         mmdmR2uyzpYtL4AjPQ6Lrbyq+xkRqQM9gSPwDV7PnA7nS2DprYlBeYRcyLKaeh+EEtyW
         fqY45+94MAuNoVh8D2UGuUqQxK+VZqN17pY1QUdIlzxG4MqNfstpLiPPY/d4jZTHlybt
         x3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=qvfIzg0tm1m+AFhSUpAZevgD7eFyHsFFNkS9ttpBzhw=;
        b=TsFtgngaixF8ewU1YSr9aaoJ9NNCosIGgUt1qNx2W2YauhqQG8BHmoeN5ZaJcvU+57
         eWHHJ0kqSbLHOwFfwebw0MfXlRZCxbFVcuPhci/oy6UYRUw01wPV7o1znQ/V2RFyzl0/
         LmS3Dw1/6L8MhXU2SU5fAtQJfWYWSa8w2JSHb2GV5zLAL61YeXqlfYTTLR6v7LsImMjD
         NIsdB4c3pAilpfmqLYYtM6DFsNX6aSgl8Boh+iUbSQJQyw0IeuqvzFL6l4eUFsmuu1K8
         ZzWCIXMGfOeo/udaMFdujs9Uq5QPWrBEtLjBEd4ufiSVyri1Wf3m+HHfRX023uhv/aPg
         XyUg==
X-Gm-Message-State: AOAM531IttwswLMH10gMxi5PZqSd8HtspzM0VAoyTfGYGCtz6EkdSfDx
        w2OjeP6Q9mXw5WAMQ/xfNQ==
X-Google-Smtp-Source: ABdhPJzn9nDryX5P9U3DaMm5P9SBGvs2OVal3OfZCQdQ/sba4N0BfVYIHO20zGj/wpq4W9ZRPdR1oA==
X-Received: by 2002:a05:6808:a1a:: with SMTP id n26mr2160993oij.94.1608129002941;
        Wed, 16 Dec 2020 06:30:02 -0800 (PST)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id b82sm421325oif.49.2020.12.16.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:30:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e0f1:f928:86e0:426e])
        by serve.minyard.net (Postfix) with ESMTPSA id C2E57181D94;
        Wed, 16 Dec 2020 14:30:00 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:29:59 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.11
Message-ID: <20201216142959.GT11017@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some very minor fixes.  One came it today, but it was just changing
some commas to semicolons.  The rest have been lying around a month or
more.

The following changes since commit 9ff9b0d392ea08090cd1780fb196f36dbb586529:

  Merge tag 'net-next-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2020-10-15 18:42:13 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.11-1

for you to fetch changes up to fad0319cacdf02a8d4d31aa1d8dc18c5bd5e397e:

  char: ipmi: convert comma to semicolon (2020-12-16 07:54:54 -0600)

----------------------------------------------------------------
Some very minor changes

Nothing functional, just little syntax cleanups and a RCU warning
suppression.

----------------------------------------------------------------
Qinglang Miao (1):
      ipmi: msghandler: Suppress suspicious RCU usage warning

Tom Rix (1):
      char: ipmi: remove unneeded break

Yejune Deng (1):
      ipmi/watchdog: replace atomic_add() and atomic_sub()

Zheng Yongjun (1):
      char: ipmi: convert comma to semicolon

 drivers/char/ipmi/bt-bmc.c          | 6 +++---
 drivers/char/ipmi/ipmi_devintf.c    | 1 -
 drivers/char/ipmi/ipmi_msghandler.c | 3 ++-
 drivers/char/ipmi/ipmi_watchdog.c   | 8 ++++----
 4 files changed, 9 insertions(+), 9 deletions(-)

