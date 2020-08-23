Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E0824EE08
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHWPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgHWPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 11:55:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D492C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gTFW7gfK1pw0y0A6L2wm8p78fu8cvj8YkHvYnky0j6E=; b=mdg1xShthE41AFop+/agpm3Y+m
        yqYERkc00Itm4p/ciW2TzUNTiZVB1DnXfxkDgvg5CDyna6DgS4WE1rro3Xv3YV1ZYALm3BFUxwnL/
        K5OBQ0k1DW+Yu5WrNOXIsIYCUGjWhitQ32N1wipvGUhfD8LtcbdMGy8+st35F7FyeE19+kuvxNnqh
        zGi06Nam18XtyjPY8XYiXZd2S28nCFWk7F8EUdtCih+A2Hud8TdrJVG9g8kpLgz0uHatlHIjRRfdL
        jcEuKYIl8f382tCcOqitNCD+FolBarHIAN1wVIdCNbSYO5yAaMlk6cS9ETHCbtYRDomgBErDwETBV
        3DByR58g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9sKb-0000O8-2f; Sun, 23 Aug 2020 15:54:53 +0000
Date:   Sun, 23 Aug 2020 16:54:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xu Wang <vulab@iscas.ac.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] hugetlb_cgroup: convert comma to semicolon
Message-ID: <20200823155453.GB17456@casper.infradead.org>
References: <20200818064333.21759-1-vulab@iscas.ac.cn>
 <20200818184036.d6c479446b2c3b231d1e3bff@linux-foundation.org>
 <87eeo32gto.fsf@redhat.com>
 <20200823152130.GA17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200823152130.GA17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 04:21:30PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 19, 2020 at 10:14:11AM +0200, Giuseppe Scrivano wrote:
> > >> -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]),
> > >> +	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
> > >>  	cft->flags = CFTYPE_NOT_ON_ROOT;
> > 
> > I think in this case having two expressions as part of the same
> > statement is equivalent to having two separate statements.  Both
> > cft->file_offset and cft->flags get the expected value.
> 
> That's not how the comma operator works.
> 
> It will evaluate offsetof(struct hugetlb_cgroup, events_file[idx]) and
> then discard the result.  Since it has no side-effects, this is effectively
> doing:
> 
> 	cft->file_offset = cft->flags = CFTYPE_NOT_ON_ROOT;

_oh_.  I tested this.  I'm wrong because the comma operator is at lower
precedence than assignment.

Testcase:

struct a {
  int x;
  int y;
};

void g(struct a *a) {
  a->x = 1,
  a->y = 0;
}

void h(struct a *a) {
  a->x = (1,
  a->y = 0);
}

test.c: In function ‘h’:
test.c:12:12: warning: left-hand operand of comma expression has no effect [-Wunused-value]
   12 |   a->x = (1,
      |            ^

0000000000000000 <g>:
   0:	48 c7 07 01 00 00 00 	movq   $0x1,(%rdi)
   7:	c3                   	retq   
   8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   f:	00 

0000000000000010 <h>:
  10:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
  17:	c3                   	retq   

So there's no bug here!  It's just confusing, so should be fixed.

(I think Andrew was confused too ;-)
