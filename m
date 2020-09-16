Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D326C6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgIPSBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:01:18 -0400
Received: from lobo.ruivo.org ([173.14.175.98]:34564 "EHLO lobo.ruivo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbgIPR6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:58:43 -0400
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 4FFC1534C1; Wed, 16 Sep 2020 13:58:36 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tate.lan.ruivo
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.5 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 33C0752DA4;
        Wed, 16 Sep 2020 13:58:14 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 06FC71A1A61; Wed, 16 Sep 2020 13:58:14 -0400 (EDT)
Date:   Wed, 16 Sep 2020 13:58:14 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     osalvador@suse.de
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Message-ID: <20200916175813.GD17169@cathedrallabs.org>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org>
 <20200916072658.GA10692@linux>
 <20200916135358.GB17169@cathedrallabs.org>
 <20200916140921.GA17949@linux>
 <20200916144603.GC17169@cathedrallabs.org>
 <9bd7ac81968a7897474804d53bfc1286@suse.de>
 <f9163730a1cd3480788e53a2153d2ea3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9163730a1cd3480788e53a2153d2ea3@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:52PM +0200, osalvador@suse.de wrote:
> Fat fingers, sorry:
> 
> Ok, this is something different.
> The race you saw previously is kinda normal as there is a race window 
> between spotting a freepage and taking it off the buddy freelists.
> The retry patch should help there.
> 
> The issue you are seeing right here is due to the call to 
> page_handle_poison in __soft_offline_page being wrong, as we pass 
> hugepage_or_freepage = true inconditionally, which is wrong.
> I think it was caused during rebasing.
> 
> Should be:

Tests passed with this patch on top of others.
Thanks!

-- 
Aristeu

