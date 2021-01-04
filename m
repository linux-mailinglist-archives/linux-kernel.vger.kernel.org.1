Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54F32E97F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbhADPBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhADPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:01:06 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DDC06179E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:00:05 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v14so18702716wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zX8HfL31wQZp5jl2djKi9uuAu6EFw+BifBJL8TfPFYI=;
        b=iZ+iMncSyLwlAaQXDZtSclG1TAiabyBIgpxpm6gwMhtwbK9uLIPw0KJkoz4mOk9f0F
         rHnD2/9O68rmG8J+8w2HgaVnFZ5OEFNHNYLnPI+b1SbXBAU263EFyuSKd5cB4ybDV2Tk
         Q2Ucnog/Ug5GYE+l8FlOnNY6Dt/g0EgWKtnjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zX8HfL31wQZp5jl2djKi9uuAu6EFw+BifBJL8TfPFYI=;
        b=ODSizv7waAUAERnymf9hiNT9Xco4l9DznJ+KxJHaOBZrdeLKam1daZBzjF/I/wwgqK
         pr6lxJ9MNspYjlWeTjpP14irOnSALFxLnJWYLfT5y5AeA6dMBCGkCht+YMs6lyhYcz0T
         QpODn692DBC1k0sF90b8mnfPSbaVkU9u3vo0vMHpIINe52ufuiezkRVG6c2wiN7oVsaE
         yf+pDYjCeHHvuiNaI7tHvrRAtYHHG3KdDvQu1229ZTSoP9jnKMSN0PKANikSvEUNvwmr
         f/eTEudwjKZuiacOsyYg076hZDnQCbdboAJzyQvYxx2cAl71AZLA383JmqY2/vgXlIq4
         fNug==
X-Gm-Message-State: AOAM531nk494IZvKaESbNo6vaAfBq3PIhRQzBC30qABiQr+SlCIFzRUj
        66d9KquVtwah+aVGZT3G4IvGKQ==
X-Google-Smtp-Source: ABdhPJyZ7mnenRW8F7aJHWIfVzmZOehv2AMU4Up9FryPAzuecSePdIqVbZnPsKBWirVBfeRygVofGw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr26716903wme.72.1609772404590;
        Mon, 04 Jan 2021 07:00:04 -0800 (PST)
Received: from dev.cfops.net (165.176.200.146.dyn.plus.net. [146.200.176.165])
        by smtp.gmail.com with ESMTPSA id r1sm94445954wrl.95.2021.01.04.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 07:00:03 -0800 (PST)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        mail@maciej.szmigiero.name
Subject: [PATCH v3 0/2] dm crypt: some fixes to support dm-crypt running in softirq context
Date:   Mon,  4 Jan 2021 14:59:46 +0000
Message-Id: <20210104145948.1857-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
  * 0001: handle memory allocation failure for GFP_ATOMIC

Changes from v2:
  * reordered patches
  * 0002: crypt_convert will be retried from a workqueue, when a crypto request
    allocation fails with GFP_ATOMIC instead of just returning an IO error to
    the user

Ignat Korchagin (2):
  dm crypt: do not wait for backlogged crypto request completion in
    softirq
  dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq

 drivers/md/dm-crypt.c | 138 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 15 deletions(-)

-- 
2.20.1

