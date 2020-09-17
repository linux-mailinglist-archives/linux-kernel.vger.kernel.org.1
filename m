Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9126DC40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgIQM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgIQM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:58:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4714C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:58:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so3125838ejl.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AsrkYaB5f4BSz50/ihxdxwFEMXRJcXp75/PCDEQiMy0=;
        b=Vf2xa4k9S0nQtTV7MnWa+2vLfMHqsZaqn6ux5O0gP30Ws/pxXeyWKFfJR7hMISvSyl
         ZbTQzn+a124uP5Pdl53Ex3EN964qbGCdcUJLlh6+btTFNiVl01BeF+vdsxLbpDj04zPf
         K/rsEASYKoAYDuE5aWIsnAcMaRJGlEpDuo9qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AsrkYaB5f4BSz50/ihxdxwFEMXRJcXp75/PCDEQiMy0=;
        b=J9J+1gDkqztpoT1D02Q9nv7Mm7KlmKAgMmHt/Kq9e1KgoJ8WG/nNCXM9a10s0UrdZI
         n+Ke0WMViaN1/lKKWdcs4EuDKBz1MGJmOQ81TGOYm1VhyuWHC1HkRz4QCsQsuERYyWuA
         lE+6bZB6HPQpJdSlMboaL3Jz7pQw/jy+adNzPflw3nQJltcaK29vU5tcJ5jlHO0ATJrH
         qh1YpWY73LFSnTmXV8psSMqVlH9qXlsjR0ffrK2Z7+rVrcX0X4Q7LIVZZ2/oU1pbe8fs
         Q6642PBLv+cM88iUl3mzl2PbAsCz0niG36j+uoXDxu8cWBkkFAZ1l/0ZcA9/I+UmgeBB
         iXGw==
X-Gm-Message-State: AOAM530u2Y3OKLtN8MR1aWs3lwA1tH3NyxXQ15m7YOS0bfIcWKdPqsps
        bABNhZuj9Zl5LR7rZiPeCo71cSqoXsELjeNtuTA=
X-Google-Smtp-Source: ABdhPJwFfxv/px4vSMgha1IlklyB3BoTv0/kUJK0Vp6D+D5NpthMfhhVniG2TrfRSuxcaVbyIpGh+w==
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr29705331ejf.97.1600347514058;
        Thu, 17 Sep 2020 05:58:34 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t12sm16963758edy.61.2020.09.17.05.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 05:58:33 -0700 (PDT)
Subject: Re: [PATCH v2] scripts/setlocalversion: make git describe output more
 reliable
To:     Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <20200917065615.18843-1-linux@rasmusvillemoes.dk>
 <87pn6k384e.fsf@ungleich.ch>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <73cb82c5-37fd-7fa3-5778-723337934a2b@rasmusvillemoes.dk>
Date:   Thu, 17 Sep 2020 14:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn6k384e.fsf@ungleich.ch>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2020 14.22, Nico Schottelius wrote:
> 
> Thanks for the patch Rasmus. Overall it looks good to me, be aligned to
> the stable patch submission rules makes sense. A tiny thing though:
> 
> I did not calculate the exact collision probability with 12 characters

For reference, the math is something like this: Consider a repo with N+1
objects. We look at one specific object (for setlocalversion its the
head commit being built, for the stable rules its whatever particular
commit one is interested in for backporting), and want to know the
probability that its sha1 collides with some other object in the first b
bits (here b=48). Assuming the sha1s are independent and uniformly
distributed, the probability of not colliding with one specific other
commit is x=1-1/2^b, and the probability of not colliding with any of
the other N commits is x^N, making the probability of a collision 1-x^N
= (1-x)(1+x+x^2+...+x^{N-1}). Now the N terms in the second factor are
very-close-to-but-slightly-smaller-than 1, so an upper bound for this
probability is (1-x)N = N/2^b, which is also what one would naively
expect. [This estimate is always valid, but it becomes a void statement
of "the probability is less then 1" when N is >= 2^b].

So, assuming some vendor kernel repo that has all of Greg's stable.git
(around 10M objects I think) and another 10M objects because random
vendor, that works out to 20e6/2^48 = 7.1e-8, 71 ppb.

> So I suggest you introduce something on the line of:
> 
> ...
> num_chars=12
> ...
> --abbrev=$num_chars

I considered that, but it becomes quite ugly since it needs to get into
the awk script (as a 13, though perhaps we could get awk to do the +1, I
don't really speak awk), where we'd then need to use " instead of ' and
then escape the $ that are to be interpreted by awk and not the shell.
So I think it's more readable with hardcoding and comments explaining
why they are there; should anyone ever want to change 12.

Rasmus
