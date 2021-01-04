Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364EC2E9226
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhADIs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:48:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:48386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbhADIs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:48:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609750060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lqG4UmkZPkzR4Zi5SXqaX9O4JmxRq0adZPH7D9loI+Y=;
        b=Fl8muME5yB3vL19zQ0uF80xGhufGuQs0GG9x52XThP/w+In1WyVlOJzi2DYH4SXQbHSDrN
        gOtPAQmKSICkk7DK2rotycPHYpr0p5QYVwIvwLAwH7ard5gD2Qla8MiaEkj9HYlsRS2Rx+
        EYzPVl9h83dFnWHYsDYPA1QxUszb920=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64AF3ACBA;
        Mon,  4 Jan 2021 08:47:40 +0000 (UTC)
Date:   Mon, 4 Jan 2021 09:47:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <smuchun@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Hui Su <sh_def@163.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/page_alloc: remove the static for local variable
 node_order
Message-ID: <20210104084739.GB13207@dhcp22.suse.cz>
References: <20201230114014.GA1934427@ubuntu-A520I-AC>
 <20201230124233.GE28221@casper.infradead.org>
 <CAPSr9jHa8nT=Y1R2w9v7UUFJNXhCFohwDGwyv7WOWjKADZEchw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSr9jHa8nT=Y1R2w9v7UUFJNXhCFohwDGwyv7WOWjKADZEchw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-12-20 21:41:30, Muchun Song wrote:
> On Wed, Dec 30, 2020 at 8:45 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 30, 2020 at 07:40:14PM +0800, Hui Su wrote:
> > > local variable node_order do not need the static here.
> >
> > It bloody well does.  It can be up to 2^10 entries on x86 (and larger
> > on others) That's 4kB which you've now moved onto the stack.
> 
> This is not the first time I have seen similar changes. So what
> do you think about adding a comment here to avoid another one
> do this in the feature?

Well, this is not an unusual technieque to reduce the stack space. I am
not really sure we really need to put an explicit comment about that.  I
would appreciate much more if patch submitters took an extra step when
creating seemingly trivial patches and either consult the history of the
respective code or look for a similar pattern elsewhere before sending
them.

I do agree with Willy that mm code is usually not a great place to
search for trivial patches. First of all most people tend to be pretty
busy with other reviewes and the code has grown rather delicate and
tricky so each review is non trivial.
-- 
Michal Hocko
SUSE Labs
