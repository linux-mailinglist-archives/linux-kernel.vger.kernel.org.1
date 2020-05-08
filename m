Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A821CB8E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 22:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgEHUTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 16:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHUTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:19:02 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BCA206D3;
        Fri,  8 May 2020 20:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588969141;
        bh=rtlkxCw6OP75lsWf55o9FNytUMK3linnTNSPigtZ3HI=;
        h=Date:From:To:Subject:From;
        b=AcY0gOYDM85+4XD72AjMoyytiWvIzYmECA1mU4+IFdM2NkTZmBh81nNYiue1gWStf
         UqbtipNy6Nu9fQ87R+29mFlmmUzgjPrU3/u0olxymbuH3ifOydh+NRwsvmbXLlOmgF
         E1YKjtZ5E1YWhO5X7VZ58cC1AzBspxq3w/0HDW7Y=
Received: by pali.im (Postfix)
        id 708A07F5; Fri,  8 May 2020 22:18:59 +0200 (CEST)
Date:   Fri, 8 May 2020 22:18:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Missing CLOCK_BOOTTIME_RAW?
Message-ID: <20200508201859.vlffp4fomw2fr4qc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas!

I'm looking at clocks which are provided by kernel for userspace
applications via clock_gettime() syscall and I think that there is
missing clock variant CLOCK_BOOTTIME_RAW.

If userspace application wants to measure time difference between two
events then I think all of available clocks CLOCK_REALTIME,
CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW and CLOCK_BOOTTIME have some issues
for such task.

CLOCK_REALTIME may be changed but userspace and therefore time
difference between two events may be also negative.

CLOCK_MONOTONIC does not have to precise as there may be incremental
jumps caused by NTP or measured time difference may be smaller as
elapsed when system is suspended. During system suspend is clock
CLOCK_MONOTONIC stopped.

CLOCK_MONOTONIC_RAW is not affected by NTP jumps but still is not
suitable for measuring time differences when system is suspended.

CLOCK_BOOTTIME is affected by NTP jumps but provides correct time
difference when system was suspended during measurement.

So for me it looks like that there is missing CLOCK_BOOTTIME_RAW clock
which would not be affected by NTP jumps (like CLOCK_MONOTONIC_RAW) and
also would not be affected by system suspend (like CLOCK_BOOTTIME).

Please correct me if I'm wrong in some of my above assumptions. It is
how I understood documentation for clock_gettime() function from Linux
manpage.

Is there any reason why kernel does not provide such CLOCK_BOOTTIME_RAW
clock for userspace applications which would be interested in measuring
time difference which occurred between two events?
