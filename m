Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70D2A2EE7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKBQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKBQCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:02:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE6C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FZVtma3n8E4bb7rAojTw9/pPQKn1FVPxf1w3fAzgttM=; b=wn/0WcuGCT0swcAAazeeJL2/e0
        F2XO8OJiUrZLrZb0aYn9r3jsgGqelc08qow7yebML96+2Kbb3P+gUq6SnOY5+R67FDfYPcuHT1fPh
        DPwY2WINZmCocCgbJ86OdRrsU5tNsN54m0hCxOiTmhaeEecZaI/xdCQ9718mvqj7GmZRprQijA6G+
        HsDuVvIb4AZYEo9a9u2QxhLbzmXAgXPmGLiUv3D/kkYNRvwA+1IXdkiFmtJ+AXYVlC7EKHamyqC/b
        7lfYRe+SR81LmlOpvEfLBGd1sUMW9oRElDFeyrQecJIAdCCj9PL4v8QWgUmqSZXs0BZN8mPScGb0g
        ZiHHGYUA==;
Received: from [2601:1c0:6280:3f0::60d5]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZcI1-0006Hs-OE; Mon, 02 Nov 2020 16:02:38 +0000
Subject: Re: Linux 5.10-rc2 (docs build)
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
 <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
 <20201102085841.5490f6da@coco.lan> <20201102093305.34ba4ff5@coco.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d9b5a400-0dbb-3be8-66f2-f629ffe4a6b8@infradead.org>
Date:   Mon, 2 Nov 2020 08:02:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102093305.34ba4ff5@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 12:33 AM, Mauro Carvalho Chehab wrote:
> Em Mon, 2 Nov 2020 08:58:41 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> 
>> Hi Randy,
>>
>> Em Sun, 1 Nov 2020 16:01:54 -0800
>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>
>>> Something broke the docs build (SEVERE):
>>>
>>>
>>> Sphinx parallel build error:
>>> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:
>>>
>>> Attributes Common for All RapidIO Devices
>>> -----------------------------------------
>>>
>>>
>>
>> On what tree did you notice this? Linux-next or upstream?

See $Subject:  5.10-rc2


> Also: on what Sphinx version are you getting it? I'm not
> able to reproduce the issue here, neither with Sphinx 2.4.4
> nor with Sphinx 3.2.1.

That could be one source of the problem:  ;)

from my docs build:

Sphinx version: 1.7.6
Warning: It is recommended at least Sphinx version 1.7.9.
         If you want pdf, you need at least 2.4.4.
Note: It is recommended at least Sphinx version 2.4.4 if you need PDF support.


> (building against next-20201102 and against 5.10-rc2)


Someone might want to update Documentation/process/changes.rst:
Sphinx\ [#f1]_	       1.3		sphinx-build --version

Documentation/doc-guide/sphinx.rst also says minimal version is 1.3
but then goes on to discuss other versions. It's a bit of a mess.


thanks.
-- 
~Randy

