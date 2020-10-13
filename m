Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6028D19A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgJMP4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731302AbgJMP4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:56:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56694C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:56:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 32so479182otm.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=390uKJTlgBk/uFtYKzYc+ATuZvhQmzATp0Bpd2mu/RI=;
        b=JQuVsRVzWvimcRbeOgJaTLVAHUS3bps/06MhqtIadV7epIIbyJ8WRk/P3cuoV8Dngn
         k+vXKGtxea4wA/iMd9JSBNr8UuBA04nFRow4gjzvpCRIofdgdW+Q494yxjso8FqQuHGB
         jNZNDCHwqIaAw9wPsFaQTKUJjlmbsNwv2/xU0+B1Cv2yHm0uc/H3Ipfwa2BpPNRNlD21
         BhIB6Lw9q1jctmHQgc45fOKP5AAPwIeaBJYcuVwVglJYLYU/ezvRQwQTv6zBt82L/2PO
         4cfIT4i3OwiyfbzFFxPcfjfeRn5g57A0PqyCxUMjUt8ZO88jz9rMHnRUDXfF0ZL1UnuS
         sa1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition;
        bh=390uKJTlgBk/uFtYKzYc+ATuZvhQmzATp0Bpd2mu/RI=;
        b=ks2DDAFRgkif61z7orMe4lxct6qeIdIK3dm6CHVoLEFG+ItdLVfoOCxGnYiSsAh9vg
         WTlylj7AS1PG2Hr9Ba7oDu3To5hUwQG7twuji/PJzpMghLzMgTMIrTtNpg731TAWJEQq
         PHaXJkHbY1aExZa4nagtPh9sWBcfJAzeuTITVtIBTuqGHgB3WqaGVRz+VsEThkxba6rU
         h/pnFYRvGTb1j8CdSz/MCIoQR2Paa5K5XFZw5nU10ozqyJSvWOdABimNT2vg9Dd+Poyz
         vQCZWqatPYKHGDhYJ2yMw6gne3vN7W4J+PpSdW/L9rY1cscKxrPdWIrnWFicCdMVHCnW
         2lQQ==
X-Gm-Message-State: AOAM530dZSBTcqbIzu9EBgG2H43PKPVpb7Jhi13E70C+pTe+rh9f/RVU
        h2r72416QO5tZ5QggLP4EZeV4Ot6kTy9
X-Google-Smtp-Source: ABdhPJwNgBjLO28OG8TWGz6hEl4ncKoFMYPr6twvnYksFD9Sib05QvB0GJo/DIpr86LXh5seRpo1Wg==
X-Received: by 2002:a9d:6:: with SMTP id 6mr192462ota.235.1602604612530;
        Tue, 13 Oct 2020 08:56:52 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id f70sm41963otf.32.2020.10.13.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 08:56:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b::80])
        by serve.minyard.net (Postfix) with ESMTPSA id 2BA8B18000C;
        Tue, 13 Oct 2020 15:56:50 +0000 (UTC)
Date:   Tue, 13 Oct 2020 10:56:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] IPMI bug fixes for 5.10
Message-ID: <20201013155649.GD66562@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fc80c51fd4b23ec007e88d4c688f2cac1b8648e7:

  Merge tag 'kbuild-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2020-08-09 14:10:26 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.10-1

for you to fetch changes up to 8fe7990ceda8597e407d06bffc4bdbe835a93ece:

  ipmi_si: Fix wrong return value in try_smi_init() (2020-10-05 13:30:51 -0500)

----------------------------------------------------------------
Bug fix pull for IPMI for 5.10

Some minor bug fixes, return values, cleanups of prints, conversion of
tasklets to the new API.

The biggest change is retrying the initial information fetch from the
management controller.  If that fails, the iterface is not operational,
and one group was having trouble with the management controller not
being ready when the OS started up.  So a retry was added.

----------------------------------------------------------------
Allen Pais (1):
      char: ipmi: convert tasklets to use new tasklet_setup() API

Corey Minyard (1):
      ipmi: Clean up some printks

Dan Carpenter (1):
      ipmi: msghandler: Fix a signedness bug

Markus Boehme (1):
      ipmi: Reset response handler when failing to send the command

Tianjia Zhang (1):
      ipmi_si: Fix wrong return value in try_smi_init()

Xianting Tian (3):
      ipmi:sm: Print current state when the state is invalid
      ipmi:msghandler: retry to get device id on an error
      ipmi: add retry in try_get_dev_id()

Xiongfeng Wang (1):
      ipmi: add a newline when printing parameter 'panic_op' by sysfs

 drivers/char/ipmi/ipmi_bt_sm.c      |  4 ++-
 drivers/char/ipmi/ipmi_kcs_sm.c     | 15 +++++++----
 drivers/char/ipmi/ipmi_msghandler.c | 52 +++++++++++++++++++++++++------------
 drivers/char/ipmi/ipmi_si_intf.c    | 19 +++++++++++++-
 drivers/char/ipmi/ipmi_smic_sm.c    | 35 +++++++++++++++----------
 include/linux/ipmi.h                |  2 ++
 include/uapi/linux/ipmi_msgdefs.h   |  2 ++
 7 files changed, 93 insertions(+), 36 deletions(-)

