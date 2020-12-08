Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3F2D30DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgLHRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgLHRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:22:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9460C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 09:21:52 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g18so12784857pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:references:user-agent
         :mime-version;
        bh=1txzdi4LrtLpEkhyaGd3WhDsio4NPh8e5/se8kxUFmA=;
        b=gEzxnXX4QgdBN1At+xjVEaEAe9lMGJXNhHwJsnH+AnJOJIrf/6DSYsEz9++pANskLT
         TD3iR6d0rgKKP03UfN2ERMwEI9IItHtHN1tcQIApSkfBBWCS+RabKvVmg+5L9G3GzKHo
         BCt6QYeRQCisUImoqbVrWMJoVpuhn/Km4GKB3doBTw/haqw1UW+xrFC3tZseuacaFmki
         VEXY1OwOoQrU5Uj4Ke6bGjwVDXpzfzT6NcRPhOET1CcHg4HN3ZqjfYQIykTWn2CHfWtF
         ppA/i1Yodo0SoqRIgejTHSYPDTi8kPp7s1WAQLfxiPnDwav7N5zj9pHlEPxuVw89ThUO
         AI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:references
         :user-agent:mime-version;
        bh=1txzdi4LrtLpEkhyaGd3WhDsio4NPh8e5/se8kxUFmA=;
        b=Ex3dfNiJePb5eTwaOM1RYysiIWBT7gFcbe6cOeuUYsqYOLglBLKsieyGULf3XUOWva
         PN/SSFbNcfViubNIpagiP/PoZqe0jY1+C+1Ys8FuBrGw2LoZhab4JtQLPJQCSSmMc9Yi
         clbLv48rl2vMcZ3DzZHBszDG3kKC3zxU8ftKo+2rmOy4fPuRsgyIC93ALrGZFVgZ07Or
         coKsIgkIRe2Ii1nAKsqXhYg8gInGBxOLEJkkGYf33babQhVxCxgtsyZt9+94wdFRGbad
         JeEXLXnjjTLWQcQJXWo/zlWr9B/e64J9cz/pVABltVHdGiiDdxEXqFMYn2aW7rM/lISH
         Z2nw==
X-Gm-Message-State: AOAM532XbnV+9qAhrJ3eGgL0B8R8CVGKK+0KzlAsaw2QhTlsePSEC603
        WOFTFIxDKcIYq2VP5ngQ0Xt0vA==
X-Google-Smtp-Source: ABdhPJyV/JZEtgpK+FuUz+fVYukAiK4A3pbFw67xZzHeNTHEo2u77cIPxBzJzjEVWlvI6OmTRstR7g==
X-Received: by 2002:a63:1d55:: with SMTP id d21mr23041195pgm.324.1607448112434;
        Tue, 08 Dec 2020 09:21:52 -0800 (PST)
Received: from [192.168.0.4] ([122.164.38.199])
        by smtp.gmail.com with ESMTPSA id j14sm7219101pfi.3.2020.12.08.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 09:21:51 -0800 (PST)
Message-ID: <1b2a426b865df93c6e6d8efe8312b9591a1e4efc.camel@rajagiritech.edu.in>
Subject: Fwd: [PROBLEM] kmemleak: 2 new suspected memory leaks
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     brendanhiggins@google.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     kunit-dev@googlegroups.com, lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Dec 2020 22:51:48 +0530
References: <b65ca811947006b04e6027e30649c263a787323d.camel@rajagiritech.edu.in>
Content-Type: multipart/mixed; boundary="=-T7C4rXS5LInIDXAodK4F"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T7C4rXS5LInIDXAodK4F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-T7C4rXS5LInIDXAodK4F
Content-Disposition: inline
Content-Description: Forwarded message =?UTF-8?Q?=E2=80=94?= [PROBLEM]
 kmemleak: 2 new suspected memory leaks
Content-Type: message/rfc822

Return-Path: <jeffrin@rajagiritech.edu.in>
Received: from [192.168.1.9] ([122.174.249.115]) by smtp.gmail.com with
 ESMTPSA id i14sm13522636pgm.35.2020.12.07.15.00.16 for
 <linux-kernel@vger.kernel.org> (version=TLS1_3
 cipher=TLS_AES_256_GCM_SHA384 bits=256/256); Mon, 07 Dec 2020 15:00:17
 -0800 (PST)
Message-ID: <b65ca811947006b04e6027e30649c263a787323d.camel@rajagiritech.edu.in>
Subject: [PROBLEM] kmemleak: 2 new suspected memory leaks
From: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To: lkml <linux-kernel@vger.kernel.org>
Date: Tue, 08 Dec 2020 04:30:15 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello,


kmemleaks  found. see related information below...

------------x------------------x------------------------>
cat /sys/kernel/debug/kmemleak=20
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

--=20
software engineer
rajagiri school of engineering and technology - autonomous


--=-T7C4rXS5LInIDXAodK4F--

