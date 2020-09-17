Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50F726E2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIQRsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:48:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8211 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgIQRru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:47:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f63a1080000>; Thu, 17 Sep 2020 10:46:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 10:47:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 10:47:31 -0700
Received: from [10.2.57.133] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 17:47:27 +0000
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        <akpm@linux-foundation.org>, <gustavoars@kernel.org>,
        <madhuparnabhowmik10@gmail.com>, <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam> <20200917123951.GP18329@kadam>
 <20200917173424.GB2540965@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <42c317bc-6212-caef-687e-84e8f009d8b5@nvidia.com>
Date:   Thu, 17 Sep 2020 10:47:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917173424.GB2540965@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600364808; bh=HCaNL+mCuBCxsjK5A8+xwkbbKXf4BXYGyNVMVaV2uhw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Or3cs/Uav8/8X+eOKRA4yoqQrvmuuosnofaniJxVYjoikpzLTYKoe9AE4EonujsdI
         TqhvyVzAuX7b+QkvlgpRT3Mi7GRoSHJMODpAT65ScGHJcmMA34HNSa38BvDsNvCFgx
         XBJ5t6RoDk619GgtXHaYN7zfI5HOmJGHqtIHoSsazJPi+DeeXUcMR3rI9nChnzhdxN
         kiAw4kWOLmMtREkcWzTjDsFOitxjeBwS+Q72wbFEy9bxrbvS86VK665hJqJQ+U+lpS
         8sevmNErtVj97tibMu7P3tNXlTlrNb0yBeI7lMpffNZe5X/SVvo+Izv8pTlvlOd/Jl
         j2rM16DtJRmVQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 10:34 AM, Ira Weiny wrote:
> On Thu, Sep 17, 2020 at 03:39:51PM +0300, Dan Carpenter wrote:
>> On Wed, Sep 16, 2020 at 01:02:32PM +0300, Dan Carpenter wrote:
>>> On Wed, Sep 16, 2020 at 09:12:17AM +0530, Souptick Joarder wrote:
>>>> There is an error when pin_user_pages_fast() returns -ERRNO and
>>>> inside error handling path driver end up calling unpin_user_pages()
>>>> with -ERRNO which is not correct.
>>>>
>>>> This patch will fix the problem.
>>>
>>> There are a few ways we could prevent bug in the future.
>>>
>>> 1) This could have been caught with existing static analysis tools
>>>     which warn about when a value is set but not used.
>>>
>>> 2) I've created a Smatch check which warngs about:
>>>
>>> 	drivers/rapidio/devices/rio_mport_cdev.c:955 rio_dma_transfer() warn: unpinning negative pages 'nr_pages'
>>>
>>>     I'll test it out tonight and see how well it works.  I don't
>>>     immediately see any other bugs allthough Smatch doesn't like the code
>>>     in siw_umem_release().  It uses "min_t(int" which suggests that
>>>     negative pages are okay.
>>>
>>> 	   int to_free = min_t(int, PAGES_PER_CHUNK, num_pages);
>>>
>>
>> I only found one bug but I'm going to add unpin_user_pages_dirty_lock()
>> to the mix a retest.  There were a few other false positives.  In
>> reviewing the code, I noticed that orangefs_bufmap_map() is also buggy.
>>
>> I sort of feel like returning partial successes is not working.  We
>> could easily make a wrapper which either pins everything or it returns
>> an error code.

Yes we could. And I have the same feeling about this API. It's generated a
remarkable amount of bug fixes, several of which ended up being partial or
wrong in themselves. And mostly this is due to the complicated tristate
return code: instead of 0 or -ERRNO, it also can return "N pages that is
less than what you requested", and there are no standard helpers in the kernel
to make that easier to deal with.

> 
> I guess the question is are there drivers which will keep working (or limp
> along?) on partial pins?  A quick search of a driver I thought did this does
> not apparently any more...  So it sounds good to me from 30,000 feet!  :-D

It sounds good to me too--and from just a *few hundred feet* (having touched most
of the call sites at some point)! haha :)

I think the wrapper should be short-term, though, just until all the callers
are converted to the simpler API. Then change the core gup/pup calls to the simpler
API. There are more than enough gup/pup API entry points as it is, that's for sure.


thanks,
-- 
John Hubbard
NVIDIA
