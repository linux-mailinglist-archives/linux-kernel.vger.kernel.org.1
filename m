Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3349E2BB440
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgKTSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731039AbgKTSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:45:35 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAB9C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:45:34 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u21so10934630iol.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9p6HVvTWyMaxmoezpfttIAofpYXRqeK+9qf/+06wmto=;
        b=ZQqGLnEa7hjw4nR1wm65a+144RSbuyKUPwO7mJsCNe9BQTrxiufHI4og/JdpSYdjI1
         kX/CXhyURpVjT97d7WGHCAudhRvMVg74NGKNEaa/sOF7LAc24Y6Qt37BajlDsSMYymHS
         ZLgHch0yGTU5q5J4bzAdVNxY7a2RiSVfEd1ZT++u56/tQqtsdTx59pXGV4ifIKj1uPXV
         HCn35VsnBPt9DZS6zR23snI0pRiBlP5ANRSfaFdjHedkny0W7qxdbQ3i+2/KAEdFZEa9
         5krjD7SY3fhX/67rgtrlmJQ9tzB589gaAc1cO2i81xv/ao9wfMlOnf+qKid5F9fGjVqu
         ZfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9p6HVvTWyMaxmoezpfttIAofpYXRqeK+9qf/+06wmto=;
        b=flh4bnW9pwYLJIRmy8Qn1YavbYduVZKWQeKwntL4/GfxhNaz1m8hHrPfRGb7+w51/V
         NLWFZjLnVAAi1NTCVdogPlKqoZiNDlfIifh5Xi4/foDh+HkRQfkwLmgAfMDEI25BnWFY
         UfbDGCURhX61DfcM/4nLNMpGLBJQ5WO6Nzf/KOrAEvNY2py7b5NzbSLj6LYkqtmdjpTq
         pmF0ELdcwOgQYDBsmGS8Tz24QkWRqimXEgrJcyebuqNsy7iPV7f3OZJW3R5G7EWlG0PR
         s2diK1cMJVHDgxNaSYSryg7dhN2ht9HVzw45Dx2a+ISGBRiUbDDy+jMIkn28iC6FxNyE
         V6dw==
X-Gm-Message-State: AOAM530JZYwwGLhl4Y7jxU73QXXWX7ZdK6FVKYLFMbsRCWM8MW3Iw6k3
        kFD5A+AjgehTIEtVHeLNnBW4R6S5ftQ6qw==
X-Google-Smtp-Source: ABdhPJw1cl1IXDp1ajW4jbHHFNzDI3Cw5IX6pUJg6cJNPmgcEAaY516seWCBiyzjiInau09n42lxQA==
X-Received: by 2002:a6b:7947:: with SMTP id j7mr26726951iop.143.1605897933008;
        Fri, 20 Nov 2020 10:45:33 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p24sm2524598ill.59.2020.11.20.10.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:45:32 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.10-rc
Message-ID: <6535286b-2532-dc86-3c6e-1b1e9bce358f@kernel.dk>
Date:   Fri, 20 Nov 2020 11:45:31 -0700
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

Mostly regression or stable fodder:

- Disallow async path resolution of /proc/self

- Tighten constraints for segmented async buffered reads

- Fix double completion for a retry error case

- Fix for fixed file life times (Pavel)

Please pull!


The following changes since commit 88ec3211e46344a7d10cf6cb5045f839f7785f8e:

  io_uring: round-up cq size before comparing with rounded sq size (2020-11-11 10:42:41 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/io_uring-5.10-2020-11-20

for you to fetch changes up to e297822b20e7fe683e107aea46e6402adcf99c70:

  io_uring: order refnode recycling (2020-11-18 08:02:10 -0700)

----------------------------------------------------------------
io_uring-5.10-2020-11-20

----------------------------------------------------------------
Jens Axboe (4):
      proc: don't allow async path resolution of /proc/self components
      io_uring: handle -EOPNOTSUPP on path resolution
      mm: never attempt async page lock if we've transferred data already
      io_uring: don't double complete failed reissue request

Pavel Begunkov (2):
      io_uring: get an active ref_node from files_data
      io_uring: order refnode recycling

 fs/io_uring.c  | 57 ++++++++++++++++++++++++++++++++++++++++++---------------
 fs/proc/self.c |  7 +++++++
 mm/filemap.c   | 18 ++++++++++++++----
 3 files changed, 63 insertions(+), 19 deletions(-)

-- 
Jens Axboe

