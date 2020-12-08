Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4AB2D369C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbgLHXAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbgLHXAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:00:43 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:00:03 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id m9so13630068pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 15:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cvX4Xg5ko6vGqIjHH66x4K4QBryzq3vXXA2jw9y8g7s=;
        b=GXND6WILUV13nGMPNsvyp3jDZl5GKURlUac6Fy1bWTowxbY6/Ty0LYcGcMZDExzJzr
         jz+hOI6q4ic3GN++qDpJy+Fj4YhKRMPpCJe920iDoJHNphm5pCxN3ym3xSumCeNvDQ73
         u9pjeY3qFpUiDo1XjFmBspf2nCeUJf6ErndeVw4gJjsORB7bqbBWy90BfgparUJ2c8xD
         cASwGT1bnldPaDRKzHNx3UWARJ4KIyoBm1jxwrmJjsvlimHeV3We98PobuR/oyqaAOKd
         WN4I+WsC//jShMx6S+Wax8hy98aONzhoqXoaq/JOpYGDwMS0zgffzHFeX3mMV0bIdF5P
         zOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cvX4Xg5ko6vGqIjHH66x4K4QBryzq3vXXA2jw9y8g7s=;
        b=lwVi0eZ2u5Sl2hbnwjmwaru6vH0WnD3WmGSrs6tUDadxmKX+j8iCYN0FLsRhKo07yg
         YVn3OIpvdmfdPDfBF11OAqFlW3PuzpWHlz2cFo66luBz2xnFfa3VN31M4iq1PE0YSBk4
         NZBdpI08pEX5LMWA41fbStN1M40GIq5C6XPre1pHZe9qPgYrMx4N6WZw6lA0z1HxSYul
         A7xCA7QnH+Bwe+J9AUpcWb8I4hmtrEOX3fDgFfTnZPa1d9KE+Xx9av0WDsdqo4f3hapc
         9a3wM6p9hbHWOIGKmogdG9ocr6bQmHGF5xPTI2796llbHFlGZwppmyrDWuNWKCtt4I11
         TYyw==
X-Gm-Message-State: AOAM5307nfueh8b4fi3UV+TaGj20Bq1r9TDw2oCC1d6BiTy08M1Ds21O
        1gPgL4uSsB+AirCcCwETgaTfnA==
X-Google-Smtp-Source: ABdhPJxp2R1oGJVXiZr63+jfMbon4n0SOZ/r/L2AlBnsAR7h5DkJcSKPLsOYmbePi+uRVkaf/tfpLA==
X-Received: by 2002:a65:68da:: with SMTP id k26mr260441pgt.303.1607468403277;
        Tue, 08 Dec 2020 15:00:03 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 125sm225182pfy.111.2020.12.08.15.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 15:00:02 -0800 (PST)
Subject: Re: problem booting 5.10
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        John Garry <john.garry@huawei.com>,
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
 <alpine.DEB.2.22.394.2012082339470.16458@hadrien>
 <ca63ada5-76a6-dae9-e759-838386831f83@kernel.dk>
 <yq1mtynud0n.fsf@ca-mkp.ca.oracle.com>
 <CAHk-=whCChtPRmGZqZM8XeCAFhfRzX8ts4RFKeXgGUyuNtWGMQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1364ec02-bfae-328e-8f55-14ac953dd30d@kernel.dk>
Date:   Tue, 8 Dec 2020 16:00:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whCChtPRmGZqZM8XeCAFhfRzX8ts4RFKeXgGUyuNtWGMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 3:56 PM, Linus Torvalds wrote:
> On Tue, Dec 8, 2020 at 2:54 PM Martin K. Petersen
> <martin.petersen@oracle.com> wrote:
>>
>> Oh, I just realized the megaraid patch went in through block.
> 
> I'll take this as an "ack" for the revert, though ;)

You can add mine too, if you wish.

We'll follow up in 5.11 time once the other fixes have landed.

-- 
Jens Axboe

