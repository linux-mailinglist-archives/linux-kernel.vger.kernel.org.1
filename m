Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA042B1CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgKMOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:00:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:48610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgKMOAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:00:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605276053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/TdnsAdV/j/89FaiEbPT2gcFjd8vcguwgiF9H1YUHU=;
        b=KHNOs8d1fWbd5CerzMR/ws8nyckPDeito4u9JLk4snxbD3JIfiJvNUVyvIp8LZvW8jsEXU
        dJ/e3H1wcH105ChK6+1KxL2yOAqHZTCvpsgyykomk6T9bEMhnEZCbZtaoU4DJJehnfKl4O
        Ek6t2dp32eCyaYqsenNgVfhA6IntP64=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCF57AC91;
        Fri, 13 Nov 2020 14:00:52 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:00:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf number
 parsing
Message-ID: <20201113140052.GM1602@alley>
References: <20201112111759.16377-1-rf@opensource.cirrus.com>
 <20201112103546.5981815b@gandalf.local.home>
 <b200a554-be81-f8b0-28a4-39c6f3c6900f@opensource.cirrus.com>
 <20201112120427.72c0a237@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112120427.72c0a237@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-11-12 12:04:27, Steven Rostedt wrote:
> On Thu, 12 Nov 2020 15:46:46 +0000
> Richard Fitzgerald <rf@opensource.cirrus.com> wrote:
> 
> > See this thread from 2014 where the field width problem was raised and
> > explained:
> > http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03443.html
> > 
> > and the reply from Linus Torvalds that was against fixing field width
> > handling:
> > http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03488.html
> 
> Thanks for the pointers, but note, that references to older emails should
> use https://lore.kernel.org/ as these links format the output really
> horribly.
> 
> > 
> > which I assume is why the field handling wasn't unoptimized to be
> > strictly correct.

Honestly, the handling of the number width by div does not look like
a real optimization to me. It avoids the need of the temporary buffer
by expensive and error-prone operation.

IMHO, it is safe to assume that the width will be limited so that
the value would never overflow.

The longest supported number would be (2^64 - 1) in octal. If I am
counting correctly, it is

     01777777777777777777777

and it fits into buf[24] including the trailing '\0'.

We could call WARN_ON_ONCE() when the width >= 24 is higher.
And we could add a compiler check when long long is bigger
than 64-bit.

> Yes, but perhaps its time to fix the real problem and not just add
> band-aids. That thread is over 6 years old (the email was from Jan 14, 2014)
>
> $ git diff `git rev-list --before 'Jan 14 2014' HEAD --max-count=1` |
>   grep '^+' | grep sscanf | wc -l
> 622
> 
> There's been over 600 new additions of sscanf(). Now is the time to just
> fix it correctly.

And the following one might suffer from this problem:

drivers/soundwire/slave.c:              ret = sscanf(compat, "sdw%01x%04hx%04hx%02hhx", &sdw_version,

I agree with Steven that it is time to fix it properly.

Best Regards,
Petr
