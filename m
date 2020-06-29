Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9020D8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 22:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgF2Tl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:41:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:41408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbgF2TlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:41:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37EF8AD26;
        Mon, 29 Jun 2020 15:53:03 +0000 (UTC)
Date:   Mon, 29 Jun 2020 17:53:02 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        tobin@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        stable@kernel.org
Subject: Re: [PATCH] mm/vmscan: restore zone_reclaim_mode ABI
Message-ID: <20200629155302.6okkufqmj3kupvzw@beryllium.lan>
References: <20200626003459.D8E015CA@viggo.jf.intel.com>
 <20200626075918.dj6ioaon5iuhtg6k@beryllium.lan>
 <83731eeb-1f64-50b7-41e9-5b7114678533@intel.com>
 <20200629071338.m4veigbp4tu45gbz@beryllium.lan>
 <c9a24700-7ec8-2bf8-1a13-c3ddf249a1a0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a24700-7ec8-2bf8-1a13-c3ddf249a1a0@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:36:15AM -0700, Dave Hansen wrote:
> On 6/29/20 12:13 AM, Daniel Wagner wrote:
> > I went to go add a new RECLAIM_* mode for the zone_reclaim_mode
> > sysctl.
> 
> This conveys my motivation.

You don't need to tell a story. As explained in the documetation
'Describe your changes', describe your change in imperative mood,
e.g. something like

  "Add RECLAIM_* mode for the the zone_reclaim_mode sysctl."

> > Like a good kernel developer, I also went to go update the
> > documentation.
> 
> This takes the opportunity to throw a tiny bit of shade in the direction
> of the other folks who modified the #define without updating the
> documentation.

What about something simple as, "Update the documetation to
match the implementation" or whatever makes it clear why
you are touching the documetation bits.

Anyway, I just wanted to help you to write better commit
messages. I understand, my help is not welcome.
