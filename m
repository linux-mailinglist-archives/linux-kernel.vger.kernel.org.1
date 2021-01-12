Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8532F2588
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbhALBbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbhALBav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:30:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75E3322E01;
        Tue, 12 Jan 2021 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610415010;
        bh=0HcB3+On02y9RbOFtZA64sarS9kNDOtXbHjPRCJPzK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cH5Ou5JEjXsLEP4W1y2EhTIoVbkYyR3WI8o24zmVYv90pYXU2mFG0zQ1acJpUklYB
         Uigq+6RcP29J+HpN+k01tv42R3DKVr4GccT5S+c0yHVzjAsPEf8355mMY6yPXNvIRd
         z1RSKEfoSP50tXYkLC3yDuJx8cYGKBhlp//OHq2c=
Date:   Mon, 11 Jan 2021 17:30:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Timur Tabi <timur@tabi.org>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Roman Fietze <roman.fietze@magna.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] lib/hexdump: introduce DUMP_PREFIX_UNHASHED for
 unhashed addresses
Message-Id: <20210111173009.fe2383539e5ca2c23b135262@linux-foundation.org>
In-Reply-To: <X/wkMMiPPBAJb9+A@alley>
References: <20210106213547.1077789-1-timur@tabi.org>
        <X/wkMMiPPBAJb9+A@alley>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 11:10:56 +0100 Petr Mladek <pmladek@suse.com> wrote:

> Adding Kees into CC because it is security related.
> Adding Andrew into CC because he usually takes patches for hexdump.
> 
> On Wed 2021-01-06 15:35:47, Timur Tabi wrote:
> > Hashed addresses are useless in hexdumps unless you're comparing
> > with other hashed addresses, which is unlikely.  However, there's
> > no need to break existing code, so introduce a new prefix type
> > that prints unhashed addresses.
> > 
> > Signed-off-by: Timur Tabi <timur@tabi.org>
> > Cc: Roman Fietze <roman.fietze@magna.com>
> 
> I agree that there should be way to print the real address.
> 
> And it is sane to add a new mode so that the current
> users stay hashed.
> 

I doubt if Kees (or I or anyone else) can review this change because
there are no callers which actually use the new DUMP_PREFIX_UNHASHED. 
Is it intended that some other places in the kernel be changed to use
this?  If so, please describe where and why, so that others can better
understand both the requirement and the security implications.

If it is intended that this be used mainly for developer debug and not
to be shipped in the mainline kernel then let's get this info into the
changelog as well.

