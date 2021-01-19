Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748282FBECA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392439AbhASSUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392430AbhASSQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:16:48 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E8AC061796
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:15:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kx7so428528pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=13C+aDMWdR7G+9z6gG9CJgTmkaWg21aJx2K27CvN4no=;
        b=U3VsmjPK7+3aOXhJjs7v729bvyo003RHm2LylUqo2zf7oclXO+ARtJpA4GaTpMh/OF
         HZnAuI0jPb4G5QE1tP+wuk4PYCVe+yMDrEQOlhsxuqqWJXg/M4EUywBkhsh/1nIIKZSI
         AajTsmQCXeFve1pbjRLZjuVNYDKty/JW02Aw80IhU054Vj3i1bgfxODMbvRAMj8xO3iY
         nkfE0ifT/3dtCjO20TbYDE2SyPpfTNrm+L5vt+/VSn7pGzxafz6DwtePTHBSO9Lni6pr
         UeeSYFrRR3dSUqm79aDV49MGNbJHTPZXXoEO+yYx/QnRnSfen80CS3XbdMxVMqFn0vwu
         Gn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=13C+aDMWdR7G+9z6gG9CJgTmkaWg21aJx2K27CvN4no=;
        b=qY8CShyUayUQo3vIy63fllvKWde+CYtflCGiw0S8G/HABfDI41oIRlqH6+/hsYm7Q0
         JMNU2lCe0mMrqsxdWeYdc8ZJ1f/fhUWRddSiwQDWMgi9cZ50SEFKggU1GEY8a/xLnyCE
         TsEUQ8Yxmgt2oVhpMtj9DL0hBJXYQxaIAaUOPkZD06O6qwCdiroLf4AnREagL4UufCrR
         zEIvjU226f2zVZhq3btBwDXcEewrJr/0msTEw0XmJEWmW5o2HIipUdRTZOA1ThljGQpw
         YZPY6kBnCleamy1s/gGuRS3teWQYsv/lwj48LbFnHzLXYNn7xdd3PrGhLus/TKU0EaA5
         S5GA==
X-Gm-Message-State: AOAM531G2pjajWTYF4V5wAptodj+KggLZ5ODGCxNgA6wL7C3lJPp12Hx
        Y96lPJSe3m3rSHNL316kycXGEWEQ8uxktw==
X-Google-Smtp-Source: ABdhPJwQFdOk3/JhnkYAJ7+4UxWeSODdgmrzXc6v6ZZNNVodaufosO8lzD8MEq5dMApJxPrN8j9fHQ==
X-Received: by 2002:a17:90a:7e2:: with SMTP id m89mr1061075pjm.2.1611080156359;
        Tue, 19 Jan 2021 10:15:56 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id r14sm20043775pgi.27.2021.01.19.10.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:15:55 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] task_work fix for 5.11
Message-ID: <87a18f00-8f32-edcc-4595-da70e623febc@kernel.dk>
Date:   Tue, 19 Jan 2021 11:15:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The TIF_NOTIFY_SIGNAL change inadvertently removed the unconditional
task_work run we had in get_signal(). This caused a regression for some
setups, since we're relying on eg ____fput() being run to close and
release, for example, a pipe and wake the other end. For 5.11, I prefer
the simple solution of just reinstating the unconditional run, even if
it conceptually doesn't make much sense - if you need that kind of
guarantee, you should be using TWA_SIGNAL instead of TWA_NOTIFY. But
it's the trivial fix for 5.11, and would ensure that other potential
gotchas/assumptions for task_work don't regress for 5.11.

we're looking into further simplifying the task_work notifications for
5.12 which would resolve that too.

Please pull!


The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/task_work-2021-01-19

for you to fetch changes up to 35d0b389f3b23439ad15b610d6e43fc72fc75779:

  task_work: unconditionally run task_work from get_signal() (2021-01-08 09:14:21 -0700)

----------------------------------------------------------------
task_work-2021-01-19

----------------------------------------------------------------
Jens Axboe (1):
      task_work: unconditionally run task_work from get_signal()

 kernel/signal.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
Jens Axboe

