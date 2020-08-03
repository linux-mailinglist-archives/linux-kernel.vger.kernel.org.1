Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A468D23A337
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 13:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgHCLTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCLTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:19:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD30DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:19:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a14so9959116edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yt2CQ4mEA+v+i4qYpuZtQGRYlnkgIUzokoPIBHJuBTg=;
        b=YlfyRotm3w5wDQfeKrKP2cdZysJN9RZw7/ANPL3wrNcg0H7JRYfv+lpBXYikfrHzlO
         5upydISXjF9t6DkM6Hdq7sb5dC+1B/4fgbpEknjXDyT2erltiLVoS+2kkOk6mseXvaLT
         kg7gwJ9rhJ4rvrJSUa0Ff8eKNlEQkQQ3u+PRvmHdTGm13d9XldRa3KKmobjxDb763fRf
         YgqC8ZnJ9q0RK5x45OVIAloiUt9HBwk8tNo9CJBN3dCwRLycnY2K7JS2WIsf5fO7GgYS
         elV+ofXO4O7RhuxHrn3/6cLgq7Pcvvol8tE7Sx5QVe1WZ2ikUG9OvhT6OUcq1wqXs3fP
         EuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=yt2CQ4mEA+v+i4qYpuZtQGRYlnkgIUzokoPIBHJuBTg=;
        b=AK5TLRsZSX7jsCt+TelkyejHxGjCYKAQvn5emU9eKWwr/yUAscKPyjokUq1Tjd5CqO
         +wzQ/GBN/AaQ1wKm3a/pkLZJr8FTTpEmutU2acwTbom87TWo5OfFErQmNg9hrOiWXk3i
         WvOANXcDg+fwG9A+4zO2KpHU9KMnbh218sCtpKGbnl31qgFOcAP/AlN9zgvt4BRn1k8K
         VGKL0leqdwXtnM9c09gKwJr8n+mX7oTuwcLEBvvsYI5qHlEz/eqCsQ7vnFPqbUl6hdlu
         Cls8X/I+VVshPEhrZCfcyEB/+2DLW9aNLV1CZbWFwJi6ri12sB7PD9bu5sfSF6MrZ9jd
         b+8Q==
X-Gm-Message-State: AOAM5326D/yxYsEyILzuqccmWIXulAjolId8UR0ZDX6MjQLBkAMlUHX2
        A2+fqg8+FtbOA/IvXjLdQh2VLjxZ
X-Google-Smtp-Source: ABdhPJwPd2OvjujSqF/XSczoOHpvBM4Iubz39NxYBfNWpr7i9Y8bcSSus5BXRmq6FAv1Y5pzMor3fQ==
X-Received: by 2002:a05:6402:1591:: with SMTP id c17mr15052621edv.111.1596453550565;
        Mon, 03 Aug 2020 04:19:10 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i9sm16067807ejb.48.2020.08.03.04.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:19:09 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:19:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/headers change for v5.9
Message-ID: <20200803111908.GA384254@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/headers git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-headers-2020-08-03

   # HEAD: d19e789f068b3d633cbac430764962f404198022 compiler.h: Move instrumentation_begin()/end() to new <linux/instrumentation.h> header

A single commit that separates out the instrumentation_begin()/end() bits from compiler.h.

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      compiler.h: Move instrumentation_begin()/end() to new <linux/instrumentation.h> header


 arch/x86/include/asm/bug.h       |  1 +
 include/asm-generic/bug.h        |  1 +
 include/linux/compiler.h         | 53 -------------------------------------
 include/linux/context_tracking.h |  2 ++
 include/linux/instrumentation.h  | 57 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/instrumentation.h
