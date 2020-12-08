Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4A2D3556
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgLHVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgLHVeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:34:10 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA49C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:33:23 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id i9so19208ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zdoQ9yJW9tTgrj6ngha5GHf9EI9TYgRrrDlU2gawLsk=;
        b=zvMHpPJu2d1u8/8TejNX0MesMmrN3FPXs5J3WEOOn6RSWpISqNdpekFsYkMdWWR91s
         eE1YddCBvNFv1fErpT/jUTa+M5+RTHY+RFn5jlZ1kj6E6HaiPKc4pgvJoofSytJFse+M
         GegJPeWNQHOd41OLTst4QJ0mfYVx46CJmkpDRcaf9QriSV86nha2hc0Baescb30h0rzv
         PW57A+a6bCTUyhxFVqe2VVglXsdVrGQ9hPu0HMxwEFHj6cBUsgc8He67JMY6P+NR2o+V
         swnsaSzjpIFQJfrCnw5v/CPgP4r6u96JwI0BkIRWgiwSkk2ey1QrfjzMjuSBDB5pBjkZ
         ljLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdoQ9yJW9tTgrj6ngha5GHf9EI9TYgRrrDlU2gawLsk=;
        b=JgRgx+mX8kcopirCkM9zoyv7ZRGh6QZDOMrcPq8Q+llewkegJfAr/3spLGJHIPz3fj
         O2l42J8yMsr2w3qCM7mDF7M4Ffsi6170mSN37OGzThNC/+o+gMGwrbKIjK70Y0iQPnwv
         LW2T5FzAshi7YTdTw0AnC1+gRYbxeSh/M9+FyAM1MGpeczymwk4M498a1eNs+dycHBwD
         6Iadh7gpjLt7bVO7vGP8MxVjOjlNJD3Z2u5/+qj+t1o/6WIlT/3GMj3UjuE+YN0DX3Ox
         u2sgQ7QVOQ3ZgTOcfpdGUvB2n1RmEq3VBf6Fi5gpsrxWr/L95x0tg/hSy63CIUwhWa2W
         b5Dw==
X-Gm-Message-State: AOAM533i+2z7Re/N/a7YBBNUgDtYCKMlgrlf8L0OCRsK2zeM6rNfHKJP
        f/eVoksFN9Qm4jt9AhbWOdMbEw==
X-Google-Smtp-Source: ABdhPJzQheY8hh+c2jPwntFjfV62RpaVDCD04oY7VjALdEnTr5RuNzE83IP/tjylmq1hCPS0rgIoTQ==
X-Received: by 2002:a5d:824b:: with SMTP id n11mr2322787ioo.27.1607463202778;
        Tue, 08 Dec 2020 13:33:22 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d18sm6383019ilo.49.2020.12.08.13.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 13:33:22 -0800 (PST)
Subject: Re: problem booting 5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nicolas.palix@univ-grenoble-alpes.fr,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
 <CAHk-=wi=R7uAoaVK9ewDPdCYDn1i3i19uoOzXEW5Nn8UV-1_AA@mail.gmail.com>
 <yq1sg8gunxy.fsf@ca-mkp.ca.oracle.com>
 <CAHk-=whThuW=OckyeH0rkJ5vbbbpJzMdt3YiMEE7Y5JuU1EkUQ@mail.gmail.com>
 <9106e994-bb4b-4148-1280-f08f71427420@huawei.com>
 <CAHk-=wjsWB612YA0OSpVPkzePxQWyqcSGDaY1-x3R2AgjOCqSQ@mail.gmail.com>
 <CAHk-=wi=Xs6K7-Yj83yoGr=z5fTw+=MUHrLpFJZ0FOeHA2fjuA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22f9a723-aaba-3a1b-b2bc-3f1d82840dd7@kernel.dk>
Date:   Tue, 8 Dec 2020 14:33:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi=Xs6K7-Yj83yoGr=z5fTw+=MUHrLpFJZ0FOeHA2fjuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 2:25 PM, Linus Torvalds wrote:
> [ Just re-sending with Jens added back - he's been on a couple of the
> emails, but wean't on this one. Sorry for the duplication ]

Don't think I was, but gmail shows me the rest of the thread now.

> On Tue, Dec 8, 2020 at 1:23 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Tue, Dec 8, 2020 at 1:14 PM John Garry <john.garry@huawei.com> wrote:
>>>
>>> JFYI, About "scsi: megaraid_sas: Added support for shared host tagset
>>> for cpuhotplug", we did have an issue reported here already from Qian
>>> about a boot hang:
>>
>> Hmm. That does sound like it might be it.
>>
>> At this point, the patches from Ming Lei seem to be a riskier approach
>> than perhaps just reverting the megaraid_sas change?
>>
>> It looks like those patches are queued up for 5.11, and we could
>> re-apply the megaraid_sas change then?
>>
>> Jens, comments?
>>
>> And Julia - if it's that thing, then a
>>
>>     git revert 103fbf8e4020
>>
>> would be the thing to test.

Ming's series is queued up for 5.11, so if the revert does show that
this is indeed the issue (and it sure looks like it), then I'd suggest
we simply revert this commit from 5.10 and we can revisit after the
merge window opens and Ming's patches are in anyway.

-- 
Jens Axboe

