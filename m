Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79642E774F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 10:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgL3JHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 04:07:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:42419 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgL3JHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 04:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609319125;
        bh=/iVr2FmBvoZtQb2odCUPcAtj++Ggz3p0dYfm6gAVIfA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DlMZptsKVbvYqJCJkpnAcY8eQrFVULRUSB9Jq5omwTlVsFViV45my1Ng3bszfQ0vR
         d+fEUa3CCsBT8RajRi8J4A8/kTmWQaW52v7d2UAFgX4As0VwWiEMSjpJyKJhzb35Dz
         6Ql/coGx1NbKA86aaihLWqn7YaWJLvaz9yChd5RM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.0.117.198]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1kjJHu0UJT-00Cwnt; Wed, 30
 Dec 2020 10:05:25 +0100
Subject: Re: [PATCH -mm] mm: readahead: apply a default readahead size
To:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org
References: <20201229212634.31307-1-rdunlap@infradead.org>
 <20201229222311.GD28221@casper.infradead.org>
 <ec3030fd-d549-99cf-fe47-703b1fbd678d@infradead.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Message-ID: <361416d6-756d-e652-224d-03b56934030a@gmx.de>
Date:   Wed, 30 Dec 2020 10:05:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ec3030fd-d549-99cf-fe47-703b1fbd678d@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4tvt0vQXe12p2NCxpHTEehS7oVbQVxsoZv7anwFNP90bZMIT20I
 ag7ZVJwdXh5fU3ZCnitCjRPx5+rQM2BZiS6dLh0DoO5MefY5phlUJE+I1FgwBW//0u8Fnh8
 CymuGxF9KoEI4foSvGQZyUnAaOyopo9o/bFUgDu1T71D4nfNebNjqNtKCQOnNKK8AqTeQcH
 eAu0BCdCbFMlSe4k4Uo3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KrnIvxq1HCk=:4LbKBSGaHNaLfaMH+oS8lq
 NODqTpdU+Qhj0O06hSkdbVyC/L+rtLvLbnrKvRqWsQDDgvl7MvefWKPmkEIthSzv1znyGWu+x
 /I38v02PCkjRtppVobbigw3z2jMyIlURqYmu7onSSaBTY41TLUChMpM+40yv4EfXS1g+CHdfQ
 NCPnBq9zZ5m0viE1fJi9FEyQFq8z6FuqNYMONonievvy2x390uOh0tWSfcJoLLYR9w3vJcksu
 uY5NpimWMC88aPGWsBhJCc0FkQNdtn3RvJOphAEl0zYKDxN8FfMnH4stslf5L6VFIH6hyMwUn
 RWcjRr9uOKmi9DBHVot3RzcePStOGp99bypjNsytMcqmZJeghK8bRSZfKpNzDFj3qRvJHSKHX
 AKKvCz6+xqPE//IbEMYxu4lU8yKCq7kIB7lioDLRElYyddhfBZmXtV/Qd1RKzHFzOglZ9gZHK
 iz51BO0vD3Pd9O7Z7t1BG/ZxYtEmDmuGYG/4lqQlzCAvOo3n12yuK3uEy6/BmV3jv8iPT28IM
 KJL//7i05XrlDxhovsCdHRf3l45Ce4C0OKwsddXHGSjR6pflwiT/ipws5LeT3GxGJAxsbuQ2N
 3d+kCzk3e09bwraaXk3428au6X6dfpYzYOB8p12B5eQ6wxDmDPI5Ytc5euWNl/a8l5a1Qum8E
 NQ1o4MZ/tTLsC9T2PKK+cFrgPtceMRA7EoGJM+hPDkzdfvdkM7wP8wrLgbTdkK8lKJvV/XEko
 EqmWHkHIp5bZcLW1mTayrgPWlq2zfdbAkFdZDGSGlr8/mOAGoHb3Dxqw2YgXVQZaO3g9aOMLI
 JBIlBxGMAGxBlJYkgxxXwM1gIhCCdAWrqEolXWX+BsgaQdU5mpxwutJXqHcKw2TTvIEUxyjaH
 swNPuT26rekE/EUCe0KQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 11:55 PM, Randy Dunlap wrote:
>> No, this is wrong.  'size' in this case is the size of the read.
>> And it's zero.  Is this fixed by commit
>> 3644e2d2dda78e21edd8f5415b6d7ab03f5f54f3
>>
> Toralf, can you test with 5.11-rc1 (or later)?
>
> thanks.

My plan was to apply that commit on top of the upcoming 5.10.4 and test
that, just waiting in moment for Greg to release the stable version.

=2D-
Toralf
