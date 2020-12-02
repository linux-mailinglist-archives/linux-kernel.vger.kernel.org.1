Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C183D2CC6E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgLBTo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbgLBTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:44:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B76AC061A04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:43:22 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n10so1566373pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=YF75IQFrFR9lc2ZpHVjvfB/8yVqBDhiF67vZoco548s=;
        b=LK3B5kyjjLKre8Q41VpprzisQIomIq7nujK/DzxZsHoT512B7QLHbcAnbYIsUKWjgi
         CO9WtY8HBBXOGtXf9KXYEKriygyrVIWCfSQut06JRUYoLOFi3rMzh3L2v1wjBNlG+DwM
         Mzntr6IyFG4QQQ8E9XdanTAF0FrDNFeqQzqSJB4ciF4GU72puXbS5LBZx22OLmA9ZZ8d
         zzCgTD+drGKhwPxzk5GywpndFrxU6lOMuFRlh1xlZ+ZY5NovP0k5IWCho/QIOop0eiRx
         hvQ2jTr0S/uHls2gkO/f9h3kDnMHB50lv12qqQhtNcm6ywg6jluVntdc6dOUmEqs+nxk
         78mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=YF75IQFrFR9lc2ZpHVjvfB/8yVqBDhiF67vZoco548s=;
        b=OTIfehv25xl1O2mCTjHb4DRxIgNz8RZElUL9oedChahyCGdh7B0bANGRY0bcFeTYHy
         iUgj11WMHYFlxXUoExzr5FC1/WqyJQl2hXklXMdQ9RqIB24FRVKm+0l/cBVfpjoZ9cF2
         VAs0O9U1JVTuoEZBVxU1NfXOsYvKIZNal0vRPf9Im+UL/IibHDDQ+/ZnqXx4gncmjN78
         KwlmBwXoxMtKrA1Pdo5jy+rPiTddTmwRupGc0QXygDzF9oO89vJFjIrweXrxvr3fFdv3
         p8Cbd+IuEMSNPQdaNCNMbcLvDdxFI4gvcEARAXA7vJjrbZ+rZSWvyomW6haNosBtdPIj
         Z5KA==
X-Gm-Message-State: AOAM533jwlZOQn9L99idP9Q7orizbf9hxjcOcPpNBB3+0q65K/wXFs+U
        IBwDtEm/0bDn4T3oEDoUVdVv5w==
X-Google-Smtp-Source: ABdhPJy+6yvDuPZXIu59qKejZBIOViQDc5/g+qVZE3j+nWEBfBEyvwpguYLMYq2oqrCn2uEL2Ni+rQ==
X-Received: by 2002:a63:4:: with SMTP id 4mr1243367pga.443.1606938202063;
        Wed, 02 Dec 2020 11:43:22 -0800 (PST)
Received: from [192.168.1.9] ([171.49.174.71])
        by smtp.gmail.com with ESMTPSA id u24sm598229pfm.81.2020.12.02.11.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:43:21 -0800 (PST)
Message-ID: <3d513cec41d7eb223240741bdbcffe7af3a49c18.camel@rajagiritech.edu.in>
Subject: [PROBLEM] drivers:hid  2 memory leaks suspected
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Date:   Thu, 03 Dec 2020 01:13:18 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

2 new suspected  memory leaks. 


$sudo cat /sys/kernel/debug/kmemleak
[sudo] password for jeffrin:
unreferenced object 0xffff88813128bee0 (size 16):
comm "irq/109-ELAN130", pid 152, jiffies 4294931163 (age 9576.624s)
hex dump (first 16 bytes):
04 03 08 0a eb 03 24 e7 01 80 13 44 00 00 00 00 ......$....D....
backtrace:
[<00000000eff80361>] kmemdup+0x1a/0x40
[<00000000552197bd>] hidraw_report_event+0xbc/0x190 [hid]
[<00000000a102ccd5>] hid_report_raw_event+0x70a/0x790 [hid]
[<00000000b1b8f73f>] hid_input_report+0x1b4/0x210 [hid]
[<00000000e0f74a09>] i2c_hid_irq+0x164/0x1e0 [i2c_hid]
[<00000000a79c6ce4>] irq_thread_fn+0x40/0xb0
[<0000000037a84810>] irq_thread+0x23d/0x330
[<0000000009e057aa>] kthread+0x1cd/0x1f0
[<000000005e7b7b46>] ret_from_fork+0x22/0x30
unreferenced object 0xffff88813128b640 (size 16):
comm "irq/109-ELAN130", pid 152, jiffies 4294931165 (age 9576.616s)
hex dump (first 16 bytes):
04 03 02 0a ee 03 74 e7 01 80 13 44 00 00 00 00 ......t....D....
backtrace:
[<00000000eff80361>] kmemdup+0x1a/0x40
[<00000000552197bd>] hidraw_report_event+0xbc/0x190 [hid]
[<00000000a102ccd5>] hid_report_raw_event+0x70a/0x790 [hid]
[<00000000b1b8f73f>] hid_input_report+0x1b4/0x210 [hid]
[<00000000e0f74a09>] i2c_hid_irq+0x164/0x1e0 [i2c_hid]
[<00000000a79c6ce4>] irq_thread_fn+0x40/0xb0
[<0000000037a84810>] irq_thread+0x23d/0x330
[<0000000009e057aa>] kthread+0x1cd/0x1f0
[<000000005e7b7b46>] ret_from_fork+0x22/0x30
$


[ Details about System ].

Linux debian 5.10.0-rc6 #4 SMP Wed Dec 2 02:49:21 IST 2020 x86_64
GNU/Linux

GNU C 10
GNU Make 4.3
Binutils 2.35.1
Util-linux 2.36.1
Mount 2.36.1
Bison 3.7.3
Flex 2.6.4
Dynamic linker (ldd) 2.31
Procps 3.3.16
Kbd 2.3.0
Console-tools 2.3.0
Sh-utils 8.32
Udev 246

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology - autonomous

