Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A852E82ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 05:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbhAAEwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 23:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbhAAEwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 23:52:05 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CABC061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 20:51:25 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o144so18934120ybc.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 20:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L2rVtcmoGrZ4NbWvrQJ+nndibDPCXZonIPv9txz8Yv0=;
        b=cowz5qlfEgtrs1ornDHD1Cdex3q00uwP6brPrOR99InKPH3Ffi752KZaqADWXvhoMP
         GRv7nFvgGdy6LxddKL6u5lyTSgKIct+OK/th5uRfBCZCHPzwp9Ik1tzvSqyz2/VWsuau
         owU3NuMqPJ8aqdlMcehDMkYsvJumKjYh7YYz3LiHu4XuYeT1NCj/YkUDBfyc4cVY3y7O
         rmo0s5igM7NlNl8A5EpXrHFEVXEaaHcykRHLQGIVDXvgEg9HMfVlVtcEWsLisWY7fYqS
         UaiEd723Nb2xDBMtT8fzulHLZJYc9DEvVOg2KOMba/hFRyF95gaqgajRYPF9G//EhxcR
         C62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L2rVtcmoGrZ4NbWvrQJ+nndibDPCXZonIPv9txz8Yv0=;
        b=MfvnuKQ8mjXr5ltqn7RKEfIQMlnHHkFNwSVLOOOB89+kzFnl/p6Iay40gSOoEbx3up
         kDv7WigmWvcZcd29GdfFtBkuSYunw05dPblS2vz+RCBo65M1IUgLsE/f8XrJqQ5+br+S
         gHxR775MrZiAuLb5Nuu+4EWUfRt2/eETgAp23of0RvsqwUhEOiVebQOgSBYos793MQSs
         HIzlmCC+cuQOROq5Wj2DcpUlNr5P+w6TWlDkXdcLDnENImylbmloYIFKCNUxVpnBQDfP
         Oqae7NvynNW0o1XFXDZovZiybqKAYabFLJklXBDr/JizrMYZSUXwmeuV6L3FU998qjT+
         B1HA==
X-Gm-Message-State: AOAM5312I/6cEMq2xluVlwOgAC/hN0M1XV/EDWeML5jQgM8YVaYpIaaQ
        oZgNaDhs4ToKA8uSyE2BD7gX4xM3KbKh4F/1R3CU4Su18PqP3wR6
X-Google-Smtp-Source: ABdhPJxVRmhv9wUyM/EghsM9c4ktYhQeZdnNZ44YiT5MzxCaq091Ct/5v4gTCI6Mjy9ocEjV0ey0WAx2EF/8WkMOiq0=
X-Received: by 2002:a25:cf13:: with SMTP id f19mr41478354ybg.373.1609476684918;
 Thu, 31 Dec 2020 20:51:24 -0800 (PST)
MIME-Version: 1.0
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Fri, 1 Jan 2021 12:51:13 +0800
Message-ID: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
Subject: Generate the config file for kernel compilation non-interactively in script.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to build the realtime Linux for ROS 2 according to the
guidelines here:
<https://index.ros.org/doc/ros2/Tutorials/Building-Realtime-rt_preempt-kernel-for-ROS-2/>.

For this purpose, I must enable the rt_preempt relative options in the
kernel withe the following method interactively:

$ make menuconfig

and set the following

# Enable CONFIG_PREEMPT_RT
 -> General Setup
  -> Preemption Model (Fully Preemptible Kernel (Real-Time))
   (X) Fully Preemptible Kernel (Real-Time)

# Enable CONFIG_HIGH_RES_TIMERS
 -> General setup
  -> Timers subsystem
   [*] High Resolution Timer Support

# Enable CONFIG_NO_HZ_FULL
 -> General setup
  -> Timers subsystem
   -> Timer tick handling (Full dynticks system (tickless))
    (X) Full dynticks system (tickless)

# Set CONFIG_HZ_1000 (note: this is no longer in the General Setup
menu, go back twice)
 -> Processor type and features
  -> Timer frequency (1000 HZ)
   (X) 1000 HZ

# Set CPU_FREQ_DEFAULT_GOV_PERFORMANCE [=y]
 ->  Power management and ACPI options
  -> CPU Frequency scaling
   -> CPU Frequency scaling (CPU_FREQ [=y])
    -> Default CPUFreq governor (<choice> [=y])
     (X) performance

But this is very inconvenient for doing the above job in script. Is
there an alternative method to generate the above configurations for
kernel compilation  non-interactively in script.

BR,
-- 
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
