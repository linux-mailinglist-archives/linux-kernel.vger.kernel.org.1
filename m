Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909FA2FF215
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbhAURgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:36:47 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:62572 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388287AbhAUREm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:04:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1611248608; x=1613840608;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YSQ8bIE/FqlREHebkRMC1psz35uHM7Hc1hMo8mYgJ/M=;
        b=eILpc1bOsJTiQLPJ/Fh697ksm6N8RJ179MsE9vQHGIsYPwj/QpA1bZA0NHHE4xOm
        qZoCiXD582ik0E0N3Gy0oF88mw7DW/zjf0F5MpV70VrIciJ540Dgywb0EQZskZBn
        mXRBsrySfmnEMsaXA4I8PdYDrV0RU4m6d9RKtgBlyRU=;
X-AuditID: c39127d2-0d3b770000001c86-30-6009b3e0f3ec
Received: from Florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 21.AA.07302.0E3B9006; Thu, 21 Jan 2021 18:03:28 +0100 (CET)
Received: from [172.16.21.73] (172.16.0.116) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 21 Jan
 2021 18:03:28 +0100
Subject: Re: Splicing to/from a tty
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oliver Giles <ohw.giles@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
References: <CAHk-=wiDX9K0aj6mQsQM54yyJTg2fkzME82aSswB2woFGmW81Q@mail.gmail.com>
 <C8NLE0OB4QWG.31VIPNC9SIDPG@oguc>
 <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
From:   Robert Karszniewicz <r.karszniewicz@phytec.de>
Message-ID: <54108069-3ef4-c02f-b824-d24da79e0009@phytec.de>
Date:   Thu, 21 Jan 2021 18:03:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj48Bdz6MPojis0ONMGO=0L+9bquD9e1_pGc4-et=uLbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.0.116]
X-ClientProxiedBy: Berlix.phytec.de (172.16.0.117) To Florix.phytec.de
 (172.16.0.118)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42JZI8BQpvtgM2eCwfltxhbNi9ezWaxcfZTJ
        4t1cGYvLu+awWfSu2shq8ajvLbvF+b/HWR3YPXbOusvusWlVJ5vHiRm/WTz2z13D7rH7ZgOb
        x+dNch6bnrxlCmCP4rJJSc3JLEst0rdL4MrY++opY8Fl1opTf56wNDBuZuli5OCQEDCRmDHJ
        pYuRi0NIYBmTROvSbiYI5z6jxLWN7exdjJwcwgLKEhO757GA2CICERJrzpxkByliFrjOKHHp
        +hQmkISQwG5GifMT4kFsNqCpu5tvMYPYvAI2EhMbf4E1swioSiy71sIKYosCDWrt64SqEZQ4
        OfMJWA2nQKDElF3tjCDXMQtoSqzfpQ8SZhYQl7j1ZD4ThC0vsf3tHGaItaoSp9teg8UlBBQk
        5v6eyAxhh0vcPrqWdQKj8CwkG2YhTJ2FZOosJFMXMLKsYhTKzUzOTi3KzNYryKgsSU3WS0nd
        xAiMp8MT1S/tYOyb43GIkYmD8RCjBAezkgjvI0uOBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        G3hLwoQE0hNLUrNTUwtSi2CyTBycUg2MiVMOXOZlbrsVZX9oYumVk8/+iczdW1sR+fS563HB
        si03AvNuVThPTfqg5GdTflpa8uw0Q+5bUjJhGUzzubuuZxjFvHmXHnBx046eOw8+LA71YE3K
        /rzS6LHfYv7z2ydbqx7WzLfvjqyRa4iS/24ROPWr282eNfasli/fyf/SUlrQKvTrckyFEktx
        RqKhFnNRcSIAu3KPt5UCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/21 5:44 AM, Linus Torvalds wrote:
> On Tue, Jan 19, 2021 at 5:29 PM Oliver Giles <ohw.giles@gmail.com> wrote:
>>
>> Writing this from a kernel with those patches in; happily splice()ing
>> to and from a pty.
> 
> Ok, good.
> 
> I have a couple of improvement patches on top of those, that I'm attaching here.
> 
> [...]
> 
> But in the meantime, here's two more patches to try on top of the
> previous four. They shouldn't matter, other than making the non-icanon
> throughput a lot better. But the more coverage they get, the happier
> I'll be.

I confirm that the 4 patches, as well as the 4+2 patches, fix the regression I
noticed with cat failing on sendfile() to ttymxc0.

Thanks,
Robert
