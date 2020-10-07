Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6472868A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgJGTxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:53:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47012 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgJGTxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:53:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id r8so3033206qtp.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xk9LAQPuEe9GFuiMRhVrHYjn4Gx46lgQdVs1DWPuRb0=;
        b=YkxCab0pZYrlLsUQd+jpQZ7vfp7LXhdyWclut2lQ2BvgVD3MncMW+hByUOba5OgXxd
         dTPpiEQvEWLXzGUVfXkrrjBXyAOLqe6OTuNVLgtvGcwApmm6gwEzIOSNl95S2rkBDTWc
         GUIUk7ob6hs3KDJmV0T+XdLuvi9GMrlINcxrn1NuubyuNUjwxaCSxFB6zbEAte0/O9D1
         GzPGAS9dbwvrxc+3pqNKnhosQYaYmd6K0aGb05V17HYWWBQchbS04gYCzS30JGuxlij5
         mt91d4rajb4PeOJ19TXzUsr/rNIGyzwygGzvdJ7JOD+7kiWCLexC4D6/bUzBTN0v/beV
         aMWg==
X-Gm-Message-State: AOAM530H2mzUtz4tgi6QeM4L64K5y5HcugEdeh4dKLn++2e8bLbl4w9c
        chBqnGFKTuCVGh9Lf/7klRs=
X-Google-Smtp-Source: ABdhPJyTMyHKyLZ0aIJ8bJuTvlPOuzzrnrpnTgSOLD2cdfwDDQC6XnaFcPVtHw1tR2xtugLU26q1nA==
X-Received: by 2002:aed:3145:: with SMTP id 63mr5139816qtg.29.1602100433027;
        Wed, 07 Oct 2020 12:53:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k20sm2287658qtm.44.2020.10.07.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:53:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Couple of bugfixes to sev-es series
Date:   Wed,  7 Oct 2020 15:53:46 -0400
Message-Id: <20201007195351.776555-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the SEV-ES series, the kernel command line is no longer guaranteed
to be mapped on entry into the main kernel. This fixes that, and a
stackprotector issue that cropped up on head64.c.

The first three patches are preparatory cleanups. Patch 4 fixes the
mapping issue and patch 5 disables stack protector for head code.

Arvind Sankar (5):
  x86/boot: Initialize boot_params in startup code
  x86/boot: Move get_cmd_line_ptr() and COMMAND_LINE_SIZE into misc.h
  x86/boot/64: Change add_identity_map() to take size for ease of use
  x86/boot/64: Explicitly map boot_params and command line
  x86/head/64: Disable stack protection for head$(BITS).o

 arch/x86/boot/compressed/cmdline.c      |  8 ------
 arch/x86/boot/compressed/head_32.S      | 11 ++++----
 arch/x86/boot/compressed/head_64.S      | 34 ++++++++-----------------
 arch/x86/boot/compressed/ident_map_64.c | 18 ++++++-------
 arch/x86/boot/compressed/kaslr.c        |  6 -----
 arch/x86/boot/compressed/misc.c         | 10 +-------
 arch/x86/boot/compressed/misc.h         | 13 ++++++++++
 arch/x86/boot/compressed/pgtable_64.c   |  5 +---
 arch/x86/kernel/Makefile                |  2 ++
 9 files changed, 43 insertions(+), 64 deletions(-)

-- 
2.26.2

