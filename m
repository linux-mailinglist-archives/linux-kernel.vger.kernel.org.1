Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0B2A0738
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgJ3N5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:57:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3N5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:57:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 95BF6ACAE;
        Fri, 30 Oct 2020 13:57:39 +0000 (UTC)
Date:   Fri, 30 Oct 2020 14:58:16 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
Message-ID: <20201030135816.GA1790@yuki.lan>
References: <20201030110229.43f0773b@jawa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030110229.43f0773b@jawa>
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

And what's exactly wrong with moving the system time forward for a
duration of the test?

-- 
Cyril Hrubis
chrubis@suse.cz
