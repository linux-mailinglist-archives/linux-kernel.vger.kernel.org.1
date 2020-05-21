Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2207E1DC8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgEUIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 04:45:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:33374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbgEUIpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:45:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF1AEACA7;
        Thu, 21 May 2020 08:45:07 +0000 (UTC)
Date:   Thu, 21 May 2020 10:45:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
Message-ID: <20200521084504.GG3464@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520114333.GC520@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-05-20 20:43:33, Sergey Senozhatsky wrote:
> On (20/05/15 18:02), Petr Mladek wrote:
> > On Wed 2020-04-15 20:00:43, Andy Shevchenko wrote:
> > > It is a logical continuation of previously applied %ptR for struct rtc_time.
> > > We have few users of time64_t that would like to print it.
> > 
> > It seems that everything was explained and the patches look good to
> > me. If we allowed %ptR then it makes sense to allow %ptT as well.
> > 
> > For all three patches:
> > 
> > Rewieved-by: Petr Mladek <pmladek@suse.com>
> 
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

This patchset has been committed into printk/linux.git,
branch for-5.8-printf-time64_t.

Note that it is a new git repo with shared write access.

Best Regards,
Petr
