Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E241A2B2CB4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 11:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgKNKZH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Nov 2020 05:25:07 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34222 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKNKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 05:25:07 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CF8D51C0BC1; Sat, 14 Nov 2020 11:25:04 +0100 (CET)
Date:   Sat, 14 Nov 2020 11:25:03 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        GNU C Library <libc-alpha@sourceware.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
Message-ID: <20201114102503.GB1000@bug>
References: <20201030110229.43f0773b@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201030110229.43f0773b@jawa>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I do have a question regarding the Linux time namespaces in respect of
> adding support for virtualizing the CLOCK_REALTIME.
> 
> According to patch description [1] and time_namespaces documentation
> [2] the CLOCK_REALTIME is not supported (for now?) to avoid complexity
> and overhead in the kernel.
> 
> Is there any plan to add support for it in a near future?
> 
> Why I'm asking? 
> 
> It looks like this kernel feature (with CLOCK_REALTIME support
> available) would be very helpful for testing Y2038 compliance for e.g.
> glibc 32 bit ports.
> 
> To be more specific - it would be possible to modify time after time_t
> 32 bit overflow (i.e. Y2038 bug) on the process running Y2038
> regression tests on the host system (64 bit one). By using Linux time
> namespaces the system time will not be affected in any way.

If big slowdown is acceptable... you can play games with ptrace. Project called "subterfugue"
should have examples how to do that.

Best regards,
										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
