Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6D2E6C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgL1Wze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbgL1Td6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:33:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC47CC061796
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:33:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k10so323893wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z0KfyjgxJTuJfSURWXlwLwsumCTCv+/5+ZkyQAaU7PI=;
        b=XqRyu90NuceEFpT6tF4NofE7WRFm5S3LNywInKKEKjCvkAJwNJtodtyAoxTGiupGV4
         ujY+V7ODzTVsylv5MWG8aDK8q/m0q3kHPylzv0UqLa3BFEHg4PUmj1uguOzJdn35mgCw
         TFfm4xM4ea+wswAn2AxCTN2ZLSfYz8ykCkYzVluX81LRQ9yaeWZxltVh63xf18Wvh6lq
         NItTquO1MNg3t1ihf9tuLZoYemAG6CNhK0QUpH8T0SPAX/3figPG18UWDj5zahAH1YRE
         1lbt5QJF0JpxWgdZ5uZyaIWYfxnGl3e+wMsIAkMFbHd2pd3+qnqSQkmk66JxeijJWKnn
         kUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z0KfyjgxJTuJfSURWXlwLwsumCTCv+/5+ZkyQAaU7PI=;
        b=aJRwLu13Oa3WfYmWuUYnkD7AUw197oKiJB/FuPHeP7LYzNgl0bVpDJcAl8x2dg1tNz
         +3RqFfYDKOvvtT0QuQdOZ0JkOXQm41fvFFXl02TvSyxN/UWaX5AamVlP4cSElb0RrOJM
         ZhzvWhBBxZ7XyQJVkyXBAEpx5YU8RAJHt8oxOFmuN9buEJFF2PILL6NQOX5I8jY0B0Pv
         miyiNL8Ewg50O5cwB1doJhTAvQMNc/sTr53DRXIm9/Kt6R9L+vLXyWNGO3z/wuwAZS7s
         rhDyWIdsX3Nm61ixTFUnwr+nZ5xh5tB0WHeNcjHpz2B9m48x3MiGIDIKy2ARpKeIP0LD
         YyTQ==
X-Gm-Message-State: AOAM532ZdG0m4jScZNZ8o3XXm/xKH9QkrQhAY7Jbdij+hq82ViGAFCjL
        HO33c34NiUQhpDMMXdBQt3iAMw==
X-Google-Smtp-Source: ABdhPJyQK/aP+EZvb8UjoNqqqOAM87tRgF0AgpxqbYLmb4xZC4WpszLjUmL76sYOJz4uZq4VYyhiTg==
X-Received: by 2002:a1c:e142:: with SMTP id y63mr397332wmg.28.1609183995440;
        Mon, 28 Dec 2020 11:33:15 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i18sm58308624wrp.74.2020.12.28.11.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 11:33:14 -0800 (PST)
Subject: Re: [PATCH 3/6] mremap: Don't allow MREMAP_DONTUNMAP on
 special_mappings and aio
To:     Brian Geffon <bgeffon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20201013013416.390574-1-dima@arista.com>
 <20201013013416.390574-4-dima@arista.com>
 <CADyq12ww2SB=x16pdH4LBZJJxMakOWgkR0qX-maUe-RzYZ491Q@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <d5d608ba-a25c-d3a2-b0f4-c97437a6dab1@arista.com>
Date:   Mon, 28 Dec 2020 19:33:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CADyq12ww2SB=x16pdH4LBZJJxMakOWgkR0qX-maUe-RzYZ491Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I moved your reply to avoid top-posting]

On 12/28/20 6:03 PM, Brian Geffon wrote:
> On Mon, Oct 12, 2020 at 6:34 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> As kernel expect to see only one of such mappings, any further
>> operations on the VMA-copy may be unexpected by the kernel.
>> Maybe it's being on the safe side, but there doesn't seem to be any
>> expected use-case for this, so restrict it now.
>>
>> Fixes: commit e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>
> I don't think this situation can ever happen MREMAP_DONTUNMAP is
> already restricted to anonymous mappings (defined as not having
> vm_ops) and vma_to_resize checks that the mapping is anonymous before
> move_vma is called.

I've looked again now, I think it is possible. One can call
MREMAP_DONTUNMAP without MREMAP_FIXED and without resizing. So that the
old VMA is copied at some free address.

The calltrace would be: mremap()=>move_vma()
[under if (flags & MREMAP_MAYMOVE)].

On the other side I agree with you that the fix could have been better
if I realized the semantics that MREMAP_DONTUNMAP should only work with
anonymous mappings.

Probably, a better fix would be to move
:       if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
:                       vma->vm_flags & VM_SHARED))
:               return ERR_PTR(-EINVAL);

from vma_to_resize() into the mremap() syscall directly.
What do you think?

-- 
          Dima
