Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312882B0879
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKLPfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgKLPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:35:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 916672224B;
        Thu, 12 Nov 2020 15:35:48 +0000 (UTC)
Date:   Thu, 12 Nov 2020 10:35:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf
 number parsing
Message-ID: <20201112103546.5981815b@gandalf.local.home>
In-Reply-To: <20201112111759.16377-1-rf@opensource.cirrus.com>
References: <20201112111759.16377-1-rf@opensource.cirrus.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 11:17:59 +0000
Richard Fitzgerald <rf@opensource.cirrus.com> wrote:

> Number conversion in vsscanf converts a whole string of digits and then
> extracts the field width part from the converted value. The maximum run
> of digits is limited by overflow. Conversion was using either
> simple_strto[u]l or simple_strto[u]ll based on the 'L' qualifier. This
> created a difference in truncation between builds where long is 32-bit
> and builds where it is 64-bit. This especially affects parsing a run of
> contiguous digits into separate fields - the maximum length of the run
> is 16 digits if long is 64-bit but only 8 digits if long is 32-bits.
> For example a conversion "%6x%6x" would convert both fields correctly if
> long is 64-bit but not if long is 32-bit.
> 
> It is undesirable for vsscanf to parse numbers differently depending on
> the size of long on the target build.
> 
> As simple_strto[u]l just calls simple_strto[u]ll anyway the conversion
> is always 64-bit, and the result is manipulated as a u64, so this is an
> avoidable behaviour difference between 32-bit and 64-bit builds. The
> conversion can call simple_strto[u]ll directly and preserve the full
> 64-bits that were parsed out of the string.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  lib/vsprintf.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 14c9a6af1b23..63b6cddfa7f7 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -3444,13 +3444,9 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
>  			break;
>  
>  		if (is_sign)
> -			val.s = qualifier != 'L' ?
> -				simple_strtol(str, &next, base) :
> -				simple_strtoll(str, &next, base);
> +			val.s = simple_strtoll(str, &next, base);
>  		else
> -			val.u = qualifier != 'L' ?
> -				simple_strtoul(str, &next, base) :
> -				simple_strtoull(str, &next, base);
> +			val.u = simple_strtoull(str, &next, base);
>  
>  		if (field_width > 0 && next - str > field_width) {
>  			if (base == 0)

It looks like this is fixing the symptom and not the disease. The real
issue I see here is that vsscanf is not honoring the '6' of '%6x' here. It
should only read the 6 characters then do the conversion, not the other
way around! This looks to me that the design is of issue.

-- Steve
