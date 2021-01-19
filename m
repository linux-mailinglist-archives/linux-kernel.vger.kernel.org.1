Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821002FBC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbhASQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:22:06 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49175 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbhASQUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:20:36 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10JGJ1ek014691;
        Tue, 19 Jan 2021 17:19:01 +0100
Date:   Tue, 19 Jan 2021 17:19:01 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        mark.rutland@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210119161901.GA14667@1wt.eu>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119153147.GA5083@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jan 19, 2021 at 07:31:47AM -0800, Paul E. McKenney wrote:
> Hello, Willy,
> 
> Some people are having trouble running rcutorture on ARMv8.  They
> get things like this from the nolibc build of initrd:
> 
> https://paste.debian.net/1181762/
> 
> The nolibc.h file says this:
> 
> /* Some archs (at least aarch64) don't expose the regular syscalls anymore by
>  * default, either because they have an "_at" replacement, or because there are
>  * more modern alternatives. For now we'd rather still use them.
>  */
> 
> Are these build failures expected behavior on ARMv8?

No, I don't think so. I'm regularly building my own init using this,
and it works on various platforms including aarch64, while it makes
use of a number of such syscalls.

From what I'm seeing, this seems to happen each time in such a construct:

    #if defined(__NR_new_name)
         use __NR_new_name
    #else
         use __NR_old_name
    #endif

with the error appearing on old_name. So I guess that we're rather facing a
case where a number of such __NR_* entries are not defined because presumably
one include file might be missing (probably from a recent change of headers
dependency).

I can't spot from the report above the original C file that was attempted
to be built, it makes me think we tried to compile directly the .h file.

Having it run through sh -x would help me try to locate the root cause or
possibly even attempt to reproduce it.

Thanks,
Willy
