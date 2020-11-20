Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A64A2BAFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgKTQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgKTQQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:16:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32447223BE;
        Fri, 20 Nov 2020 16:16:48 +0000 (UTC)
Date:   Fri, 20 Nov 2020 11:16:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Petr Mladek <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] lib: vsprintf: Fix handling of number field widths in
 vsscanf
Message-ID: <20201120111646.0daee5a4@gandalf.local.home>
In-Reply-To: <59d43108-814e-4bf1-73f9-4994291abc05@opensource.cirrus.com>
References: <20201116143252.19983-1-rf@opensource.cirrus.com>
        <X7ei9cENZ0dVkGZh@alley>
        <20201120100705.3a7fb747@gandalf.local.home>
        <59d43108-814e-4bf1-73f9-4994291abc05@opensource.cirrus.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 16:04:15 +0000
Richard Fitzgerald <rf@opensource.cirrus.com> wrote:

> > But yeah, we could very much have cp - startp > max_chars.
> >   
> 
> My code handles the prefix overflow, but I did it by having
> __parse_integer_limit() simply give 0 if max_chars <= 0.

Yeah, but if that's the intended result, then it needs to be commented as
such, and the comment needs to be fixed. Right now it's:

/*
 * Convert non-negative integer string representation in explicitly given radix
 * to an integer. The maximum number of characters to convert can be given.
 * A character limit of INT_MAX is effectively unlimited since a string that
 * long is unreasonable.
 * Return number of characters consumed maybe or-ed with overflow bit.
 * If overflow occurs, result integer (incorrect) is still returned.
 *
 * Don't you dare use this function.
 */

That comment needs to include: "If max_chars <= 0, then this returns zero.".

-- Steve


> 
> So if the field width isn't enough for the prefix/leading '-' and at
> least one digit, subtracting the prefix length from the field length
> will give a max_chars <= 0. And you'll get a result of 0 as in your
> '%2li%9lx' test case.
> 
> I thought this was nice because it didn't need to add code to check
> for the prefix overflow - it comes inherently from the loop in
> __parse_integer_limit(). But I'm willing to change
> __parse_integer_limit() to take an unsigned and add explicit checks for
> the prefix/'-' overflow cases.
