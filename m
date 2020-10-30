Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33D29FE32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgJ3HFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ3HFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:05:08 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA33C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:05:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i2so3351355qkk.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=xLeGlN0cmSvZbkXIw9c7NBWmR8fqqfs8YoL242vrZNo=;
        b=qdhGWwk6UnQUPs2PolENlW0FqUj+MaPdST5ln1/FXWClxUP5NqqRJyPo6ruZ9/c828
         GpqEUEcUQfTYgJCYqLI2Y/XhR9Gb+BUN+0FBXWPhRLdlUl83XE1noVl7V6VV28SYLnZu
         aZc7DYIgegTvD/C1fD9sIEVJRZY4UslPOkF1zp3vUhdMpuYFZLx2boTctK1id/zXbkGG
         buvz9EzTcqpVrUyc/CASTrRxQ3tUY2UAmHvSURmkBVHVrda7+sl/8mRg7X3O9R5h8CW1
         lnf1p8NfC7NaezDpyJynxOSWgPdI+zsysXifIBBxPP/qpaBlg8JyydogbE7WCM9STxVX
         gx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=xLeGlN0cmSvZbkXIw9c7NBWmR8fqqfs8YoL242vrZNo=;
        b=mYApYD+nQrDsXowfFDYudXpPKbeUT/Ve10BDVpfi42VVTLsztL6I6ap9/5WmmluHyP
         17VlvawhNeoVHhn35J/nctUZpF057Uekee9QtErcFl/Lzt1fWKPAEi2kkAkSgSNBw5lN
         uOjxeyKWX6WWe/2l8GVLHuR1qtY8647TGEOwFZuXnDAWiiYQXhBi4vqKlxYVRZyWaBFx
         gBv9YGksmdebhXk3PRPmySBW/PAqNwso9xFJvlapViVRVwrA/dCVnCZUJHvFpLnY968Q
         VNyjMXgfZaFL8hLUPtGmUb1/eDi+u37xmV+JmriXJzZgz1KizCVSSBs2eYG9OnchsAQF
         4dPw==
X-Gm-Message-State: AOAM531qLIFb81lYz3LqbY9Etkr+hpbyjlJth3Vb5UsWwBP9lm62JI65
        qElfMAFslPT1nJ3NqD8+qgsRY6lgb2T/68ygmGIQ95nFpbEPZQI/wYBXDKFf9U9ff0AaRkHDaAb
        SGSgakJsK4U7LL8qRzIxjWgvlCil7MY72sxMlIOv7FVHwBl4jdpTwWxlB7TvTu/EZ8ndyVxiZ
X-Google-Smtp-Source: ABdhPJx0+Mg7UP2G65khWdpWU01oIT8gt67gJyRZVRUUTGqxR1h/jwr8sqASe6MO6hzYGxJWXAUjpKPowIi6
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:725a:fff:fe46:72ab])
 (user=amistry job=sendgmr) by 2002:a0c:b664:: with SMTP id
 q36mr7700643qvf.6.1604041507270; Fri, 30 Oct 2020 00:05:07 -0700 (PDT)
Date:   Fri, 30 Oct 2020 18:04:41 +1100
Message-Id: <20201030070442.457739-1-amistry@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH 0/1] debugfs: Add a helper to export atomic64_t values
From:   Anand K Mistry <amistry@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my story:
Once upon a time, there lived a developer that wanted to export an
atomic64_t value to userspace using debugfs to help with debugging. But
that developer found there was no helper function to do so and was very
sad.
The End.

Yeah, it's a sad story. Here's my patch, merge me maybe?


Anand K Mistry (1):
  debugfs: Add a helper to export atomic64_t values

 fs/debugfs/file.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |  6 ++++++
 2 files changed, 43 insertions(+)

-- 
2.29.1.341.ge80a0c044ae-goog

