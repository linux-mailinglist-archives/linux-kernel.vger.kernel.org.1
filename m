Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E053C2017B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 18:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbgFSQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395195AbgFSQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:41:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C048C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:41:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so159636wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dItvvC2lt6E+qFq6CNnb5fhaaaf/EERuUxlUZLYBRLQ=;
        b=fp84Acbz7S3dBE8XH0GTuOf5WHyFPLp+6nzb24lzA18zuukeBHQba5ScP3qI6irZ+u
         6pKfttAZ/+oakawf/IYd/o6BVvJVndCxUJyMHyw5b9uy2aaLk3pdMSjVvUxt5AR14TIr
         +NZpqYyIg3BHleGD112QX6tBnVVBSV/Cxh38Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dItvvC2lt6E+qFq6CNnb5fhaaaf/EERuUxlUZLYBRLQ=;
        b=oO7lvkhZamCQAh5eCLwVAAaLKxHX0HZZ804fI7gzukCXrsc3lhrR9J+O53amxPPGVJ
         Z1HxPsSwtYrCDfbQ6/KaXlNSESX3dP1OMkWc60f4Vd+eNRIE6N73OGRLgoykhmz7M4Ug
         Zy5UvX4tbedGRdxWlkgAbMahclXYjnm3nOZ90Mfqt80x6L2Ye+EzgxjWq/Q2KG98+LX2
         t1omi81/OPd9KKDBTdCUiHTX8hptNrn5xg1qKjllDofnyFnIRBZQK6XgYFEz4n9yK+BE
         kPaKBANXcos5S0BP6cPA4LNqyO6QZijGRGyEnABlIa5oLYVn/N+X69MPfiLpBQk4RcXD
         QYpw==
X-Gm-Message-State: AOAM530bPJPILyg0f9A2Nqw1eU1FR979Hsij+hwuClMzIM1i728DIe/n
        2NPUaBEqawiygCGADhWON+6KRA==
X-Google-Smtp-Source: ABdhPJzdXUR+Gako3OmnLmhC8kzsj9i3PW+bOnvUQp2RQX5o4Fbiwj3ONT0EGc8mcpuSXlm9I2wznQ==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr4596054wmj.84.1592584911912;
        Fri, 19 Jun 2020 09:41:51 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-85.host.pobb.as13285.net. [88.144.169.85])
        by smtp.gmail.com with ESMTPSA id j4sm7521901wma.7.2020.06.19.09.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:41:51 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [RFC PATCH 0/1] dm-crypt excessive overhead
Date:   Fri, 19 Jun 2020 17:41:31 +0100
Message-Id: <20200619164132.1648-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up from the long-forgotten [1], but with some more convincing
evidence. Consider the following script:

#!/bin/bash -e

# create 4G ramdisk
sudo modprobe brd rd_nr=1 rd_size=4194304

# create a dm-crypt device with NULL cipher on top of /dev/ram0
echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | sudo dmsetup create eram0

# create a dm-crypt device with NULL cipher and custom force_inline flag
echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 force_inline' | sudo dmsetup create inline-eram0

# read all data from /dev/ram0
sudo dd if=/dev/ram0 bs=4k iflag=direct | sha256sum

# read the same data from /dev/mapper/eram0
sudo dd if=/dev/mapper/eram0 bs=4k iflag=direct | sha256sum

# read the same data from /dev/mapper/inline-eram0
sudo dd if=/dev/mapper/inline-eram0 bs=4k iflag=direct | sha256sum

This script creates a ramdisk (to eliminate hardware bias in the benchmark) and
two dm-crypt instances on top. Both dm-crypt instances use the NULL cipher
to eliminate potentially expensive crypto bias (the NULL cipher just uses memcpy
for "encyption"). The first instance is the current dm-crypt implementation from
5.8-rc1, the second is the dm-crypt instance with a custom new flag enabled from
the patch attached to this thread. On my VM (Debian in VirtualBox with 4 cores
on 2.8 GHz Quad-Core Intel Core i7) I get the following output (formatted for
better readability):

# plain ram0
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.2305 s, 202 MB/s
8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -

# eram0 (current dm-crypt)
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 53.2212 s, 80.7 MB/s
8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -

# inline-eram0 (patched dm-crypt)
1048576+0 records in
1048576+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 21.3472 s, 201 MB/s
8479e43911dc45e89f934fe48d01297e16f51d17aa561d4d1c216b1ae0fcddca  -

As we can see, current dm-crypt implementation creates a significant IO
performance overhead (at least on small IO block sizes) for both latency and
throughput. We suspect offloading IO request processing into workqueues and
async threads is more harmful these days with the modern fast storage. I also
did some digging into the dm-crypt git history and much of this async processing
is not needed anymore, because the reasons it was added are mostly gone from the
kernel. More details can be found in [2] (see "Git archeology" section).

We have been running the attached patch on different hardware generations in
more than 200 datacentres on both SATA SSDs and NVME SSDs and so far were very
happy with the performance benefits.

[1]: https://www.spinics.net/lists/dm-crypt/msg07516.html
[2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/

Ignat Korchagin (1):
  Add DM_CRYPT_FORCE_INLINE flag to dm-crypt target

 drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 12 deletions(-)

-- 
2.20.1

