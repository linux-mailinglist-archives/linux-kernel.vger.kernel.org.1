Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D52FFB77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAVEBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbhAVEBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:01:42 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDFDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:01:02 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 19so4035827qkh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 20:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=1tIJabc1LyxppDd66Pb8o22aRE8vx2uFHw0NvMZh4So=;
        b=u+bjP9qdmCD4i6/Wcwoz8XNp/lzUwTWw+xcv9gEhmWs0kho5GvcFJ7IhED7Y73AYNr
         WXGbKMVukTMJ7dnmKXIqYmIERfEJOH2dqi0zKCvIuOoo93wjbJryF43cqo8FO+ip1Ccu
         i/qkZqXkLuuuN0N/G9Y0mF8uB6pNbu+dM/lUdJjpQIY5ey/UjwdgfIvvR6HgouZtwDG9
         PmrEomjzgPID7X8MBtyR9hUj0U835i9Fs72WsGrXAAmFlwkb/HwFvECP9oDc3H8pGe95
         s/SpJhovodN2cROl7ZXGpq5mJu2yPRypf9fh+6LBqecwPtBJY2gwtkf48KUSLQwgVozO
         YiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=1tIJabc1LyxppDd66Pb8o22aRE8vx2uFHw0NvMZh4So=;
        b=RWa0NOin2sG8H6tg0qml/e41xlPvJe8LqVAY3nRKmjRlzpplxBmk23CQl22Fg9FsOf
         9PqhQOsVFKsIX0c1C6LDstEJJ9E5+q9YSVfPSGr07scYcOTiV5GZWcdcInexbLK2jd8K
         M8EAWdb7vgBgBkEDu3YnUF1DMPPCo5s0IQgmiGB4PbznyvlHYcD21kzZzow3xrAXWke5
         shCNDdHySrf4hXQLaHxKo31ZxNGcmUo0kxfH9J4P1m9V4gs2ebJOm/ryBWtBwd3L0t+t
         baUIYo6TuekLQeXPguQwY2rO+9ConARtVsP+v5IDfMA/fOZGXGqDOFnHMcSQlxun5SdB
         BZMw==
X-Gm-Message-State: AOAM530VU3JWfU2cUfMuS5TeCrxfjLuyY2sZUr+6i737hlEXsIrMbV7D
        cA2GNNVB0d1zFy6zIbiLxmo=
X-Google-Smtp-Source: ABdhPJz0BwrbFVCCavk0Zs1jfK8gy5rhAFJxFaTo2X8QMWOz/B5IczSUyam+0oMBTntZnvLOpNhSOw==
X-Received: by 2002:a37:2dc5:: with SMTP id t188mr3194667qkh.187.1611288061619;
        Thu, 21 Jan 2021 20:01:01 -0800 (PST)
Received: from OpenSuse ([156.146.54.15])
        by smtp.gmail.com with ESMTPSA id k23sm4999576qtp.61.2021.01.21.20.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 20:01:00 -0800 (PST)
Date:   Fri, 22 Jan 2021 09:30:53 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     torvalds@linux-foundation.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: LOL what a patch! change Linus to Linux
Message-ID: <YApN9caMUhd0McVD@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, torvalds@linux-foundation.org,
        masahiroy@kernel.org, linux-kernel@vger.kernel.org
References: <20210121143014.8913-1-unixbhaskar@gmail.com>
 <215566f1-b016-b42d-089f-bcf09240e9cf@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f6L3XGah/f0T10Mh"
Content-Disposition: inline
In-Reply-To: <215566f1-b016-b42d-089f-bcf09240e9cf@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f6L3XGah/f0T10Mh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:07 Thu 21 Jan 2021, Randy Dunlap wrote:
>On 1/21/21 6:30 AM, Bhaskar Chowdhury wrote:
>> s/Linus/Linux/
>>
>> ...how dare I?? :)
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>
>Hi,
>
>You missed a second occurrence of that a few lines later.

Indeed!

>However, it is correct as is. It means the kernel tree
>that Linus maintains -- sometimes known as mainline.

Aw...I am confused to the end , Randy...

Anyway...it trivial and its "not noticeable" , so we can ignore it.

>> ---
>>  scripts/patch-kernel | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/patch-kernel b/scripts/patch-kernel
>> index 033d5916797d..314e80c252c0 100755
>> --- a/scripts/patch-kernel
>> +++ b/scripts/patch-kernel
>> @@ -7,7 +7,7 @@
>>  # e.g.
>>  #   scripts/patch-kernel . ..
>>  #      Update the kernel tree in the current directory using patches in the
>> -#      directory above to the latest Linus kernel
>> +#      directory above to the latest Linux kernel
>>  #   scripts/patch-kernel . .. -ac
>>  #      Get the latest Linux kernel and patch it with the latest ac patch
>>  #   scripts/patch-kernel . .. 2.4.9
>> --
>> 2.30.0
>>
>
>
>--
>~Randy
>"He closes his eyes and drops the goggles.  You can't get hurt
>by looking at a bitmap.  Or can you?"
>(Neal Stephenson: Snow Crash)

--f6L3XGah/f0T10Mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAKTfIACgkQsjqdtxFL
KRUnMgf/ZRPTI/fHYhB08fzVVuZbQbFeEmgrvUK0P2v66YoRMLtE8xdDY78nLXaY
bjGxWPLwxPxaqFPd8btX5ahIqF6sJnffJkKWgNIOAYnibpLm4VDw95pxwytuis0y
Ny5k2c6QQ1eVZMyLPxJQCs8AP1XCptQr6KgASuUyeVp830H+pgMqwcc/hAgWl6q9
zHBbiw2oqN3ip0ie3W0GyezZuBfjPuov2AcDfPTkNnGtK/xmlaRfveBlXLp5GQLi
QQ80wa7Fw4+kEVCVibLBay6+TASnjqzEJnLhA+/JhWlUw2vk+cAA327NkRqs5YBP
fBA+D9ngHRqYO2Cy5D22zxNQZD+dCA==
=Ujwg
-----END PGP SIGNATURE-----

--f6L3XGah/f0T10Mh--
