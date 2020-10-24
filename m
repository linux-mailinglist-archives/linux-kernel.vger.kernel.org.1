Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2C297D15
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760885AbgJXPNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760505AbgJXPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:13:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F0C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 08:13:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b3so219910pfo.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rrEQykDrODQkLQpiOcBsqrByU32LwK4j/pL5QR7hh7g=;
        b=QPolDxdU+BfBLuZhmBjfXiAZyYgppijxwG5/xPJLDzX8tB4l9nGNmrTZXdGf3rvGJb
         ZgyfqRctadKDx5WM/BRN4uRqjCDpwimIUlb5fF8T2Et0jvdXgiEITArcHFYpm17qkrSJ
         wcQ9hGA4FCv3cszr9FxXS3jmWoDJAAh8WsWKE/SwbTkqszspGJxuGtEmC3fF9o7pxHmW
         ABfgHoX7m57sax1ocwQ+EszVHnCr4qTRlcG/PHoSiblZPPzxo292K1Imui+PkFoT2izI
         NZ6a4zSgVmmcSEk3xAqqA9tOdoWSu4AyRCA2dK4trG+pem3HaCeOkgeLoDVV6KJbuqWs
         RS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rrEQykDrODQkLQpiOcBsqrByU32LwK4j/pL5QR7hh7g=;
        b=Vd7HTUolKx59WwGwIetaVVqO5iMGQWMZG1GnXaoq+Dyyu2RZ+gU9qDRGoa16cVKntI
         T7E0pPuhohEoxvuaIVs5/q+2TeatONn4p2nO/t0hes1CPR+vr2qEBqP/ewsctEPsonOD
         dmSXVGw6OhRjeQt3Wwu4MvmD/hHkpZnMYWKSXb6qeO4rFo8KsJC5DdlS1t6PpgeRRbqV
         rPM06HcVCIh1dy5kX+EZx9j6DYb1M5gXiNpjZzWMfuP91vcFrwI9iCE4tz1M9MBrug4U
         TwMWnA5xmzH4WpxEm8oyRYm9HumT37uq9QtHj56E7cQEBcCubjD5OkiXSiB/eMRvhIwy
         WjyQ==
X-Gm-Message-State: AOAM5301hB0+WIam2O9YpR73+MhRQP/0hTHU67sWtOLFcLxo8ZiIRC5h
        PmWQhQGg6ayGRbWKOdbkiGEJ/AE3bZYoBg==
X-Google-Smtp-Source: ABdhPJx8SLX/yRDl+BovuhzZWsHxt7lwzWVlHqOxZn7NGHaSw0686dafC9SqX/fHfZ4IWxheYEg3qg==
X-Received: by 2002:a63:4e09:: with SMTP id c9mr7394919pgb.128.1603552410803;
        Sat, 24 Oct 2020 08:13:30 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id mt7sm2930308pjb.5.2020.10.24.08.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2020 08:13:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.10-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <78f005fb-c35a-9120-5299-c8bd1efb1216@kernel.dk>
Date:   Sat, 24 Oct 2020 09:13:29 -0600
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

Two minor libata fixes:

- Fix a DMA boundary mask regression for sata_rcar (Geert)

- kerneldoc markup fix (Mauro)

Please pull!


The following changes since commit 9ff9b0d392ea08090cd1780fb196f36dbb586529:

  Merge tag 'net-next-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2020-10-15 18:42:13 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.10-2020-10-24

for you to fetch changes up to 94bd5719e491564c61ee9f121d544e23b4e51374:

  ata: fix some kernel-doc markups (2020-10-23 12:20:32 -0600)

----------------------------------------------------------------
libata-5.10-2020-10-24

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ata: sata_rcar: Fix DMA boundary mask

Mauro Carvalho Chehab (1):
      ata: fix some kernel-doc markups

 drivers/ata/libata-core.c | 2 +-
 drivers/ata/libata-eh.c   | 2 +-
 drivers/ata/libata-scsi.c | 2 +-
 drivers/ata/sata_rcar.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
Jens Axboe

