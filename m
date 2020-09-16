Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4854326C6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgIPSNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:13:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgIPSMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:12:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14EA2B14F;
        Wed, 16 Sep 2020 18:12:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 20:12:31 +0200
From:   osalvador@suse.de
To:     Aristeu Rozanski <aris@ruivo.org>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        mhocko@kernel.org, tony.luck@intel.com, cai@lca.pw,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
In-Reply-To: <20200916175813.GD17169@cathedrallabs.org>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org> <20200916072658.GA10692@linux>
 <20200916135358.GB17169@cathedrallabs.org> <20200916140921.GA17949@linux>
 <20200916144603.GC17169@cathedrallabs.org>
 <9bd7ac81968a7897474804d53bfc1286@suse.de>
 <f9163730a1cd3480788e53a2153d2ea3@suse.de>
 <20200916175813.GD17169@cathedrallabs.org>
User-Agent: Roundcube Webmail
Message-ID: <79739b73f77a124cafa056e56f57c450@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-16 19:58, Aristeu Rozanski wrote:
> On Wed, Sep 16, 2020 at 06:34:52PM +0200, osalvador@suse.de wrote:
>> Fat fingers, sorry:
>> 
>> Ok, this is something different.
>> The race you saw previously is kinda normal as there is a race window
>> between spotting a freepage and taking it off the buddy freelists.
>> The retry patch should help there.
>> 
>> The issue you are seeing right here is due to the call to
>> page_handle_poison in __soft_offline_page being wrong, as we pass
>> hugepage_or_freepage = true inconditionally, which is wrong.
>> I think it was caused during rebasing.
>> 
>> Should be:
> 
> Tests passed with this patch on top of others.
> Thanks!

Thanks for giving it a shot!
I will be sending patches tomorrow morning.

Thanks
