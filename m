Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBED25DD7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbgIDP00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730784AbgIDP0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:26:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD3EC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:26:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so4814316pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5282YCIbjYXuoDELr0tgCw3lmbT1e3lQtz3uBh49A5w=;
        b=KqciaOouN3G0T0BpZ+nf3ctA74+2AtRh6tEhtU9HzF5zny++REty5f+5upK7wBTdT0
         ZSD1SVZWQRZRcM/2VKoRlJEA5LO8fEpumqdT7HRfaWci2v8omzhLuF4oEKWy8QmNqH0r
         iPE7seIHejvz+6TspV1qVue7CafhahPjlFPiVLzX6Wtn/smZZlQ/apex3bFHk5HZ23rE
         KeynWoZJf++xordcvhc1Nab8GR6aO2Wu3rQgs/Sj9n9aMrnnKyu6xxryFYgS66oRvl6h
         B1N5+V0mjXaWnnJz1F7iDCqhQwMBIYaNRHZSbiM3cv8UFkl1qSagq5pXLYUwm0+CTrXq
         T0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5282YCIbjYXuoDELr0tgCw3lmbT1e3lQtz3uBh49A5w=;
        b=QugOsVXNyTiIjLACd6kx/ElxiFHX82rquAWyAmtTrutIdoCQDnX/VBdzyOSj6ix+5n
         kMAlk33gQsCMemwmfJ6uZFiRQ8FixTy7o3QXdFU09C4MIEsxLSivytmev0/tGO21ZNvs
         Kw721mJ0TtyLuTbQ95fuW71J8hNNt9w4VQ9dQ5zt1yTcsO/gGSGBkcvy5JxVi+hLKXk7
         U5cMucSc6YOPW+kXY/f8dvRRpct+OWtC8kMHPi24gTYrPbhyzTxHwRUatOvglhlQM4Ij
         Btbminl9SOZA4qgUVt3P+j0nXYtEPe6/RfhTtu8JpYb2ZAKhS0chFv9QMp4NEfYkR0xJ
         FxAQ==
X-Gm-Message-State: AOAM531tZsegqBca2QzwQTOPg4P/pVJk/Nw/tzz+Ntlo/e8s7W56/vap
        GriZ9d14m0Tvi88GK0P77rZtcHmSBm6mXPde
X-Google-Smtp-Source: ABdhPJzWB1+Vzj3MMeE+uWismLmPVQESORqcKfWp3rBhgKzrwzRcqAem1QG2+r6cwXW16qiQ02z6kQ==
X-Received: by 2002:a63:a53:: with SMTP id z19mr7435489pgk.67.1599233176257;
        Fri, 04 Sep 2020 08:26:16 -0700 (PDT)
Received: from [192.168.1.11] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v10sm6707177pff.192.2020.09.04.08.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 08:26:07 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata fixes for 5.9-rc4
Message-ID: <ecf36c20-0cfd-9010-84f7-334e3ea3b67d@kernel.dk>
Date:   Fri, 4 Sep 2020 09:26:04 -0600
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

- Improve Sandisks ATA_HORKAGE on NCQ (Tejun)

- link printk cleanup (Xu)

Please pull!


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/libata-5.9-2020-09-04

for you to fetch changes up to 3b5455636fe26ea21b4189d135a424a6da016418:

  libata: implement ATA_HORKAGE_MAX_TRIM_128M and apply to Sandisks (2020-09-02 11:31:23 -0600)

----------------------------------------------------------------
libata-5.9-2020-09-04

----------------------------------------------------------------
Tejun Heo (1):
      libata: implement ATA_HORKAGE_MAX_TRIM_128M and apply to Sandisks

Xu Wang (1):
      ata: ahci: use ata_link_info() instead of ata_link_printk()

 drivers/ata/ahci.c        | 3 +--
 drivers/ata/libata-core.c | 5 ++---
 drivers/ata/libata-scsi.c | 8 +++++++-
 include/linux/libata.h    | 1 +
 4 files changed, 11 insertions(+), 6 deletions(-)

-- 
Jens Axboe

