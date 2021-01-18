Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812B42F9CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbhARKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:15:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389339AbhARJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610963442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6zQEH2ZgVft/o+0qtfsDU1QY8mzvxQi41Uv+5hZEWU=;
        b=Ot9+rl+XUWus/3iOMAzxxdeBr+XrZz2M6JjzaliG/PZmHHLJS7mW7G7a9lLsqVDuIjkdGV
        OUqXzXYkWC7KU79G8uRHyS+kIpt6n+flaTgUAafABzEQ+nckNdQ/66SKHdni/d9ej//EMF
        Ots3ewtz0V3oBA7jg/gef32Ps1WzbC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-VFNe5a4uOOW0EqXpWP48zw-1; Mon, 18 Jan 2021 04:50:39 -0500
X-MC-Unique: VFNe5a4uOOW0EqXpWP48zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45C17107ACE4;
        Mon, 18 Jan 2021 09:50:36 +0000 (UTC)
Received: from [10.36.112.158] (ovpn-112-158.ams2.redhat.com [10.36.112.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABDAB5B699;
        Mon, 18 Jan 2021 09:50:27 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Make it possible to reserve memory on 64bit
 platform
To:     "zhaowei1102@thundersoft.com" <zhaowei1102@thundersoft.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kerneldev <kerneldev@karsmulder.nl>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        gpiccoli <gpiccoli@canonical.com>, aquini <aquini@redhat.com>,
        gustavoars <gustavoars@kernel.org>, ojeda <ojeda@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        guohanjun <guohanjun@huawei.com>,
        mchehab+huawei <mchehab+huawei@kernel.org>
References: <1610793673-64008-1-git-send-email-zhaowei1102@thundersoft.com>
 <CAPcyv4hGu3r=m+7Wkf3a94G=ZM4cQB87pt0ThadoUrk8cY7ovw@mail.gmail.com>
 <202101181151049299923@thundersoft.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <15269a61-3b16-4c07-2486-6940c559261e@redhat.com>
Date:   Mon, 18 Jan 2021 10:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <202101181151049299923@thundersoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.21 04:51, zhaowei1102@thundersoft.com wrote:
>     On Sat, Jan 16, 2021 at 2:43 AM Wesley Zhao
>     <zhaowei1102@thundersoft.com> wrote:
>     >>
>     >> I was trying to reserve some memory to save logs incase that
>     Android panic or hang and then
>     >> I can read the logs from QNX side from the memory reserved before
>     on the Qualcomm 8155 hypervisor platform,
>     >> and I find the "reserve=" parameter only support 32bit,so I made
>     some change and send these patches.
>     > 
>     >See Documentation/admin-guide/kernel-parameters.txt
>     > 
>     >        memmap=nn[KMG]$ss[KMG]
>     >                        [KNL,ACPI] Mark specific memory as reserved.
>     >                        Region of memory to be reserved is from ss
>     to ss+nn.
>     >                        Example: Exclude memory from
>     0x18690000-0x1869ffff
>     >                                 memmap=64K$0x18690000
>     >                                 or
>     >                                 memmap=0x10000$0x18690000
>     >                        Some bootloaders may need an escape character
>     >before '$',
>     >                        like Grub2, otherwise '$' and the following
>     number
>     >                        will be eaten.
>     Sorry，what is your point：
>      static int __init reserve_setup(char *str)
>      static struct resource reserve[MAXRESERVE];
>      for (;;) {
>      unsigned int io_start, io_num;*  // these code is not compatible
>     with 64bit，i start from here*
> 

Dan's point is that you should look into using "memmap=" instead of
"reserve=".

-- 
Thanks,

David / dhildenb

