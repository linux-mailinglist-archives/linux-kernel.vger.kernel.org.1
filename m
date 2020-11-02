Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB902A33FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKBTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:23:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC0BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YxYFom0k6rdPSSmO9MlWhfUlvTlgAkTiwPO/aueoM7g=; b=mLzHpxvMm6cWLE0qOHVik0IpDe
        93LYq1jqsvOQurKGodeCXdCJDvwXDHjupQl0jHAN7ZBBqbyO3souguUQXyfLLhCHOp/GrpfvIDqkG
        7wm1KNLxBY/PlqyI/TfArRw0l12WXaR5Z8b6gGKfy5Yg23krutttwFIwN5vnc061k/FJTYX1srMG9
        DxAXUHUkcF2Ce1QtX7NEyBYSzqbrBBtvtMKwL6FO0TtGaBjm6cQAbHUyf5oYJ7FCTvJhO5ZVZ3mBC
        Usnm897cIGm2qdGo7AxVoy6Ko0DHF26yJdUmEixHorJT0h27WVKDINUUvfOYcSNfxlrkqLAFj75G7
        p0xp+X1Q==;
Received: from [2601:1c0:6280:3f0::60d5]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZfQP-0000kU-7Q; Mon, 02 Nov 2020 19:23:29 +0000
Subject: Re: Linux 5.10-rc2 (docs build)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
 <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
 <20201102085841.5490f6da@coco.lan> <20201102093305.34ba4ff5@coco.lan>
 <d9b5a400-0dbb-3be8-66f2-f629ffe4a6b8@infradead.org>
 <20201102175922.4ed74e7a@coco.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4a538b19-2bfd-5c7c-047c-7ed4292b89c8@infradead.org>
Date:   Mon, 2 Nov 2020 11:23:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102175922.4ed74e7a@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 8:59 AM, Mauro Carvalho Chehab wrote:
> Em Mon, 2 Nov 2020 08:02:34 -0800
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
>> On 11/2/20 12:33 AM, Mauro Carvalho Chehab wrote:
>>> Em Mon, 2 Nov 2020 08:58:41 +0100
>>> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
>>>   
>>>> Hi Randy,
>>>>
>>>> Em Sun, 1 Nov 2020 16:01:54 -0800
>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>>>  
>>>>> Something broke the docs build (SEVERE):
>>>>>
>>>>>
>>>>> Sphinx parallel build error:
>>>>> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:
>>>>>
>>>>> Attributes Common for All RapidIO Devices
>>>>> -----------------------------------------
>>>>>
>>>>>  
>>>>
>>>> On what tree did you notice this? Linux-next or upstream?  
>>
>> See $Subject:  5.10-rc2
>>
>>
>>> Also: on what Sphinx version are you getting it? I'm not
>>> able to reproduce the issue here, neither with Sphinx 2.4.4
>>> nor with Sphinx 3.2.1.  
>>
>> That could be one source of the problem:  ;)
>>
>> from my docs build:
>>
>> Sphinx version: 1.7.6
>> Warning: It is recommended at least Sphinx version 1.7.9.
>>          If you want pdf, you need at least 2.4.4.
> 
> Could be... From 1.7.6 to 1.7.9, there were bug fixes ;-)
> 
> Also, on Sphinx, they stop maintaining old versions once newer
> stable ones are launched. So, any bug on 1.7.x (up to 3.2.x) will
> remain unfixed[1].
> 
> In any case, could you please check if this patch solves the
> issue?
> 
> 	https://lore.kernel.org/lkml/6c62ef5c01d39dee8d891f8390c816d2a889670a.1604312590.git.mchehab+huawei@kernel.org/

Nope, sorry, with that patch applied to v5.10-rc2, I get:

reading sources... [ 93%] userspace-api/media/v4l/pixfmt-y8i .. userspace-api/media/v4l/vidioc-querybuf
reading sources... [ 96%] userspace-api/media/v4l/vidioc-querycap .. vm/transhuge
reading sources... [100%] vm/unevictable-lru .. xtensa/mmu

waiting for workers...

{hangs; enter ^C}

Sphinx parallel build error:
docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-class-led-trigger-pattern.orig:16: (SEVERE/4) Unexpected section title.


-- 
~Randy

