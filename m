Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81D82676C3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgILAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgILAUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:20:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EDCC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:20:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so7659269pgh.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SyGy6Bq4kFQAzKhwg1lifdjeQFiT7l9/bEhNqsf8ppg=;
        b=IaBeXW2/8x82RUjFwxsHtLxoYAihstfszh62hfBCA9+yAxYZ9gpYnlAv6tPtMjluD2
         W4YgpVEHrvkwmjpB7XBgr/CVF1mDuFPjlYDs1eFtLv5laVPmRCjzyQzWMoO5OrcQ0bq4
         MIwSyocr28NJC4ImXAKjBDRT4unFqVVyJaK7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SyGy6Bq4kFQAzKhwg1lifdjeQFiT7l9/bEhNqsf8ppg=;
        b=XjxNje1qf9gtt1HW93B+SvaKjmefaEMcsX96WR4rZ7lf6+6u6hHQdg2OKSC5s9qwlK
         d1sGnt7epoyJFidWlrIoA8PkCC4+ayxjeTuGUo2M2kKSb66HeuFDNyfVZNoPXg1Xy+R1
         5eELo7DcLrIQZwCiloC7a+YH2/26lXWrWVIJ5nFQ1KJLX2cmpyNjKVLKZGlsp04zFPic
         F8Vh5Z56PWgTO/8Gig7c9/uMlbrovZP+uowxM+EespQqq8XJo3oFS5HGFH8mC53+p7yz
         J2NUa8Jq4MQsC0siVNGXlWldgAAJlS4YXBIqiC2T9Av+LqfJGINzESg+q3ro/pTjuzFR
         eR5A==
X-Gm-Message-State: AOAM532emzs3aN8pJHHxtr0y5LUwKhc+0tlORQ1YqLEeJSHtw8/NYB1r
        ogS8rZkUfOwVon/+4v8eXcY/cA==
X-Google-Smtp-Source: ABdhPJzoxkCCvM4+8lu95KPIcKpwWlo1kQksotUdkydOxxi1XwuMQBpzlz3tK2UypL865H4yo08ywg==
X-Received: by 2002:a63:4284:: with SMTP id p126mr3481718pga.104.1599870004236;
        Fri, 11 Sep 2020 17:20:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9sm3313483pfu.163.2020.09.11.17.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 17:20:03 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:20:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [GIT PULL] seccomp fixes for v5.9-rc5
Message-ID: <202009111718.B94EAD7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp fixes for v5.9-rc5. This fixes a rare race
condition in seccomp when using TSYNC and USER_NOTIF together where a
memory allocation would not get freed (found by syzkaller, fixed by
Tycho). Additionally updates Tycho's MAINTAINERS and .mailmap entries
for his new address.

Thanks!

-Kees

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc5

for you to fetch changes up to e839317900e9f13c83d8711d684de88c625b307a:

  seccomp: don't leave dangling ->notif if file allocation fails (2020-09-08 11:30:16 -0700)

----------------------------------------------------------------
seccomp fixes for v5.9-rc5

- Fix memory resource leak of user_notif under TSYNC race (Tycho Andersen)

----------------------------------------------------------------
Tycho Andersen (3):
      seccomp: don't leak memory when filter install races
      mailmap, MAINTAINERS: move to tycho.pizza
      seccomp: don't leave dangling ->notif if file allocation fails

 .mailmap         |  1 +
 MAINTAINERS      |  2 +-
 kernel/seccomp.c | 24 ++++++++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
Kees Cook
