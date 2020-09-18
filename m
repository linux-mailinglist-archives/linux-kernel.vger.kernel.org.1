Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0126F580
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgIRFtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:49:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgIRFtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:49:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DBB02ACC8;
        Fri, 18 Sep 2020 05:49:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Sep 2020 07:49:11 +0200
From:   osalvador@suse.de
To:     =?UTF-8?Q?HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4?=
         =?UTF-8?Q?=E4=B9=9F=29?= <naoya.horiguchi@nec.com>
Cc:     akpm@linux-foundation.org, aris@ruivo.org, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 0/7] HWpoison: further fixes and cleanups
In-Reply-To: <20200917152717.GA26808@hori.linux.bs1.fc.nec.co.jp>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917113920.GA19898@hori.linux.bs1.fc.nec.co.jp>
 <20200917130948.GA1812@linux> <20200917133959.GA2504@linux>
 <20200917152717.GA26808@hori.linux.bs1.fc.nec.co.jp>
User-Agent: Roundcube Webmail
Message-ID: <da0a0c702d944e98dd690349947c0fe5@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 17:27, HORIGUCHI NAOYA wrote:
> Sorry, I modified the patches based on the different assumption from 
> yours.
> I firstly thought of taking page off after confirming the error page
> is freed back to buddy. This approach leaves the possibility of reusing
> the error page (which is acceptable), but simpler and less invasive 
> one.
> 
> Your approach removes the error page from page allocator's control in
> freeing time. It has no possibility of reusing the error page but 
> changes
> are tightly coupled with page free code.
> 
> This is a tradeoff between complexity and completeness of soft offline,
> Now I'm not sure I could persist on my own opinion without providing
> working code, and it's OK for me to take your one.

Yeah, you are right it is a trade off.
I would suggest taking this path now, and if it proofs to be problematic 
in some way, we can always
do the:

free_page
  take_it_off_buddy
   OK: mark it as hwpoison and increment refcount
   NOT_OK (raced with allocation): oops, sorry

> The test passed in my environment, so this is fine.

Thanks for trying it out.

> 
>> If they do, I will try to see if Andrew can squezee above changes into 
>> [1],
>> where they belong to.
> 
> Yes, proposing the fix for 
> mmhwpoison-rework-soft-offline-for-in-use-pages.patch
> seems fine to me.
> 
> Again, sorry for modifying code without asking.

No worries, I wil do a couple of tests on my own and then I will talk to 
Andrew to see if we can squeeze the changes in there.


