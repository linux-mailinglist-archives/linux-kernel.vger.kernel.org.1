Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3322FBD45
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391086AbhASROA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:14:00 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:60038 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbhASRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1611075410; x=1613667410;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=71NL4qRxuCfKGxdVRCYWEgQ0RQvvYiTQUe2PM7pdqG4=;
        b=VISOOmQu0zxUhdVN4y++vSb4maQiOseEQKt3HSOEPyExJnFk4E8OsDJ9qreg8XK6
        WWCmIViH0bjUxDHrGzoSQpbwkTZXpGZpwfhXK3WBruWWXDFATbB52Ud7K43MLBXj
        po+WLbpqPw4EMk+Ol00z+VprBy/Ek8WkCsRxbL8tviI=;
X-AuditID: c39127d2-0c7b670000001c86-e2-60070f520b77
Received: from Florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F9.90.07302.25F07006; Tue, 19 Jan 2021 17:56:50 +0100 (CET)
Received: from [172.16.21.73] (172.16.0.116) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 19 Jan
 2021 17:56:49 +0100
Subject: Re: Splicing to/from a tty
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <20210118081615.GA1397@lst.de>
 <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
 <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com>
 <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
 <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
 <CAHk-=wg-1gntaB4xTAsQhvxumOeB_36sFdpVCWgZGLnCUQGUvw@mail.gmail.com>
 <CAHk-=wjgufiORSuAb270XpGn45jexRjP9SCmcc7AAAZsVrAaPw@mail.gmail.com>
 <CAHk-=whW7t=3B=iCwYkJ3W-FH08wZNCFO7EJ5qQSqD9Z_tBxrQ@mail.gmail.com>
 <YAbIVgGt1Qz8ItMh@kroah.com>
From:   Robert Karszniewicz <r.karszniewicz@phytec.de>
Message-ID: <9d3baff9-5d4a-4308-9556-8dd037c2fe4b@phytec.de>
Date:   Tue, 19 Jan 2021 17:56:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YAbIVgGt1Qz8ItMh@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.0.116]
X-ClientProxiedBy: Florix.phytec.de (172.16.0.118) To Florix.phytec.de
 (172.16.0.118)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42JZI8BQphvEz55gcGw7v0Xz4vVsFitXH2Wy
        eDdXxuLyrjlsFr2rNrJaPOp7y25x/u9xVgd2j52z7rJ7bFrVyeZxYsZvFo/9c9ewe+y+2cDm
        8XmTnMemJ2+ZAtijuGxSUnMyy1KL9O0SuDJaD99kLXjNUfFlknsDYy97FyMnh4SAicTee4+B
        bC4OIYFlTBIreo8wQjj3GSX27D0IViUsoCwxsXseSxcjB4eIQKrE/p3VIDXMAqcYJe43zWGG
        aLjDInHqwUZGkAY2oLG7m28xgzTwCthIrN5mBhJmEVCV+NHwFqxEVCBCorWvkxnE5hUQlDg5
        8wkLiM0poClx4/h+RpBWZiB7/S59kDCzgLjErSfzmSBseYntb+eAtQoBjTzd9poJ4hkFibm/
        JzJD2OES837PYp/AKDwLyYZZCFNnIZk6C8nUBYwsqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzEC
        o+nwRPVLOxj75ngcYmTiYDzEKMHBrCTC2/SXLUGINyWxsiq1KD++qDQntfgQozQHi5I47wbe
        kjAhgfTEktTs1NSC1CKYLBMHp1QD48zkzMd/lWdessyepeJnpcnj+o5ponjq7cqK38d8I1pk
        p0iy6aTee1zE8lWaj2fC/gie9dmPtCROWs35eOPSS+l6voq9Qc4h0pMlNi7a7rh69dSr0a6x
        d1fdy8tRW7dV6JDMs95p+fIPD/3aN1tz+YpL9rKTkiY8YxRdcGL32dvOQpuVJO/uvKTEUpyR
        aKjFXFScCAAtX8R2lAIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 12:53 PM, Greg Kroah-Hartman wrote:
> This looks sane, but I'm still missing what the goal of this is here.
> It's nice from a "don't make the ldisc do the userspace copy", point of
> view, but what is the next step in order to tie that into splice?
> 
> I ask as I also have reports that sysfs binary files are now failing for
> this same reason, so I need to make the same change for them and it's
> not excatly obvious what to do:
> 	https://lore.kernel.org/r/1adf9aa4-ed7e-8f05-a354-57419d61ec18@codeaurora.org

I would like to confirm this. We are using firmwared and it returns EINVAL on
sendfile(), too. I have tried setting the .splice_write callback as in the
linked thread, but it didn't help, it just EINVAL'd in a different place.

I have bisected this issue down to this commit:
4d03e3cc5982 ("fs: don't allow kernel reads and writes without iter ops")

Another case I've also noticed is writing to a serial connection:
kernel write not supported for file /ttymxc0 (pid: 252 comm: cat)

(Which still prints, though, because cat falls back to write(2), I suppose.)

Thank you,
Robert
