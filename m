Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524AB1F00E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgFEUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgFEUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:20:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136C4C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:20:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j7so5373342qvp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xOu6uhNuTDzJb+FE33/TBMYvE6fXv3JzmtAIj4nPdlI=;
        b=F1Kr50lU5mk9pP5ddmaTKqR72rvsEul3Oij7w3h3xf+wyNEHF9FQ1le3KhCyAyLKZs
         2DpPIEfKeP4F2HuortrPZnEM/V1HrVYx9buYUyEvhfh11BY9iuOTYumbRGFVzX8oElM2
         swmEiEOg0ifd9ePfYIvxVccGx92hgETQGrtOc5i8pfPf9jhnNW/FX1RIs1ar4xcQIO5X
         qtA6LKebPIIy0aVd02KgubSS7ktJU+dKe5m7q88yLN/D1admrAGeMRKMGX2hwK0OzDK0
         fAtuPolsFvlDeqcnD48TYQ12awT2+ceg+4mQ4e0lNFXRvh7/SqZGRHc3LruxcK10aoCD
         DNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=xOu6uhNuTDzJb+FE33/TBMYvE6fXv3JzmtAIj4nPdlI=;
        b=d4d9FTcWoVmSXOyZiuSI1SSropFBB/giAtmM6sx7esXGKhr0v4OBnsd/47+8C3macn
         5sWvoLgAWVlRCgS3gMZq/xByrYO5qkD5VJbmxrtksxgHFWsRf9bqaKDFlMVpw6D6J5hC
         Q7VSW4XhWQ4mgGMna8N2VJvJuRtKSf0dcdX65DB0+RRG71Mmc/p4y7ANOGh3reN8Dzyj
         6sS+OkjjV3EfX3+7D3mpKrjOHI5CYmjPG70iMl34vBQjdQgZI4QxlyXCb/rrlWPvNyOu
         WP30PbdtknWveMPhRfKk8051MTCxogauQ+1otI648TtjJ25OnN9OM7ND6Lh+Jczu+gXM
         VWjg==
X-Gm-Message-State: AOAM533JvNTju1syBfvWozbe83btXjytDdS0EOBB1ddJMo9o0Jd7jqJu
        JTHaMUnIP6Cy2Ti5DAuYF3o=
X-Google-Smtp-Source: ABdhPJxuN89wSabsZN1QUIhh8jm2AtK+EnmBKhsmgSdfTkaxIUlSOM4Va9g679IuSbVF3ARKfPCIYQ==
X-Received: by 2002:a05:6214:144:: with SMTP id x4mr11082226qvs.229.1591388425934;
        Fri, 05 Jun 2020 13:20:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:86c8])
        by smtp.gmail.com with ESMTPSA id q24sm743673qkj.103.2020.06.05.13.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:20:25 -0700 (PDT)
Date:   Fri, 5 Jun 2020 16:20:22 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.8-rc1
Message-ID: <20200605202022.GK31548@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Mostly cleanups and other trivial changes. The only interesting change is
Sebastian's rcuwait conversion for RT which was already discussed.

Thanks.

The following changes since commit 47cf1b422e6093aee2a3e55d5e162112a2c69870:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid (2020-05-04 18:55:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.8

for you to fetch changes up to 10cdb15759540f03d056e2f73fe26377ed7dcfda:

  workqueue: use BUILD_BUG_ON() for compile time test instead of WARN_ON() (2020-06-01 11:02:42 -0400)

----------------------------------------------------------------
Dan Carpenter (1):
      workqueue: Fix an use after free in init_rescuer()

Lai Jiangshan (4):
      workqueue: void unneeded requeuing the pwq in rescuer thread
      workqueue: remove useless unlock() and lock() in series
      workqueue: fix a piece of comment about reserved bits for work flags
      workqueue: use BUILD_BUG_ON() for compile time test instead of WARN_ON()

Sean Fu (1):
      workqueue: Use IS_ERR and PTR_ERR instead of PTR_ERR_OR_ZERO.

Sebastian Andrzej Siewior (2):
      workqueue: Use rcuwait for wq_manager_wait
      workqueue: Convert the pool::lock and wq_mayday_lock to raw_spinlock_t

Zhang Qiang (1):
      workqueue: Remove unnecessary kfree() call in rcu_free_wq()

 include/linux/workqueue.h |   2 +-
 kernel/workqueue.c        | 207 ++++++++++++++++++++++++----------------------
 2 files changed, 110 insertions(+), 99 deletions(-)

-- 
tejun
