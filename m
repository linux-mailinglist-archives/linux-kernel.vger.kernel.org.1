Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062CB290634
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407674AbgJPNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394611AbgJPNW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:22:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A05C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:22:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id e6so1340401pld.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=YEanuN8sObryFQCW5AeGRJqhNtr6AqJyoyNt3MXkCtQ=;
        b=Lb0gXw0QDfcZawEb9d4CS03gSg5l+NVqm/offdQFobtd/XQmc8GeOX/5aRCnTa0V7m
         nOUJeNhMC5nf7hIhwkDn8whq1zLzvnGaT63dVGk0lLZhHB4xtyk22Hdqx8oxzHFMZpPm
         AeQvDTMeIARJXCXYqvm0JcdlwR2z0vYpYnMTVplE43i2b2WVZLgDr3suIlTFtzGvKOaN
         V12vVzsCFWZfgWsiXOkPGnxdoRRAaTc3Nd2D83WyBOfRGuEmbvngr7gO42sLzcD3980i
         bnueUr5UJRm6kT9vNxv85UTSHBLPUYW3RSsaQpYJcH05KAvi+jo7n2vjJVrXi4MQStEk
         vflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=YEanuN8sObryFQCW5AeGRJqhNtr6AqJyoyNt3MXkCtQ=;
        b=Ly/mOzEQ5Xgrf2B49kSM2dORST2pRV6+VLUbEIc1OWReu4wWXqcU5QlJJXrXGMavNW
         bAOW0J7eeDxektdLrbHLRTfXPxFuJXAzpMb6gBYBIuL5xVNF2ywiyEWZadrbL+ijAdaF
         2rwHPLPzV5khzUrZS9S/8vGeP+uhUqlRsgdxS2OzwsSPjK1T7crI41Qx7Pf+zaOZrRBM
         Pxl32RJuaEQs5rzititMxHRV6Uju5E1X96922Bzj+HJfZiNrJmxAdKBu3txjRM+Iw17j
         HnQnQjO0jk6XH6HJwyEN43SHMs3k35cNehQUfrNlQ0T2u2aaqZeJmfaX2MnDUOYUmgU8
         Zpsg==
X-Gm-Message-State: AOAM531M+6jvc0BAeSN1llzUilL/i5KJ81T3uGVi06N1lJZFjc00l29I
        f+pQUcZf9PBsK2lNRmhBdzq0bnO6qeL5dE2G
X-Google-Smtp-Source: ABdhPJxMAFpmDwvWzRB8k+Eouj+/UWaZkKvju8/sAQz6PIiX/QjQMHqg62BhG+UIye5lHBAbjB7ZR/CqP13OW1hZ
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a62:4e05:0:b029:156:6a80:2686 with SMTP
 id c5-20020a624e050000b02901566a802686mr3525957pfb.61.1602854545149; Fri, 16
 Oct 2020 06:22:25 -0700 (PDT)
Message-ID: <000000000000cafee605b1c9a745@google.com>
Date:   Fri, 16 Oct 2020 13:22:25 +0000
Subject: [PATCH] power: suspend: Add suspend timeout handler
From:   <josephjang@google.com>
To:     rafael@kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Rafael's promptly response.

> On Fri, Oct 16, 2020 at 5:51 AM Joseph Jang <josephjang@google.com> wrote:
> >
> > From: josephjang <josephjang@google.com>
> >
> > Add suspend timeout handler to prevent device stuck during suspend/
> > resume process. Suspend timeout handler will dump disk sleep task
> > at first round timeout and trigger kernel panic at second round timeout.
> > The default timer for each round is 30 seconds.
> >
> > Note: Can use following command to simulate suspend hang for testing.
> >     adb shell echo 1 > /sys/power/pm_hang
> >     adb shell echo mem > /sys/power/state
> > Signed-off-by: josephjang <josephjang@google.com>
> > ---
> >  include/linux/console.h |   1 +
> >  kernel/power/Kconfig    |   9 +++
> >  kernel/power/main.c     |  66 ++++++++++++++++
> >  kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
> >  kernel/printk/printk.c  |   5 ++
> >  5 files changed, 243 insertions(+)
> >
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index 0670d3491e0e..ac468c602c0b 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
> >  { }
> >  #endif
> >  extern bool console_suspend_enabled;
> > +extern int is_console_suspended(void);
> >
> >  /* Suspend and resume console messages over PM events */
> >  extern void suspend_console(void);
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index a7320f07689d..52b7a181b6d8 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
> >         def_bool y
> >         depends on PM_DEBUG && PM_SLEEP
> >
> > +config PM_SLEEP_MONITOR
> > +       bool "Linux kernel suspend/resume process monitor"
> > +       depends on PM_SLEEP
> > +       help
> > +       This option will enable suspend/resume monitor to prevent device
> > +       stuck during suspend/resume process. Suspend timeout handler  
> will
> > +       dump disk sleep task at first round timeout and trigger kernel  
> panic
> > +       at second round timeout. The default timer for each round is 30  
> seconds.
> > +

> The facility associated with the Kconfig entry right below is supposed
> to do exactly the same thing.

> What's the reason to add another one?  What is missing?



> >  config DPM_WATCHDOG
> >         bool "Device suspend/resume watchdog"
> >         depends on PM_DEBUG && PSTORE && EXPERT

Because we found some suspend hand issue that cannot be detected by
"CONFIG_DPM_WATCHDOG" (which is focus on device PM).
Our suspend timeout monitor can cover PM core and Device PM hang issues.

Thank you,
Joseph.
