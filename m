Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA91B9FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgD0Jas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbgD0Jap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:30:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4C7C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:30:45 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT066-0007bt-7C; Mon, 27 Apr 2020 11:30:42 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3838B100606; Mon, 27 Apr 2020 11:30:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Leonid Bloch <lb.workbox@gmail.com>, linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Leonid Bloch <lb.workbox@gmail.com>
Subject: Re: [PATCH] rtc: Do not sync CMOS clock when CONFIG_RTC_SYSTOHC is not set
In-Reply-To: <20200426013521.43087-1-lb.workbox@gmail.com>
References: <20200426013521.43087-1-lb.workbox@gmail.com>
Date:   Mon, 27 Apr 2020 11:30:41 +0200
Message-ID: <875zdls2bi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonid Bloch <lb.workbox@gmail.com> writes:
> According to documentation in 'drivers/rtc/Kconfig', if
> 'CONFIG_RTC_SYSTOHC' is set, then:
>
> '''
> The system time (wall clock) will be stored in the RTC specified by
> RTC_HCTOSYS_DEVICE approximately every 11 minutes if userspace reports
> synchronized NTP status.
> '''
>
> However in reality, even if 'CONFIG_RTC_SYSTOHC' is not set, the RTC
> is still sometimes synced with the system time: at least when the RTC
> driver is 'rtc_cmos', in certain situations. This commit prevents
> that.

But in reality sync_cmos_clock() depends on CONFIG_GENERIC_CMOS_UPDATE
and has nothing to do with CONFIG_RTC_SYSTOHC.

That's a historical leftover from the days where RTCs were strictly a
platform/architecture specific issue.

Your change would break all architectures which still depend on that.

Thanks,

        tglx
