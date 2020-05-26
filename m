Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC71BD67A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgD2Hst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 03:48:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37373 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD2Hss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:48:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id c21so552335plz.4;
        Wed, 29 Apr 2020 00:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9gnkcgVN+mc2Ht5v0nzk7JW2zsevTiDN5q1XsDllpQ=;
        b=GR7o5dXBZ3B8jY+Ib3ycWNkp7On8Kxu9cVbI3zBetV/F5BOF+QGbZQvywQOWAQDsjX
         Zt3LoPW3IN1qgu9KVThQoRYZ3MzDJ38oBfsFlw3OZQSYgiYrC5gOmXgJLIgKKICKUtNC
         9BEwxFU3y6n9Bx74ZWWBu7xEpRenTONrednRKtvBZ461dvnIyXFXQZ94lzZFnOHMqV77
         /yJc3wDJCKY6XB8mVxe3neMa8da9pzHq9/Dn5ZoxArw1BjC7ALwCgIL7bIps+l6+9aMR
         XSU6yvYxr3vJZ4KEWtYu7N8qIcOO1OL1kiOTGcqHIbOv+i2+6TIF5WF7NuHYst8NxHXg
         8R8g==
X-Gm-Message-State: AGi0PuaKsDW3PTJQInttLYOnmNyIlIOk1m2gHtDbhynax+eiT1fiOctB
        lGxjECwdTqQxE8NPf/f1DmI=
X-Google-Smtp-Source: APiQypJ5MXGGf0V+2/wBtSxpiJtiWKbQ0Vb0orpplSU2T6ijwba7XXeGHcqxz8p6s6OqKKIEpM+T/g==
X-Received: by 2002:a17:90b:23c7:: with SMTP id md7mr1574076pjb.165.1588146527185;
        Wed, 29 Apr 2020 00:48:47 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 23sm3930307pjb.11.2020.04.29.00.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:48:46 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9D08C403AB; Wed, 29 Apr 2020 07:48:45 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v1 0/6] block: add error handling for *add_disk*()
Date:   Wed, 29 Apr 2020 07:48:38 +0000
Message-Id: <20200429074844.6241-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on some blktrace races I noticed that we don't do
error handling on *add_disk*() and friends. This is my initial
work on that.

This is based on linux-next tag next-20200428, you can also get this
on my branch 20200428-block-fixes [0].

Let me know what you think.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200428-blktrace-fixes

Luis Chamberlain (6):
  block: refcount the request_queue early in __device_add_disk()
  block: move disk announce work from register_disk() to a helper
  block: move disk invalidation from del_gendisk() into a helper
  block: move disk unregistration work from del_gendisk() to a helper
  block: add initial error handling for *add_disk()* and friends
  loop: add error handling support for add_disk()

 block/blk-integrity.c |  13 +-
 block/blk-sysfs.c     |   7 +-
 block/blk.h           |   5 +-
 block/genhd.c         | 366 +++++++++++++++++++++++++++---------------
 drivers/block/loop.c  |   7 +-
 include/linux/genhd.h |  16 +-
 6 files changed, 265 insertions(+), 149 deletions(-)

-- 
2.25.1

