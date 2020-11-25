Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E622C4BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 00:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgKYXnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 18:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgKYXnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 18:43:49 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44022083E;
        Wed, 25 Nov 2020 23:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606347827;
        bh=kOFErl5XJMINI4SwJaOp8h3tEhoYiaCWvoyO10MzEpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AiPLLhwpmyxZVxCNgJMBV3tPUxIEObX7uSwkhvWnlE/p8XwtwhEEK8aLAFCyDURKr
         B1qvYuP4e/mwn/e6w4dy+kMJwgbR9fYvRj1fI027lJUYszZXhgKl0F1UXsC5C5ODgI
         0Ieg5+mPw+XRGr7VETEUiNJqkyd5AxYczzL8SfXg=
Date:   Wed, 25 Nov 2020 15:43:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
Message-Id: <20201125154346.b2032c39cf3905bbebec3322@linux-foundation.org>
In-Reply-To: <46ad053f-1401-31e8-50cf-09acda588f6f@suse.cz>
References: <1605859413-53864-1-git-send-email-alex.shi@linux.alibaba.com>
        <20201120151307.4d9e3ef092ba01a325db7ce2@linux-foundation.org>
        <a355270e-5949-ebb2-30cb-a3723f6c93f8@linux.alibaba.com>
        <20201122123552.GF4327@casper.infradead.org>
        <728874d7-2d93-4049-68c1-dcc3b2d52ccd@linux.alibaba.com>
        <46ad053f-1401-31e8-50cf-09acda588f6f@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 12:21:28 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 11/22/20 3:00 PM, Alex Shi wrote:
> > Thanks a lot for all comments, I picked all up and here is the v3:
> > 
> >  From 167131dd106a96fd08af725df850e0da6ec899af Mon Sep 17 00:00:00 2001
> > From: Alex Shi <alex.shi@linux.alibaba.com>
> > Date: Fri, 20 Nov 2020 14:49:16 +0800
> > Subject: [PATCH v3 next] mm/vmscan: __isolate_lru_page_prepare clean up
> > 
> > The function just return 2 results, so use a 'switch' to deal with its
> > result is unnecessary, and simplify it to a bool func as Vlastimil
> > suggested.
> > 
> > Also remove 'goto' by reusing list_move(), and take Matthew Wilcox's
> > suggestion to update comments in function.
> 
> I wouldn't mind if the goto stayed, but it's not repeating that much 
> without it (list_move() + continue, 3 times) so...

I tried that, and .text became significantly larger, for reasons which
I didn't investigate ;)

