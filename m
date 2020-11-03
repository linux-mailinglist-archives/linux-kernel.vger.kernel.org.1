Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4102A4FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgKCTSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:18:50 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6985 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgKCTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:18:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa1ad1c0001>; Tue, 03 Nov 2020 11:18:52 -0800
Received: from [10.2.49.167] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 19:18:49 +0000
Subject: Re: [RFC PATCH resend 3/6] mm: Add refcount for preserving mm_struct
 without pgd
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20201016230915.1972840-1-jannh@google.com>
 <20201016230915.1972840-4-jannh@google.com> <20201016232153.GD37159@ziepe.ca>
 <CAG48ez1+VzW=Gz+2CKze_kmFYfb9J3PdrkJtxS21EyqGHZMGjw@mail.gmail.com>
 <CAG48ez0ChA80cjg4-=1k8PfXV_4u_YVQay9g_RdrLjbAzch4Gw@mail.gmail.com>
 <CAG48ez1ue84pXoQvdjqiXZSj5_3+2Wq7A9v9D_7=rzEFac2AFg@mail.gmail.com>
 <20201103132127.GK36674@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4f428d8e-b660-9e31-6968-b28f6d7088f5@nvidia.com>
Date:   Tue, 3 Nov 2020 11:18:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201103132127.GK36674@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604431132; bh=+CPAgnnyqw7VL/JoIR0Kx+j9vZxF1jTOALVKJZvaioQ=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Z035LvsYyiQh+Qrrs6mbfgKqZHCU4WAXlib5do+P2G30AYSolgzcwkc19NpY61nAc
         Y/ZmcmVUOabb4GLDzhrHM7bSHSIHdCFs6341uFVB5AMF/rzOj1t9S76lrSYV9M/NQe
         22APW7CcQTQzEQ//2jwsYkfs49RuZZmGU5F02CKhaWp6fcgcNrLgjwZLMj+Bs0MIvR
         p5cZOutussLxBCurITL0hshae9TYDEqmRj43Egpry0X5IWWDM4APrbBjHCKiTH7cJx
         RRhfQYWsOsNzmJrnUan7JSjrgNjlr3r0+kDzmaMB86s3jLVmlEhnx3hm4Ll8cX+yxS
         ISc4zlZswZGOQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 5:21 AM, Jason Gunthorpe wrote:
> On Tue, Nov 03, 2020 at 04:19:11AM +0100, Jann Horn wrote:
>> On Tue, Nov 3, 2020 at 3:11 AM Jann Horn <jannh@google.com> wrote:
>>> On Sat, Oct 17, 2020 at 2:30 AM Jann Horn <jannh@google.com> wrote:
>>>> On Sat, Oct 17, 2020 at 1:21 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>> On Sat, Oct 17, 2020 at 01:09:12AM +0200, Jann Horn wrote:
>>>>>> Currently, mm_struct has two refcounts:
...
> Either way can work, I liked the suggestion because it suggests an
> good name for the ref: 'mmget_pgd' or somesuch
> 
> What I don't like is how nonsensical the names here are becoming:
> mmget/mmgrab/mm_ref
> 
> Gives no impression at the callsite what is right/wrong
> 
> Names like this:
>   mmget_struct
>   mmget_pgd
>   mmget_tables
> 

What?! I had just resigned myself to a bimonthly exercise, re-memorizing
the mm_struct naming correlation between grab, drop, get, put, count,
and users. And now you want to make it directly understandable? :)

> Make alot more sense to me..
> 
> I think this patch needs to do something about the naming..
> 

A third counter also seems like the tipping point, to me.

thanks,
-- 
John Hubbard
NVIDIA
