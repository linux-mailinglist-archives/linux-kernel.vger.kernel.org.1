Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4177A2C42BB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgKYPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKYPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:16:55 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D372067D;
        Wed, 25 Nov 2020 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606317415;
        bh=e5Rg50mdGS8vRR71KOvlAAl87g5IRjpO1Yue6LXVtDw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W1RHox4BLbE2z+bhg19liyhhmCPKFqhsEbFzmge7mOr7CaH77x1p/LO5SdGTCbi9R
         KaXxFXcGY64Pe2ihnmTEy7PpCiR2g9ZZ7OUM0Q9p+1AqDF0IWH7GNJ274Y9xxaMz1r
         GeTzieMezgpnqBDifKvxwtPpNyonEbacWXAFId9U=
Message-ID: <a85c494dafad10ad03da0c8db41cb320491d71d5.camel@kernel.org>
Subject: Re: [FEATURE REQUEST] tracing: Have event filters handle dynamic
 arrays
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Daniel Wagner <wagi@monom.org>
Date:   Wed, 25 Nov 2020 09:16:52 -0600
In-Reply-To: <20201124113734.34d86db1@gandalf.local.home>
References: <20201124113734.34d86db1@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, Daniel,

On Tue, 2020-11-24 at 11:37 -0500, Steven Rostedt wrote:
> Hi Tom,
> 
> Daniel asked about filtering bitmasks, something like:
> 
>    cpumask != 0xff
> 
> Looking into the code, I realized that bitmasks are dynamic arrays,
> and
> there's no logic in the filter code to handle dynamic arrays of
> anything
> other than 'char' type (which are dynamic strings).
> 
> If you have any cycles to spare, do you think you can add code to
> process
> dynamic arrays other than char?
> 
> The compare logic may be complex though. I think the above example
> should
> work, but we would need to define how that happens.
> 
> I guess we should follow the cpumask logic, and break all non string
> dynamic arrays up into 32 bit words. Even if something is defined as
> u8, it
> will be converted to the local endian of the machine. Basically, we
> should
> follow the function bitmap_string() defined in lib/vsnprintf.c
> 
> If we have a u8 dynamic array of:
> 
>  0x12 0x34 0x56 0x78 0x9a 0xbc 0xde 0xf0
> 
> On a little endian machine it would match:
> 
>   0xf0debca9,0x78563412
> 
> This way, if we have a machine with 64 CPUS, and we want to match
> cpus 0-7,
> then we only need to do:
> 
>   cpumask & 0xff
> 
> The above would be equivalent to:
> 
>  cpumask & 0,0xff
> 
> in such a case.
> 
> That's because, if I'm reading the code correctly, a cpumask for CPUs
> 0-7
> bits set for 64 CPU machine in raw format would be:
> 
>  0x00 0x00 0x00 0xff 0x00 0x00 0x00 0x00
> 
> The dynamic arrays will allow comma separated 4 byte words to match.
> 
> Daniel brought this up, and he said he'd be willing to help out
> making a
> patch if he has spare cycles to spare. Perhaps, between the two of
> you, you
> could come up with the cycles to produce such a patch :-)
> 

Sure, I can take a look - luckily holidays are coming up so should be
able to find some time for this.

Tom

> Cheers,
> 
> -- Steve

