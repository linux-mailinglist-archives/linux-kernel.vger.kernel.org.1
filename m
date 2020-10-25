Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060052981E7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 14:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416350AbgJYNgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407408AbgJYNgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 09:36:41 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDB3C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 06:36:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z33so4846596qth.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=He1XrdVgxIH1LU2JaG2jhKSzWpZofSmhHtZ+UJ2yyrs=;
        b=rzO3IzA9VDPYABQjLq7A9ut6CkhlupvyQ7hBTRJxXCiE6P3TgkaIYaWYz7rk+YAJrb
         yOWxbK5tZg86UNpyiGhskwa3YUYxxxia5dMJvO4MYihYSFdG912j72A84Ri1/bHgrg2u
         PAa7bPRqN7CGSHIY7u/+O4cWXKQIDILf5hoyCkF3mzQVUpyggyJZnRuNWgdd5mx2yJ8k
         SWxILtM8v1Pf2pN8MwlxvSNJfKqgtidU7DeeJmRysTEfavkhCDQEe/zonT5yv1go29Mj
         WGkjkqJHseUBaRSilEadJpD25Hi9R9HpN6CmeOq4biCtz+LYYRDS24LPIxnVWAqelZ9j
         DTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=He1XrdVgxIH1LU2JaG2jhKSzWpZofSmhHtZ+UJ2yyrs=;
        b=MfaetBnF972J1/sX9v9IxrPtsysGUsPQx/eSZFeyTereVSFzGo68nn43RNih01SniJ
         Wt4YQMn1YXU1A7WhZEMwpUNEn5d+UcTqeTmAflCVOaLPpsJFox0NdTIjhgMXUJNjjAnk
         lyq2eZMxedUPk/5B3EAYNd8LEinXK/jDBuWUPc4sBUghq2x889iJqMLYYiTFSGDR/Vbf
         db9UORNyQFWtBZJRozFX4HtQucyrJInaj+PUvrxg6hfvRxXQIuh0iUbnLQt2ee9yBFz2
         1hCvP6lRyAopQy01dCwuK6w2GyDPlsfEJnYg/NSNboOQq5UsXNZjEc4HPSkT4799KBbY
         DcoA==
X-Gm-Message-State: AOAM530+FdvWOXBrK75XumeIAcejNQqeuTz0tq+ssn01L2RETZ7O90h0
        tP1qbQDVNSknqfPwYEd3Lnilp0JowyZ3mof6
X-Google-Smtp-Source: ABdhPJwwHplulU6tQVr5vIVSpW9Ye39p5w2aDUn6+QaF4j56tiT2RJxbSuCckNSuhf7xZ6LmSHxjDg==
X-Received: by 2002:ac8:5985:: with SMTP id e5mr11696126qte.88.1603633000224;
        Sun, 25 Oct 2020 06:36:40 -0700 (PDT)
Received: from localhost ([136.56.1.171])
        by smtp.gmail.com with ESMTPSA id g15sm4529369qki.107.2020.10.25.06.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:36:39 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date:   Sun, 25 Oct 2020 09:36:37 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for v5.10
Message-ID: <20201025133637.GA7862@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes for v5.10.  Please consider pulling them.

Thanks,
Jon

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.10

for you to fetch changes up to b8e2c8bbdf7778c6e3c65db21ababb1dfa794282:

  NTB: Use struct_size() helper in devm_kzalloc() (2020-08-24 10:58:06 -0400)

----------------------------------------------------------------
Bug fixes for v5.10

----------------------------------------------------------------
Dinghao Liu (1):
      ntb: intel: Fix memleak in intel_ntb_pci_probe

Gustavo A. R. Silva (1):
      NTB: Use struct_size() helper in devm_kzalloc()

Kaige Li (1):
      NTB: hw: amd: fix an issue about leak system resources

 drivers/ntb/hw/amd/ntb_hw_amd.c    | 1 +
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 drivers/ntb/test/ntb_msi_test.c    | 5 +----
 3 files changed, 3 insertions(+), 5 deletions(-)
