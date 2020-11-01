Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4F2A21D7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 22:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgKAVTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 16:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgKAVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 16:19:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE7EC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 13:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mHXvI0jUyLtPqLG2ZOT9kseyc1b7gzS+qOQUvgHUGC8=; b=ZK2GisT1dGB0fQt/foU9qw5DOv
        j9xH2R9iQ8B0KN34XuStdIFPZ/oH8BcDRESWdTrRvNJ8Yvt0v0mJKjiH94xGoqQ/a2BIZlRZ78hE6
        IBt6kA8+sh+kouR1qfeDyPz8xIQw4iNet/Xhm4nVW6g+rrMg9Sh4kRv/pd9aG36hjeA4Ty4uGD9Eg
        SPgdXysioMhcKV/XugpyNK4c6pvQl8ZANhXv/hddw769jH3OvgkncnEveWCsgjplZe3kihQkTbALi
        dOJFXSfORXcf7xWw2pkJPxHIwUeEFwG7Rf5qC5sX3OWOFvWS3fiPJuVCa8u8CO5O5DIu577SyqBu9
        jAWLMNkg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZKko-0004ya-BA; Sun, 01 Nov 2020 21:19:10 +0000
Date:   Sun, 1 Nov 2020 21:19:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
Message-ID: <20201101211910.GG27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
 <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
 <20201101204834.GF27442@casper.infradead.org>
 <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 01:04:35PM -0800, Joe Perches wrote:
> On Sun, 2020-11-01 at 20:48 +0000, Matthew Wilcox wrote:
> > On Sun, Nov 01, 2020 at 12:12:51PM -0800, Joe Perches wrote:
> > > @@ -4024,7 +4024,7 @@ int __init shmem_init(void)
> > >  
> > > 
> > >  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
> > >  static ssize_t shmem_enabled_show(struct kobject *kobj,
> > > -		struct kobj_attribute *attr, char *buf)
> > > +				  struct kobj_attribute *attr, char *buf)
> > >  {
> > >  	static const int values[] = {
> > >  		SHMEM_HUGE_ALWAYS,
> > 
> > Why?
> 
> why what?

Why did you change this?

> > > @@ -4034,16 +4034,19 @@ static ssize_t shmem_enabled_show(struct kobject *kobj,
> > >  		SHMEM_HUGE_DENY,
> > >  		SHMEM_HUGE_FORCE,
> > >  	};
> > > -	int i, count;
> > > -
> > > -	for (i = 0, count = 0; i < ARRAY_SIZE(values); i++) {
> > > -		const char *fmt = shmem_huge == values[i] ? "[%s] " : "%s ";
> > > +	int len = 0;
> > > +	int i;
> > 
> > Better:
> > 	int i, len = 0;
> 
> I generally disagree as I think it better to have each declaration on an
> individual line.

You're wrong.

> > > -		count += sprintf(buf + count, fmt,
> > > -				shmem_format_huge(values[i]));
> > > +	for (i = 0; i < ARRAY_SIZE(values); i++) {
> > > +		len += sysfs_emit_at(buf, len,
> > > +				     shmem_huge == values[i] ? "%s[%s]" : "%s%s",
> > > +				     i ? " " : "",
> > > +				     shmem_format_huge(values[i]));
> > 
> > This is ... complicated.  I thought the point of doing all the sysfs_emit
> > stuff was to simplify things.
> 
> The removal of fmt allows the format and argument to be __printf verified.
> Indirected formats do not generally allow that.
> 
> And using sysfs_emit is not really intended to simplify output code, it's
> used to make sure there isn't a overflow of the PAGE_SIZE output buf when
> using sprintf/snprintf.

Look, this isn't performance sensitive code.  Just do something simple.

		if (shmem_huge == values[i])
			buf += sysfs_emit(buf, "[%s]",
					shmem_format_huge(values[i]));
		else
			buf += sysfs_emit(buf, "%s",
					shmem_format_huge(values[i]));
		if (i == ARRAY_SIZE(values) - 1)
			buf += sysfs_emit(buf, "\n");
		else
			buf += sysfs_emit(buf, " ");

Shame there's no sysfs_emitc, but there you go.
