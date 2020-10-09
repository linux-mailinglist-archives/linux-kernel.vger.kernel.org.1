Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE1288F49
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbgJIQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgJIQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:57:46 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA1C0613D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:57:45 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n2so10890443oij.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=EbwPy1y/PDnWF/XWV+k/167QLJ1qvpJCPajzvXyb2I8=;
        b=cUqrB4JklGqN2yfEv9pV2mxV3CrUk8jzQFzLjg/lPf/k5MuTY4NieXxa8mNd13wKr/
         tXtsmyaNFRo19sKPTYsLzsNt+EUQl4wUcJbT8kUytcNLrv6NHCfBf/0kFHGJ6aX/SuJi
         2+XZfjY+p8uTrypnBLiaMHRxyElVzGFNa7spJwfUyV9dpFuyeClwedAoXFxdSnCbQJoi
         kTwd1MRObH+PZeIsaAwEvHWMdPvq718+zMAmATiZGWwv/W42rF3WCk3qcH86Q8wzTmnU
         imB6Y9megyaxPfwP+FH5fxDL/+9BaMzo2RTvcybmv6LBzUPlbN67BPhnDgKGfYOgr5I0
         6oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=EbwPy1y/PDnWF/XWV+k/167QLJ1qvpJCPajzvXyb2I8=;
        b=bj7Tzt+rqf1xpxhS9V4/q/Pzoc4RvDAzDT1UPaAz7Pdtwdeikn5i3EAK3ofy9QpWyM
         qI8G1k5s2e2aW7bp6mHjxaEeNPA1b16c9IRIPIB3t9G6gpEx8PLYtrhCkCyur3QY4dTe
         dYm8okp7mO84uhYUY3Mn41ziWDQQ2T/ZPkjeBZKYr6HRf+F17jAz9GrrRLcksPud7aSs
         p6rXqdFY+0T1j3KKfgM1CbNVwHQgZeStR8yaDwPbQEDRQWaGuhUUZ5DgXxaKA7ZMA4ni
         Ssyh6hnTcn/+sZv3rlns4yC7DxQVgxx2Dmj1u/85xWC70WjVuAWfmjMfY+d7Ml6EF5do
         XqtA==
X-Gm-Message-State: AOAM5331qVwzLrkLVLBwKC9VITXxdUhyzjEKSEdXtBaN+wjXcin8+NZR
        ZWAtpfvepSepicVOGA1e6cB/5Q==
X-Google-Smtp-Source: ABdhPJzXjp4t0VYZDcxs8EgiRNA3NNcLIBvlG1vx4qSFeJE7/hcfhQWWEW1MZsL8kp78i2ZnVAv7KA==
X-Received: by 2002:aca:b354:: with SMTP id c81mr2914448oif.41.1602262665045;
        Fri, 09 Oct 2020 09:57:45 -0700 (PDT)
Received: from arch-xps.localdomain ([72.52.67.8])
        by smtp.gmail.com with ESMTPSA id r33sm8001898ooi.48.2020.10.09.09.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:57:44 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:57:42 -0600
From:   Brigham Campbell <me@brighamcampbell.com>
To:     robh+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alchark@gmail.com
Subject: [PATCH] ARM: dts: Add empty "chosen" node to WM8xxx device trees
Message-ID: <20201009165742.GA35334@arch-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is a bug fix for an issue introduced by commit
abe60a3a7afb4058278864aa18c5faf62094c11a which removed the deprecated
device tree skeletons.

For the devices corresponding to these device trees, an updated version
of U-Boot is not available. Therefore, we must append DTBs to the kernel
instead of counting on the bootloader to load one into memory and pass
the pointer to the kernel during init.

For some reason, when this method of appending DTBs to the kernel is
used with any revision after abe60a3a7, the DTB seems to load correctly,
but the kernel parameters aren't loaded correctly. Regardless of whether
the kernel parameters are built into the kernel or passed in via U-Boot,
they simply aren't registered by the running kernel.

Adding an empty "chosen" node to the device tree fixes this issue. I've
tested this with a WM8650-based laptop. Regrettably, I'd be lying if I
said that I know exactly why this fixes the problem. However, I know
that this solution works. I'm happy to hear suggestions/ridicule
regarding these changes.

Finally, I have my suspicions that the WM8xxx series devices aren't the
only ones affected by this issue. I think this solution, if acceptable,
could be applied to other devices which may or may not be having issues
related to appended DTBs and kernel parameters. Perhaps other devices
which commit abe60a3a7 changed?

This is my first patch submission to the Linux kernel, so please tear it
apart. Let me know what I've done incorrectly. And thanks, Alexey, for
helping me along. I have much to learn and I wouldn't have made it half
as far without his patience.

Thanks,
Brigham Campbell

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>

---
 arch/arm/boot/dts/wm8505.dtsi | 2 ++
 arch/arm/boot/dts/wm8650.dtsi | 2 ++
 arch/arm/boot/dts/wm8850.dtsi | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index 168cd12b07bc..2b814b48b458 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -10,6 +10,8 @@ / {
 	#size-cells = <1>;
 	compatible = "wm,wm8505";
 
+	chosen {};
+
 	cpus {
 		#address-cells = <0>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index bc057b6f7d16..a68c82c8035e 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -10,6 +10,8 @@ / {
 	#size-cells = <1>;
 	compatible = "wm,wm8650";
 
+	chosen {};
+
 	cpus {
 		#address-cells = <0>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index 65c9271050e6..c864883ae777 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -10,6 +10,8 @@ / {
 	#size-cells = <1>;
 	compatible = "wm,wm8850";
 
+	chosen {};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.28.0

