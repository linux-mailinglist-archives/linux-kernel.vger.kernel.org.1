Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538C321BA35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgGJQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgGJQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:23 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC46C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:01:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e64so6526606iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CT8GfIgnhQopWm8iDNrvhIrzFdMDsa9H0pNwgHwkLh4=;
        b=Yoy2AF0Hlb25wfR80l47A00iDMoRp5YDNhyRFuXfbtPhZPrppiweVtxfl0EA63y95e
         NqLjp0CSKEfkKEDplqCeo/BSn0HO1ugY+1wyWMZRg1Kv3VyoQhP5YIBuifgY/xLpee/D
         WCzRcYAiDkwxZF7p4r4dopZtrouc5G85QR28xgEntuRFohB9lZZI/GOLpglmG0j4m/QA
         qTWOHJtYArbfV1mBwWusCP3+60N1r75M8zjM9pqM05XLbDjcFyqkklv2TBkXoH2KgqNs
         JODXbfw9qIP3aY1L/FQJ3FL/xqP8SaLRBMwwxIERQAt5vP5Sqp/dlmmvJUPTOi3Pfdtl
         CYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CT8GfIgnhQopWm8iDNrvhIrzFdMDsa9H0pNwgHwkLh4=;
        b=HegGz5PEaDjX0nWlsuWbKJ3iSamrzfsBF2Ky7bI3pMJ4bOC1uVDYkW3q1n6oauddct
         6DKf6eemPQHTMUviIf6qLdHyBWkUtcSc85f3k9ekq5Ye0MjQe+wdQU3V5BccnrMWAGOR
         EIIuwR2i+IwMGuJ6sNUmNCv5YnEWPgP3VmChN44jna7GDRgnFb7TLfWHl/vKcxCcIX4r
         FptWILB5p3CID4v9Ql9Hw7wNYmRlrRrM+ieNGCkPv9RnxMC3Ijlt8k3WKT7+cbgAa/VO
         E2/aqvilpkhHZIJ4pAqpv+qB7ZZ++7+0ZZfa+rfTTzcxHMjAMcwp+KNFe7nZC8zcC4wp
         GhFQ==
X-Gm-Message-State: AOAM533Fb17FPidRWmr9vscs9jfEwBAp7RGwpQyNSoOHctp6M+MzcDlP
        5sGbuhUQ2+fVaa7X/HfWbnTxz+nwZq1T3A==
X-Google-Smtp-Source: ABdhPJxuXGAJ6xxmDfDRjdZr/xZDFyFSQ8yhw/xlqTPSYGv4M4BL2OyRyl45qSWxa6wvuKUegWVcKg==
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr45766867ioc.8.1594396881588;
        Fri, 10 Jul 2020 09:01:21 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a10sm3590388iln.20.2020.07.10.09.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 09:01:21 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.8-rc5
Message-ID: <2a7f5f56-a1be-46fc-7b5f-4cc35ca4b33d@kernel.dk>
Date:   Fri, 10 Jul 2020 10:01:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

- Fix memleak for error path in registered files (Yang)
- Export CQ overflow state in flags, necessary to fix a case where
  liburing doesn't know if it needs to enter the kernel (Xiaoguang)
- Fix for a regression in when user memory is accounted freed, causing
  issues with back-to-back ring exit + init if the ulimit -l setting is
  very tight.

Please pull!


The following changes since commit b7db41c9e03b5189bc94993bd50e4506ac9e34c1:

  io_uring: fix regression with always ignoring signals in io_cqring_wait() (2020-07-04 13:44:45 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.8-2020-07-10

for you to fetch changes up to 309fc03a3284af62eb6082fb60327045a1dabf57:

  io_uring: account user memory freed when exit has been queued (2020-07-10 09:18:35 -0600)

----------------------------------------------------------------
io_uring-5.8-2020-07-10

----------------------------------------------------------------
Jens Axboe (1):
      io_uring: account user memory freed when exit has been queued

Xiaoguang Wang (1):
      io_uring: export cq overflow status to userspace

Yang Yingliang (2):
      io_uring: fix memleak in __io_sqe_files_update()
      io_uring: fix memleak in io_sqe_files_register()

 fs/io_uring.c                 | 29 +++++++++++++++++++++++------
 include/uapi/linux/io_uring.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
Jens Axboe

