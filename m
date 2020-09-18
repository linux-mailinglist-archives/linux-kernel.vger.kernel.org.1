Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B98226F5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIRGdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:33:24 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14863 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgIRGdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:33:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6454880001>; Thu, 17 Sep 2020 23:32:40 -0700
Received: from [10.2.52.182] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 06:33:19 +0000
Subject: Re: [linux-next PATCH] rapidio: Fix error handling path
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <mporter@kernel.crashing.org>, <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <gustavoars@kernel.org>, <madhuparnabhowmik10@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>
References: <1600227737-20785-1-git-send-email-jrdr.linux@gmail.com>
 <20200916100232.GF18329@kadam> <20200917123951.GP18329@kadam>
 <20200917173424.GB2540965@iweiny-DESK2.sc.intel.com>
 <42c317bc-6212-caef-687e-84e8f009d8b5@nvidia.com>
 <CAFqt6zYT83JrkdnYx03+KbRzZ1wMcV0mNOUNmmtWg7hdr-B+1g@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c6719871-6dda-9ec1-936d-c9afd6d45cac@nvidia.com>
Date:   Thu, 17 Sep 2020 23:33:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYT83JrkdnYx03+KbRzZ1wMcV0mNOUNmmtWg7hdr-B+1g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600410760; bh=p1eokpT3EYECayzEoymlX8tAaYLNYZCGrNzE8tA7328=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=nRJw3mZlXuT2vmCu7SXCgS/Djnd7KKRWzmsBT+PIEvOrtalPdS1Mgy3EZlaJ4n2xG
         IuEf2VQGV28lCIH8bPs6zNF1Fo3cGZtmMKiaS49AbZ68ptPbE57h4slXSaDvw2PZHT
         rBugCrAEZkb/HwGHlbFxZrqmvRcP8L+PVDgJfVcS8rgbYM3lx/S0WaBGoNDOBnNIzZ
         Di7/PlpFhBNpby2I2FDw1+JlgL08+Z1TQVDS7diDFRBoqvG5N5HIHKGo3Env+ix5q9
         25DgH+puSIfo+T3ngVVNSpzxL3niajuG2dUNagHbQvZCyID7bwaf0wx/Q1D2UsLKg6
         4kPwwe1IDD1VA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/20 7:21 PM, Souptick Joarder wrote:
> On Thu, Sep 17, 2020 at 11:17 PM John Hubbard <jhubbard@nvidia.com> wrote:
...
>>>> I sort of feel like returning partial successes is not working.  We
>>>> could easily make a wrapper which either pins everything or it returns
>>>> an error code.
>>
>> Yes we could. And I have the same feeling about this API. It's generated a
>> remarkable amount of bug fixes, several of which ended up being partial or
>> wrong in themselves. And mostly this is due to the complicated tristate
>> return code: instead of 0 or -ERRNO, it also can return "N pages that is
>> less than what you requested", and there are no standard helpers in the kernel
>> to make that easier to deal with
> 
> There was some discussion on removing return value 0 from one of the
> gup variants [1].
> I think it might be partially relevant to the current discussion.
> 
> [1] https://patchwork.kernel.org/patch/11529795/
> 

Yes, although as I mentioned above, I'm thinking of a 0 or -ERRNO return value,
and not even return nr_pages at all.

But in any case, as a practical matter, I'm not sure if it's a good idea to
actually change all the callsites, or not. If we just fix the remaining buggy
callers, maybe that's better than the churn associated with another API change.

On the other-other hand, there does seem to be more churn coming anyway, with
talk of actually doing a [get|pin]_user_bvec(), for example. So maybe it's better
to head off the coming mess.

This is something that should be discussed on linux-mm.

>>
>>>
>>> I guess the question is are there drivers which will keep working (or limp
>>> along?) on partial pins?  A quick search of a driver I thought did this does
>>> not apparently any more...  So it sounds good to me from 30,000 feet!  :-D
>>
>> It sounds good to me too--and from just a *few hundred feet* (having touched most
>> of the call sites at some point)! haha :)
>>
>> I think the wrapper should be short-term, though, just until all the callers
>> are converted to the simpler API. Then change the core gup/pup calls to the simpler
>> API. There are more than enough gup/pup API entry points as it is, that's for sure.
>>
>>
>> thanks,
>> --
>> John Hubbard
>> NVIDIA

thanks,
-- 
John Hubbard
NVIDIA
