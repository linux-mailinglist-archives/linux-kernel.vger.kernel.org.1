Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642F2256520
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgH2GlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 02:41:05 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:51024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgH2GlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:41:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C5A11100E7B44;
        Sat, 29 Aug 2020 06:41:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:1981:2194:2198:2199:2200:2393:2553:2559:2562:2828:2914:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:7875:7903:7904:8603:9897:10004:10400:10848:11026:11232:11473:11658:11914:12043:12291:12296:12297:12555:12683:12740:12760:12895:12986:13019:13439:14181:14659:14721:21080:21433:21451:21627:21740:21939:21990:30025:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: debt34_33114042707c
X-Filterd-Recvd-Size: 3722
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 06:41:01 +0000 (UTC)
Message-ID: <2acf2dc0945bc7f1ec2617b616808ab3c514067b.camel@perches.com>
Subject: Re: [PATCH] sysfs: Add sysfs_emit to replace sprintf to PAGE_SIZE
 buffers.
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Aug 2020 23:41:00 -0700
In-Reply-To: <20200829062254.GA79296@kroah.com>
References: <a96cdf07cd136d06c3cc1e10eb884caa7498ba72.1598654887.git.joe@perches.com>
         <20200829062254.GA79296@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 08:22 +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 28, 2020 at 03:52:13PM -0700, Joe Perches wrote:
> > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > used for outputting sysfs content requests and it's possible to
> > overrun the buffer length.
> > 
> > Add a generic sysfs_emit mechanism that knows that the size of the
> > temporary buffer and ensures that no overrun is done.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  fs/sysfs/file.c       | 30 ++++++++++++++++++++++++++++++
> >  include/linux/sysfs.h |  8 ++++++++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index eb6897ab78e7..06a13bbd7080 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -707,3 +707,33 @@ int sysfs_change_owner(struct kobject *kobj, kuid_t kuid, kgid_t kgid)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(sysfs_change_owner);
> > +
> > +/**
> > + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> > + *	@buf:	start of PAGE_SIZE buffer.
> > + *	@pos:	current position in buffer
> > + *              (pos - buf) must always be < PAGE_SIZE
> 
> sysfs files are always supposed to be "one value per file", so why would
> you ever need a 'pos' variable to show the location in the buffer?

I've done treewide conversions using cocci.
It's used all over the place.
Especially in loops with arrays.

Sometimes the output is single line.
Sometimes multiple lines.

Look at the sample conversion of mem_sleep_show I posted earlier.

#ifdef CONFIG_SUSPEND
 static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
                              char *buf)
 {
-       char *s = buf;
+       char *pos = buf;
        suspend_state_t i;
 
        for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
                if (mem_sleep_states[i]) {
                        const char *label = mem_sleep_states[i];
 
                        if (mem_sleep_current == i)
-                               s += sprintf(s, "[%s] ", label);
+                               pos += sysfs_emit(buf, pos, "[%s] ", label);
                        else
-                               s += sprintf(s, "%s ", label);
+                               pos += sysfs_emit(buf, pos, "%s ", label);
                }
 
        /* Convert the last space to a newline if needed. */
-       if (s != buf)
-               *(s-1) = '\n';
+       if (pos != buf)
+               *(pos - 1) = '\n';
 
-       return (s - buf);
+       return pos - buf;
 }
 



