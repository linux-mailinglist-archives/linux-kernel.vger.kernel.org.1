Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E3E2711FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 06:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgITENU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 00:13:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16325 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITENU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 00:13:20 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f66d6b30000>; Sat, 19 Sep 2020 21:12:35 -0700
Received: from [10.2.52.182] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 20 Sep
 2020 04:13:18 +0000
Subject: Re: [PATCH] mm/gup: protect unpin_user_pages() against npages==-ERRNO
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <alex.bou9@gmail.com>,
        <gustavoars@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>, <madhuparnabhowmik10@gmail.com>,
        <mporter@kernel.crashing.org>, Matthew Wilcox <willy@infradead.org>
References: <20200916100232.GF18329@kadam>
 <20200917065706.409079-1-jhubbard@nvidia.com> <20200917074054.GO18329@kadam>
 <CAFqt6zYFjGTJ=KUjHd5jf-ri5tCmo4HOLP1j3nsELFgcoEoLHQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7812dfc5-698d-e765-ad62-abf23d19d3cf@nvidia.com>
Date:   Sat, 19 Sep 2020 21:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYFjGTJ=KUjHd5jf-ri5tCmo4HOLP1j3nsELFgcoEoLHQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600575155; bh=m33F43k6ThFH0WLhvBUSNEz46bGRVYGvkyLd8PV6uC4=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=aQMDyhhBU/nd0EnkV0JTV8dYZel5tQEJT7uevM38qyGKEBjQxrWgZOIAgTqRpSnny
         W5rAIEqUMPTvegI8U14RrBfOVc57FCzjYbwwh//Lmb+bgU8HB2W/GB6ee8wVPrXZh6
         XSjVYxZwaYScqsx/ffsP0n9gYdNwuWY8nLPBfb3LZef+gas6vFiN+Js+S/DnzHlVtL
         k7SBYWHCPTZ+6XkG2ttSJZ7/O0K1Rzx3CxNIOtdi4pmNCWOzepcaAO9pbZ+9oAyh0R
         RJ+3Xft+4k0BijToAWe17HZiMM245K8MhMQGwd5RME1q6AXioZuc6OfjqL8Sol8Awy
         vwyNWVjWJifQg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/20 8:03 PM, Souptick Joarder wrote:
> On Thu, Sep 17, 2020 at 1:11 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> On Wed, Sep 16, 2020 at 11:57:06PM -0700, John Hubbard wrote:
>>> As suggested by Dan Carpenter, fortify unpin_user_pages() just a bit,
>>> against a typical caller mistake: check if the npages arg is really a
>>> -ERRNO value, which would blow up the unpinning loop: WARN and return.
>>>
>>> If this new WARN_ON() fires, then the system *might* be leaking pages
>>> (by leaving them pinned), but probably not. More likely, gup/pup
>>> returned a hard -ERRNO error to the caller, who erroneously passed it
>>> here.
...
> 
> Do we need a similar check inside unpin_user_pages_dirty_lock(),
> when make_dirty set to false ?


Maybe not. This call is rarely if ever used for error handling, but
rather, for finishing up a successful use of the pages.

There is a balance between protecting against buggy callers and just
fixing any buggy callers. There is also a limit to how much code one can
write in hopes of avoiding bugs in...code that one writes. :)  Which is
why static analysis, unit and regression tests, code reviews are
important too.

Here, I submit that that we're about to cross the line and go too far.
But if you have any examples of buggy callers for
unpin_user_pages_dirty_lock(), that might shift the line.

Or maybe others feel that we haven't gone far enough yet after all?


thanks,
-- 
John Hubbard
NVIDIA
