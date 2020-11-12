Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7492F2B0AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgKLREb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgKLREa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:04:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C1821D7F;
        Thu, 12 Nov 2020 17:04:29 +0000 (UTC)
Date:   Thu, 12 Nov 2020 12:04:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf
 number parsing
Message-ID: <20201112120427.72c0a237@gandalf.local.home>
In-Reply-To: <b200a554-be81-f8b0-28a4-39c6f3c6900f@opensource.cirrus.com>
References: <20201112111759.16377-1-rf@opensource.cirrus.com>
        <20201112103546.5981815b@gandalf.local.home>
        <b200a554-be81-f8b0-28a4-39c6f3c6900f@opensource.cirrus.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 15:46:46 +0000
Richard Fitzgerald <rf@opensource.cirrus.com> wrote:

> See this thread from 2014 where the field width problem was raised and
> explained:
> http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03443.html
> 
> and the reply from Linus Torvalds that was against fixing field width
> handling:
> http://lkml.iu.edu/hypermail/linux/kernel/1401.1/03488.html

Thanks for the pointers, but note, that references to older emails should
use https://lore.kernel.org/ as these links format the output really
horribly.

> 
> which I assume is why the field handling wasn't unoptimized to be
> strictly correct.
> 
> Nevertheless, I see no reason not to remove avoidable inconsistencies
> from the current design.

Yes, but perhaps its time to fix the real problem and not just add
band-aids. That thread is over 6 years old (the email was from Jan 14, 2014)

$ git diff `git rev-list --before 'Jan 14 2014' HEAD --max-count=1` |
  grep '^+' | grep sscanf | wc -l
622

There's been over 600 new additions of sscanf(). Now is the time to just
fix it correctly.

-- Steve
