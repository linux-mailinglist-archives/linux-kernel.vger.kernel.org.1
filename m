Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47D32CADB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbgLAUqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgLAUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:46:34 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC0C0613D6;
        Tue,  1 Dec 2020 12:45:45 -0800 (PST)
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kkCWq-0002fK-AY; Tue, 01 Dec 2020 21:45:40 +0100
To:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
References: <cover.1606137108.git.linux@leemhuis.info>
 <c07e51e153f453c83c77a75513ad3d5ec70ef1be.1606137108.git.linux@leemhuis.info>
 <20201124091852.GB11695@lst.de>
 <04eae024-811d-d11e-b8bd-52f0dd0e225f@leemhuis.info>
 <20201124093658.GA13174@lst.de>
 <e424e24f-08d3-0b83-3d5b-ac500c753792@leemhuis.info>
 <20201124121109.GY4327@casper.infradead.org>
 <20201130075137.3b551bef@lwn.net> <20201201144314.GA14256@lst.de>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v3 1/3] LICENSES: Add the CC-BY-4.0 license
Message-ID: <8ef49ddf-e64f-d09b-9d31-9f64c89b6efb@leemhuis.info>
Date:   Tue, 1 Dec 2020 21:45:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201144314.GA14256@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1606855546;f0a041f6;
X-HE-SMSGID: 1kkCWq-0002fK-AY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.12.20 um 15:43 schrieb Christoph Hellwig:
> On Mon, Nov 30, 2020 at 07:51:37AM -0700, Jonathan Corbet wrote:

@Jonathan: thx for getting the ball rolling again!

>> We could also, if we saw fit, take the position that anything that has
>> been processed through the docs build is a derived product of the kernel
>> and must be GPL-licensed -

That position is totally fine for me (and in fact I think that's how 
things are in that area anyway, but I'm no licensing expect).

>> any dual-licensing would be stripped by that
>> act.  That, too, should address this concern, I think.

How to make this explicit? Right now the document I want to submit only 
mentions the license in a comment near the top. From a quick test with 
'make htmldocs' on f33 with sphinx-build 3.2.1 it seems comments are 
stripped during processing, so the license won't be visible in the 
processed document anyway. So I guess adding this as comment below the 
SPDX tag should be enough:

```

Note: Only the contents of this rst file as found in the Linux kernel 
sources are available under CC-BY-4.0, as processed versions might 
contain content taken from files that use a more restrictive license.

```


Or should we add something like this to a top-level documentation file 
to make it explicit for all of the documentation:

```
The processed Linux kernel documentation can be distributed under GPL 
v2.0; some of the files used to build the documentation are available 
under other licenses, check the Documentation/ directory in the Linux 
sources for details.
```

>> In general I'd rather see fewer licenses in Documentation/ than more.

Fully agreed, but I checked the existing licenses first and none of them 
afaics came even close to what I'd prefer to see (maybe MIT does, but 
I'm not really sure).

>>  But
>> Thorsten has put a lot of effort into this work; if he wants to
>> dual-license it in this way, my inclination is to accommodate him.

Thx for your support.

>>  But
>> that requires getting CC-BY-4.0 accepted into the LICENSES directory.
>> (That said, I believe it should go into LICENSES/dual/ rather than
>> preferred/).
> I agree with everything said above.

Fine with me also, but I guess I need a little help here. The files that 
currently resist in that directory all contain this near the top:

```
Do NOT use. The Apache-2.0 is not GPL2 compatible. It may only be used 
for dual-licensed files where the other license is GPL2 compatible. If 
you end up using this it MUST be used together with a GPL2 compatible 
license using "OR".
```

CC-BY-4.0 is GPL2 compatible afaik, so what do I write instead? 
Something like this?

```
Do NOT use for code, but it's acceptable for content like artwork or 
documentation. When using it for the latter, it's best to use it 
together with a GPL2 compatible license using "OR", as processed 
CC-BY-4.0 document might include content taken from more restrictive 
licenses.
```

Do we need more? Something like this maybe: "That's also why you might 
want to point that risk out in a comment near the SPDX tag." Or is that 
too much?

Ciao, Thorsten
