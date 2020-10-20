Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD529375B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392248AbgJTJBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392186AbgJTJBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:01:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BAC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:01:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id n85so762815pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:mime-version:message-id:date:subject:from:to:cc;
        bh=ffn1pbtm3m7DN0PZ3f/dZzoHyymXTXLDl2Uw/FDlJWQ=;
        b=oZAsNybuwPff5bSX5pkPKTtloKOC4RXtfp9B3S2sC/HLdYQcuSC6UgdvHfbEWP6tTE
         rIOC22FlFItBO98d9tGSNKBLjzCpzbvkhumX5RM80/G8RBCLFwrJ6YVT3nbnCoWenUux
         6PxEZsE91hWuiZj7buli7QKbYYjI0b8advzL03TdUosjpUKAjbEvSuHpxZ6RSmYC+lbj
         M8TdiYG9qft4HJcrJOqgoYDVekl9WnYQmmkWT/KElKvKWDvhWi4cuZoP1KlWSgYXP8QE
         eua2/9sAlFkub5HKMZiPuI8H2UwGuELeB1/X06xi+Iz97Ha2Cx4IlP1EVLp6pG3vbMcl
         rQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:mime-version:message-id:date:subject:from
         :to:cc;
        bh=ffn1pbtm3m7DN0PZ3f/dZzoHyymXTXLDl2Uw/FDlJWQ=;
        b=XFol2upLaqrE8ds6Ke3QRRHUP+zosbFEbprs/t42rfnpPIeHN91LD2oWEu4V/Qc6Fl
         OP/jSZ7Zt9dlJF7EXbcFgMYbz/BEPLHlQdK9MXqSmRmepEoNr2dU42Q2zLgztzQjiQkq
         9MFvAe59Pi8EuMitsmxh5nOSl8jrj3BVLCySq8MCK3xkJVKw9jO136eFZCN3KK9kVOMG
         0+ju1I4ac+04Gnbue/f4e8hXEsO53Bl8zwRuteJwOiOWCbSt14qQF5dWKInJl2tK6Qr3
         VRzJqhPoXb+RJOWoHuK9p+Ojead6CCvY6QvEnJYEEM9CymSwnRVd0Xcirzs/T+addneA
         cMOg==
X-Gm-Message-State: AOAM533UmMULzRKJyVdv4io0Xy7jgvZC2idDaOsjW4B0BgckLsSZ8xlV
        qHbyzNRPrNnqVKDSBoARbKc6mQ96/r714SuP
X-Google-Smtp-Source: ABdhPJyVShypXQ1cA//oLJFxqKfsTw/7rRaogmZo1fJGh5VMzkY/z0BwL/pu5z0kgdk0h0uGaSv8lD+s1sQ+eJmk
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
MIME-Version: 1.0
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with
 SMTP id d10-20020a170902aa8ab02900d3c9dd77d1mr2057978plr.0.1603184465071;
 Tue, 20 Oct 2020 02:01:05 -0700 (PDT)
Message-ID: <0000000000008d35ba05b216782a@google.com>
Date:   Tue, 20 Oct 2020 09:01:05 +0000
Subject: [PATCH] power: suspend: Add suspend timeout handler
From:   <josephjang@google.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Oct 20, 2020 at 08:15:38AM +0000, josephjang@google.com wrote:
> > > On Tue, Oct 20, 2020 at 02:22:26PM +0800, Joseph Jang wrote:
> > > > Add sleep timer and timeout handler to prevent device stuck during
> > > suspend/
> > > > resume process. The timeout handler will dump disk sleep task at  
> first
> > > > round timeout and trigger kernel panic at second round timeout.
> > > > The default timer for each round is defined in
> > > > CONFIG_PM_SLEEP_TIMER_TIMEOUT.
> > > >
> > > > Signed-off-by: Joseph Jang <josephjang@google.com>
> > > > ---
> > > >  MAINTAINERS                   |  2 +
> > > >  include/linux/console.h       |  1 +
> > > >  include/linux/suspend_timer.h | 90  
> +++++++++++++++++++++++++++++++++++
> >
> > > Why is this file in include/linux/ if you only ever call it from  
> one .c
> > > file?
> >
> > I just refer to include/linux/suspend.h and create a new header file in  
> the
> > same folder.
> > If you have a better location for the new header file, please feel free  
> to
> > let me know.

> Only put .h files that are needed by different .c files in the
> include/linux/ directory.  Otherwise it should be local to where the .c
> file is.
> Great, use that!

> > But we really hit the suspend hang issue that DPM_WATCHDOG cannot cover.

> What issue is that?

> > We propose a wide coverage debug feature like PM_SLEEP_MONITOR which
> > not only covers PM but also core PM hang issues.
> >
> > And DPM_WATCHDOG is for device driver power management in
> > drivers/base/power/main.c
> > and PM_SLEEP_MONITOR locate is for core power management in
> > kernel/power/suspend.c.
> > I think it is fine for users to select whether they need device PM only  
> or
> > not.

> How will a user know which they should use?

> Why not just fix whatever is wrong with the watchdog code instead of
> creating a new one?

> > > And why isn't the watchdog sufficient for you?  Why are you "open
> > > coding" a watchdog timer logic here at all???
> >
> > Yes, we refer to DPM_WATCHDOG to extend the watchdog debugging for core  
> PM.
> > Because we really hit a real case that was not covered by DPM_WATCHDOG.

> Then fix that!

> > I think PM_SLEEP_MONITOR is an extension debug feature from  
> DPM_WATCHDOG.

> Please just fix the watchdog, as obviously it is not working properly.
> Don't create something new because of that.

> thanks,

> greg k-h

Thank you Greq for promptly responding.
I am okay to fix the DPM_WATCHDOG feature, but would like to have quick  
sync up before start.
Could you help?


1. Can we change the kernel config name ?
DPM_WATCHDOG stands for Device Power Management.
We propose PM_SLEEP_MONITOR is to cover Core PM and Device PM.


2. Can we create a new data structure instead of using the following struct  
dpm_watchdog?
struct dpm_watchdog {
	struct device		*dev;
	struct task_struct	*tsk;
	struct timer_list	timer;
};

I list some reasons by following ...

static int device_resume(struct device *dev, pm_message_t state, bool async)
{
	pm_callback_t callback = NULL;
	const char *info = NULL;
	int error = 0;
	DECLARE_DPM_WATCHDOG_ON_STACK(wd);  <== dpm_watchdog use stack memory for  
watchdog timer struct, but sleep timer use global memory.

...<SNIP>

	if (!dpm_wait_for_superior(dev, async))
		goto Complete;

	dpm_watchdog_set(&wd, dev);  <== dpm_watchdog need "struct device", but  
sleep timer doesn't need it.
	device_lock(dev);

...<SNIP>

  Unlock:
	device_unlock(dev);
	dpm_watchdog_clear(&wd);

  Complete:
	complete_all(&dev->power.completion);

	TRACE_RESUME(error);

	return error;
}

Thank you,
Joseph.
