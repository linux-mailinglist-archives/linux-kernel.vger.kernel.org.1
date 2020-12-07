Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43FA2D1DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgLGXBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgLGXBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:01:04 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C06C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:00:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id w6so11867284pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 15:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Dh1XEUZFU0rBKI4unyY9sbzctjuDcRhFnopkgAiigbE=;
        b=Crdm1AuR/AUnMxd5S5qi2l8vPo/5dlF+feJsw3b7wSKRiNdN04dm9KZrnr8Cn1zyNC
         1o/hOb87HC2zstxizFekv2tddydn4uwp6g+OUuqaUiaS+Sq9GyHJ/O0no7iE93aBJURv
         ajY/+Xj7QnrzP4hceOLgjF/nNm1K6KvhVCovmoMdHu/zISTXDpfvbM7P3tJdfZ4IG3KI
         u1SWpWB7Y4T/FKzAA7Q3LsMv5TSK2SCkkyCaIgggtValFKjnBj4qP96KjZbHVR+6pufJ
         vDjOGK2CDUQWY6ExsyBHQnKd0wWGXMdMBPKxWMEHyYeaQ6L7f29YSdH8jVewc6U/BDn3
         Sh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=Dh1XEUZFU0rBKI4unyY9sbzctjuDcRhFnopkgAiigbE=;
        b=Wjo29uN63aHFoIvZXQm4u+gyIh06P/S1/Mim/9tQKSFsLNFuwKn35jm93ufV+gyXDV
         O0aNGBjSLXx+hJOI+j6+D6sA3sEVzsCdSyKturpHb5V0eugLcyfkA9JD8PFVNEl90Yqw
         zgSPwE6Qu5JkawGUQ8bx3lBFdQv6JN0uU0xSw3NKECJN0tkkwjWR5XIch1wvOugH3Qae
         joapmvEwf+dnV///l58t3ynFkC4jiuCpYQYu4h5kTSOfS4vW1XiEIAt2Sifp4Lpefy68
         dyL1JH6bzaPu+WkF9zmst3FWXQrEcdIcqShjUnOMK4N3nYRHlqvit9UBxDYUxHMHHubu
         Fulw==
X-Gm-Message-State: AOAM533bixW0hqySwk7pFmhgGtIOcJ8Cc0RGkw1MeggLaY9H2y2yKD2W
        jvduL/3cit84ojBOX4LBMk/w7RsXX3RSaw==
X-Google-Smtp-Source: ABdhPJyUEc2S6n+542AJ3SAwDElOHrAh2Bj8EgIz8EGoisOW/S6Z1jMcUNRPMByv9TBjaIOyM4ETFg==
X-Received: by 2002:aa7:8d8b:0:b029:19e:1081:77af with SMTP id i11-20020aa78d8b0000b029019e108177afmr6461153pfr.78.1607382018107;
        Mon, 07 Dec 2020 15:00:18 -0800 (PST)
Received: from [192.168.1.9] ([122.174.249.115])
        by smtp.gmail.com with ESMTPSA id i14sm13522636pgm.35.2020.12.07.15.00.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:00:17 -0800 (PST)
Message-ID: <b65ca811947006b04e6027e30649c263a787323d.camel@rajagiritech.edu.in>
Subject: [PROBLEM] kmemleak: 2 new suspected memory leaks
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Dec 2020 04:30:15 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,


kmemleaks  found. see related information below...

------------x------------------x------------------------>
cat /sys/kernel/debug/kmemleak 
unreferenced object 0xffff8881105d2348 (size 8):
  comm "kunit_try_catch", pid 139, jiffies 4294898877 (age 6055.628s)
  hex dump (first 8 bytes):
    74 65 73 74 69 6e 67 00                          testing.
  backtrace:
    [<000000001d6f9546>] kmemdup+0x23/0x50
    [<000000007157804e>] unpack_strdup+0xc7/0x140
    [<000000000fcb0a94>]
policy_unpack_test_unpack_strdup_with_null_name+0xd0/0x350
    [<0000000043df290a>] kunit_try_run_case+0xa6/0x150
    [<00000000c069ee6a>] kunit_generic_run_threadfn_adapter+0x2e/0x50
    [<00000000929a25ad>] kthread+0x232/0x260
    [<00000000e5de2862>] ret_from_fork+0x22/0x30
unreferenced object 0xffff8881105d2bb8 (size 8):
  comm "kunit_try_catch", pid 140, jiffies 4294898878 (age 6055.624s)
  hex dump (first 8 bytes):
    74 65 73 74 69 6e 67 00                          testing.
  backtrace:
    [<000000001d6f9546>] kmemdup+0x23/0x50
    [<000000007157804e>] unpack_strdup+0xc7/0x140
    [<00000000ba70df5f>]
policy_unpack_test_unpack_strdup_with_name+0xc3/0x340
    [<0000000043df290a>] kunit_try_run_case+0xa6/0x150
    [<00000000c069ee6a>] kunit_generic_run_threadfn_adapter+0x2e/0x50
    [<00000000929a25ad>] kthread+0x232/0x260
    [<00000000e5de2862>] ret_from_fork+0x22/0x30
--------------------x------------------x--------------->

Reported-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

-- 
software engineer
rajagiri school of engineering and technology - autonomous

