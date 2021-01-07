Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056FC2EE9AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbhAGXTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGXTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:19:07 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A826C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:18:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v1so2621075pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/h60MAQ8k3P8RXOQE+NwjCgJzZD+Zzpwq2l5q/Vvkuo=;
        b=Q7G6+u6I6ASOReSVz5kVdTZnMmJIpm3y3oye7SSYOlSllwL80RJZRCvI5zSkubydPC
         kLa4rKnYcQr3uNBbzx6+vP+UAK6pdasWZUeVtVY7k23aCPRvrlBFwCSPi5CipU0AX4u2
         Fff5WosryL7YBHpNIwPuX7x2bndMU0MM6u/vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/h60MAQ8k3P8RXOQE+NwjCgJzZD+Zzpwq2l5q/Vvkuo=;
        b=pZopT4KXfycM+5pdM5Wg6mcB0kipob8vYPlehToJ6VKY5hZnlWHgaB2YCKGHWAx2Zn
         pj6JBICsWCW2K1P5kpuvoEBEROisZLDEme7Qi/74uOC8cG2u0RMTg2iNKu5l4e62xRJY
         VNyHUKen8m9+ziKSTqh84ot6dGImywM7hC8RqxWx9y4mvEsKJG8ySa12EmUxWlAm0hCL
         m2vQo7VIjbADiCh9XR85T9ANDCoOeafcw5eh7W0YCqkVL9jvIPf+Pja4of6DfnhSE8Dv
         w3Djj0i9iI7Aw1csRTXkxtWEvQgcOfw+UImHice8EWdvvX3QeUpbMFNr52pj2mJKNrUo
         OEJA==
X-Gm-Message-State: AOAM531it+GgpAOeUMQ+rIqvJg/DElo0zCdd6ZVafpLK1isM0R3NHOcR
        Y7Wr7GzxXgFEYL61bFtgHrExOcjAtg/B7Q==
X-Google-Smtp-Source: ABdhPJxyQV2ul83/UEblhtnEeBYSnnDa0rZZhBuQhkl75QyxOruGxTlCanTZ2LDWtUtpLelUnM8iPw==
X-Received: by 2002:a17:90a:940e:: with SMTP id r14mr766941pjo.105.1610061506752;
        Thu, 07 Jan 2021 15:18:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c23sm7891500pgc.72.2021.01.07.15.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 15:18:25 -0800 (PST)
Date:   Thu, 7 Jan 2021 15:18:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: [GIT PULL] gcc-plugins fix for v5.11-rc3
Message-ID: <202101071517.4415D1F7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this gcc-plugins fix for v5.11-rc3. This makes them build
again with the latest GCC 11 in Fedora Rawhide.

Thanks!

-Kees

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v5.11-rc3

for you to fetch changes up to 67a5a68013056cbcf0a647e36cb6f4622fb6a470:

  gcc-plugins: fix gcc 11 indigestion with plugins... (2021-01-06 15:08:23 -0800)

----------------------------------------------------------------
gcc-plugins fix for v5.11-rc3

- Bump c++ standard version for latest GCC versions (Valdis Kletnieks)

----------------------------------------------------------------
Valdis Kletnieks (1):
      gcc-plugins: fix gcc 11 indigestion with plugins...

 scripts/gcc-plugins/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Kees Cook
