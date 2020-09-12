Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7B2678EC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgILInF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgILInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:43:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65398C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:42:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u9so2035654plk.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RBf+r4Wfjftyu2UytGO9PrWyfgrAo6pDRCv214Qme1g=;
        b=TI4NGEGr8/nZqhpPSVmw1qdnUjjGAgA3IQQ9fGdOzRjiwn3udsZia7vTzsQZeTlA0N
         9hXPB4GJuWX2Ve8Kyi+ufmwQLwtn+vx3cdVDcQxBIdozDA3g/BcVWH6SarGLEbOtbyh5
         UNZt569I43Aa0sQwcz1KmzvP1mw1eN+zP7O4OtFDSnFPrsvas8UoUA+RxqY69HXdgLjf
         VPrc07dhZZ8J4Bk0ULavxl5u716XCDcdJ2+RAQ21QgjDYOeBlM88TkclQEPuArg1XE/f
         8PViAark2nGIsE8Mf6D0l0DqSGVocNfsDfRViXVvLiirA+fS4w9bF4rX6p88OhmLYPBG
         MKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RBf+r4Wfjftyu2UytGO9PrWyfgrAo6pDRCv214Qme1g=;
        b=hVxZS9HKukegUlRT//sYo6/vYuR6Q7XM1WkTy0oOkAzQxhcERNMFxBbKbbN3Fv46BK
         fjGjRePiHs6LPhoGW6enmKF9C+P1rih8pmoRiOQTJSD8KvX+8P5CYdhacOslHjBwKsPt
         /PtF3Y26qiN6ioBxuLPqodZBbnJH+dtMbOnXbRDgoy19n95afH+xN12FQm0hhiae31SX
         qiqkPlCiL65GybafH3pgMgvKEWre6Uo8K22k26OEC01Z+f6Ue6+7/zZ53F3gsjTdNUKM
         Qv6DO9Lv545gVlC+T5xRXM7n7NZpuZpSXWH4JlHmJnW67znxDgXk6v4+hjy+ObMlP0yN
         5w5g==
X-Gm-Message-State: AOAM533tvemNhkXg9PwRr9H92An1EEu2KZafrkaa7bbnx2z8hW1m2mxs
        0/p82nNHbeDnvs4I59vyjkM=
X-Google-Smtp-Source: ABdhPJw4Ps2U8pKBxwyTEXqVvNsHKtnICl1kfCyf9FnV+j4mpoqjnGazMdRVprMnQyBDXZEmZ/QMXA==
X-Received: by 2002:a17:90a:fb4d:: with SMTP id iq13mr5521786pjb.179.1599900179017;
        Sat, 12 Sep 2020 01:42:59 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id j35sm3501073pgi.91.2020.09.12.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 01:42:58 -0700 (PDT)
Date:   Sat, 12 Sep 2020 17:42:55 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC fixes for v5.9-rc4
Message-ID: <20200912084255.GR3562056@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull.

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to d877322bc1adcab9850732275670409e8bcca4c4:

  openrisc: Fix issue with get_user for 64-bit values (2020-09-12 17:26:00 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.9-rc4

Fixes for compile issues pointed out by kbuild and one bug I found in
interd with the 5.9 patches.

----------------------------------------------------------------
Stafford Horne (3):
      openrisc: Reserve memblock for initrd
      openrisc: Fix cache API compile issue when not inlining
      openrisc: Fix issue with get_user for 64-bit values

 arch/openrisc/include/asm/uaccess.h | 33 +++++++++++++++++++++------------
 arch/openrisc/kernel/setup.c        | 10 ++++++++++
 arch/openrisc/mm/cache.c            |  2 +-
 3 files changed, 32 insertions(+), 13 deletions(-)
