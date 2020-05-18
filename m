Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EB71D773F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 13:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgERLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 07:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgERLfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:35:25 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82724206D4;
        Mon, 18 May 2020 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589801724;
        bh=kIOjQClZFCknpL+ktt4kcO2VZmVtnmBE/zjeAxsdKIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGkeY+bYTNbcRrGFooii/MMllRd+TSAyPQ7Hq4G+y8xqNAs3sJFfoAeUOCjDZ10IO
         W/dKF/zFbiOI3lkIs6/mkmmF2mlTEctqKbUkIpNIK9Xa9dQZnmeiwG0IvryuQ7zgKp
         4KCO8Gja6cG1/Uj19FTPxeP9rywlEPudXRJldGlg=
Received: by pali.im (Postfix)
        id 7AAE389D; Mon, 18 May 2020 13:35:22 +0200 (CEST)
Date:   Mon, 18 May 2020 13:35:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Missing CLOCK_BOOTTIME_RAW?
Message-ID: <20200518113522.y6sj7ypunsu6pi3s@pali>
References: <20200508213122.f7srcd2gnduamtvs@pali>
 <87zhah4evs.fsf@nanos.tec.linutronix.de>
 <20200518111103.sj73h5j3r75zv2wp@pali>
 <87ftbxxz55.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftbxxz55.fsf@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 May 2020 13:26:14 Thomas Gleixner wrote:
> Pali Rohár <pali@kernel.org> writes:
> > On Saturday 09 May 2020 11:49:27 Thomas Gleixner wrote:
> >> Sure, but what's the problem? The adjustemt is done to make the observed
> >> time as correct as possible.
> >
> > Yes. But correction may take lot of time, e.g. also more then one day.
> >
> > So during this period when correction is in progress, measuring time
> > difference via CLOCK_MONITONIC will have incorrect results.
> >
> > It already happened for me, system clock was shifted by one hour and
> > chronyd started adjustment, it slow down system clock. 6 real hours
> > passed and via system clock was measured time difference only about
> > 5 hours and 20 minutes (correction was still in progress as system
> > clock at that time was still shifted by about 20 minutes).
> 
> System clock shifted by one hour? You mean DST change?

Yes, clock was shifted by one hour.

> If chronyd
> adjusts that by smoothing the frequency, that's just broken and really
> not the kernel's problem.

And what other can time synchronization daemon does?

Well, I think this is not related to chronyd. Any userspace application
may call adjtime(). It is not privilege that only chronyd is allowed to
use that syscall.

I agree that this is not a kernel problem.

But I'm asking, how my userspace application can measure time difference?
As I wrote CLOCK_MONITONIC is not suitable as it is affected by those
NTP adjustments and that is why I thought that CLOCK_MONITONIC_RAW is
better as it is not affected by these NTP problems.

But CLOCK_MONITONIC_RAW has a problem that is stopped during system
sleep and that is why I thought that CLOCK_BOOTTIME_RAW should be there.

> Thanks,
> 
>         tglx
