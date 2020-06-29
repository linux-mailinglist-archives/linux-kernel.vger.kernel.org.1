Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E11420D7FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbgF2Tej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:34:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:36738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733155AbgF2Tb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA306AF39;
        Mon, 29 Jun 2020 07:13:38 +0000 (UTC)
Date:   Mon, 29 Jun 2020 09:13:38 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        tobin@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        stable@kernel.org
Subject: Re: [PATCH] mm/vmscan: restore zone_reclaim_mode ABI
Message-ID: <20200629071338.m4veigbp4tu45gbz@beryllium.lan>
References: <20200626003459.D8E015CA@viggo.jf.intel.com>
 <20200626075918.dj6ioaon5iuhtg6k@beryllium.lan>
 <83731eeb-1f64-50b7-41e9-5b7114678533@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83731eeb-1f64-50b7-41e9-5b7114678533@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Fri, Jun 26, 2020 at 06:53:33AM -0700, Dave Hansen wrote:
> Was there something else specifically in the documentation which you
> think I've neglected?

The first paragraph explains how you ended up modifying the code. While
I understand that you want to document the process, it wont help
a reader in future. It doesn't add any intersting information at all.
Just state what you're doing as first thing and explain why you are
doing it after it.

> > I think the documentation update should not be part of this patch.
> > This makes the back porting to stable more difficult.
> 
> Really?  If a backporter doesn't care about documentation, I'd just
> expect them to see the reject, ignore it, and move on with their life.
> If they do, they'd want the code fix and the Documentation/ update in
> the same patch so that they don't get disconnected.

I understood you are fixing a regression ingroduced by a previous change. In
this case I would only fix the regression. Updating/improving the
documentation is good, I just don't think it's necessary to back port it to
stables trees along side the bug fix.

Thanks,
Daniel
