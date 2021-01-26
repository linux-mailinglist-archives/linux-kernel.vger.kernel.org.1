Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20DB3040D2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405941AbhAZOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbhAZOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:47:14 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC42EC061D7F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:46:33 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id dj6so7929106qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2nx43izyGeDjti2URbQs6b9oWswQ/xNWMKCowudUmA=;
        b=h03z2l32qFy6uccM8o+oCevfv+cdxXaBwYRVT2XMHfyWZXbgYONQwmEFwnN+uiJAaG
         6ecCt5QaeUTQIEHSNwohHNXaDT23iIzDmkznFfRJA8TGAp2SKmrc+VreIQjZefQczAAo
         ZZZQDtmOR528EG0teyy8NwJwYkJkhzapYM4cXVoanYyW/ukmcqay1WWe/6k09xufRkJ8
         KSOwwdI2UVRhz4os+VfQ6iFt1oGAoR2mld30QZc0dgTNDmjirPx80rJ8uVwwNOtjPdgb
         7b0b0Y9/0GZ33Ma6b8lHuhVoMpsrju0jG9nqIoyhLYSlsdWJY+56woPpnrKRAvQcRHvp
         74uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2nx43izyGeDjti2URbQs6b9oWswQ/xNWMKCowudUmA=;
        b=JginonW14jJ4neFTkCTPKqfaeJHTKRmXZ6oK2M8YhWVqryik2kkD6yuR2kPkIvFF+K
         V4MvJaohAwZsFN+Mg9buwrhGSzg1ZhnzPcLp1Inqpt+EFaw2PT5SHDSRGOCFOFjH+B/n
         nYveadAez93CwMAi0UL+Ugo/VoExrPTbsqTtqwslEvxAex1XLdsR4h4WduuxI3Otd0ac
         l0//M0/XDHHs1KVGm6+8N7eKriztYoAqjAa6hRrG6OXMdYexvjUFSRTIgu2ZWCPIK513
         gvqr8dlnvZn54zIyZM+7PoweUleTifEn8p+P7cXtcK2FgZfpK7OwEuGIOoQINjumNd+F
         TwtA==
X-Gm-Message-State: AOAM5309e4n8KGIzxzh6hnkBP/9dc0ji/4p5Xv3cTK4w46GoN6tWo6R8
        yHh+W/UcDuyTajlh9VsePHfwTg==
X-Google-Smtp-Source: ABdhPJztJ5/c3CA63YEQP1l7vjz5Xg85hmg0iJwEwGhxlV8+noR19RwUXwJ4Xn2cwLb8bCbzHIBZdw==
X-Received: by 2002:ad4:4108:: with SMTP id i8mr5719539qvp.49.1611672393102;
        Tue, 26 Jan 2021 06:46:33 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id p17sm2484922qke.134.2021.01.26.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 06:46:32 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org, jmorris@namei.org,
        lukas.bulwahn@gmail.com, hch@lst.de, pvorel@suse.cz,
        ming.lei@redhat.com, mzxreary@0pointer.de, mcgrof@kernel.org,
        zhengbin13@huawei.com, maco@android.com, colin.king@canonical.com,
        evgreen@chromium.org
Subject: [PATCH v4 0/1] scale loop device lock
Date:   Tue, 26 Jan 2021 09:46:29 -0500
Message-Id: <20210126144630.230714-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v4
  - Added review-by Petr Vorel
  - Addressed comments from Chaitanya Kulkarni
v3
  - Added review-by Tyler
  - Sync with mainline
v2
  - Addressed Tyler Hicks comments
  - added mutex_destroy()
  - comment in lo_open()
  - added lock around lo_disk
===

In our environment we are using systemd portable containers in
squashfs formats, convert them into loop device, and mount.

NAME                      MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
loop5                       7:5    0  76.4M  0 loop
`-BaseImageM1908          252:3    0  76.4M  1 crypt /BaseImageM1908
loop6                       7:6    0    20K  0 loop
`-test_launchperf20       252:17   0   1.3M  1 crypt /app/test_launchperf20
loop7                       7:7    0    20K  0 loop
`-test_launchperf18       252:4    0   1.5M  1 crypt /app/test_launchperf18
loop8                       7:8    0     8K  0 loop
`-test_launchperf8        252:25   0    28K  1 crypt app/test_launchperf8
loop9                       7:9    0   376K  0 loop
`-test_launchperf14       252:29   0  45.7M  1 crypt /app/test_launchperf14
loop10                      7:10   0    16K  0 loop
`-test_launchperf4        252:11   0   968K  1 crypt app/test_launchperf4
loop11                      7:11   0   1.2M  0 loop
`-test_launchperf17       252:26   0 150.4M  1 crypt /app/test_launchperf17
loop12                      7:12   0    36K  0 loop
`-test_launchperf19       252:13   0   3.3M  1 crypt /app/test_launchperf19
loop13                      7:13   0     8K  0 loop
...

We have over 50 loop devices which are mounted  during boot.

We observed contentions around loop_ctl_mutex.

The sample contentions stacks:

Contention 1:
__blkdev_get()
   bdev->bd_disk->fops->open()
      lo_open()
         mutex_lock_killable(&loop_ctl_mutex); <- contention

Contention 2:
__blkdev_put()
   disk->fops->release()
      lo_release()
         mutex_lock(&loop_ctl_mutex); <- contention

With total time waiting for loop_ctl_mutex ~18.8s during boot (across 8
CPUs) on our machine (69 loop devices): 2.35s per CPU.

Scaling this lock eliminates this contention entirely, and improves the boot
performance by 2s on our machine.

v3 https://lore.kernel.org/lkml/20210125201156.1330164-1-pasha.tatashin@soleen.com
v2 https://lore.kernel.org/lkml/20200723211748.13139-1-pasha.tatashin@soleen.com
v1 https://lore.kernel.org/lkml/20200717205322.127694-1-pasha.tatashin@soleen.com

Pavel Tatashin (1):
  loop: scale loop device by introducing per device lock

 drivers/block/loop.c | 93 +++++++++++++++++++++++++-------------------
 drivers/block/loop.h |  1 +
 2 files changed, 54 insertions(+), 40 deletions(-)

-- 
2.25.1

