Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704E827AB22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgI1Jse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgI1Jse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:48:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D5AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:48:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t10so582518wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=16q9rit+4WBoRc0ek6UmtFaJOItBTQSzXZ9iG6eBeg4=;
        b=O+dgtCLVjCG39XZ+fXPWT4kgZqKhJr7foaITp/81079vQ3HRmsGbH+rocVJawRa4bg
         aiVU7ngVY5oyISLM+TiZbdeFbXOYT9qYMyzjhAbTLPJYjzCfW+f28FKyGgJdBd2pt7PD
         D+6nRe7CLqMKJcdbGVmQTBxNhyvGXuddHoCJxAwD8GaGQAoWT8TQQq9uMapbPAjucneO
         vIU0MRKVraOnTcQXc5KjOybFiGNUyuraecPaZ10I2vEmhujf/ybmo6NT2ZviFU9a8rqt
         RvfiFXW9yLE0vpo1jrIDd35GnpdW9S8ZeLHQHzQ1Q0uZUCkBO4LQnnR8N+PlLbgZJygl
         Soxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=16q9rit+4WBoRc0ek6UmtFaJOItBTQSzXZ9iG6eBeg4=;
        b=cleChBFk14w6nU7VTIA/3m4W8ophnLHNFYFwYLBAGAI8hVVNoEqD1xAVJaow5QvI7v
         UP8ULqkk5U292gTl2uPVTIb0KzNnXQciZxBQyZH/O//hzI/vaIZFx/pgaBu9EoOnBtcl
         RbnzoAFrUlIJxmQDCVGn3rezVHmlUafMsLndm4O4kTx8WPSbNFWkseMnuEMrh3ztfDwh
         QHb45DOnb1TggsP0P1t8J8gVKkJ+xxYfNcrsNuyCOFBXM3kkJTorW6bnJ7qe8mN19wFZ
         LqIMF3qWobx0ZWaKBPDxjOXCw0/7do8ZOF7OSVQ/JLOOcI1ysdScV4+1OSqik9eaTZSh
         ravg==
X-Gm-Message-State: AOAM530E3J3wZitua7LiUgaYc2doyr4CY7ioqxSyitpeuJNmQEP/s4fo
        OwA+YJk3wp66UdQU1fVSRuMIgGO5rOs=
X-Google-Smtp-Source: ABdhPJxwQASGRVmv2uypnYFzaV/GzIeqOgPyXMr9Q8o82OwDkQhw9IuaJZaTq6HITobGv2HGYNd5pw==
X-Received: by 2002:a5d:4b86:: with SMTP id b6mr711980wrt.173.1601286512585;
        Mon, 28 Sep 2020 02:48:32 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.60.68])
        by smtp.gmail.com with ESMTPSA id k8sm726126wrl.42.2020.09.28.02.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 02:48:32 -0700 (PDT)
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Subject: Glibc may provide a safe nitems(), and also __must_be_array()
Message-ID: <71c25cb0-9fa2-4e97-c93c-44eadfd781fb@gmail.com>
Date:   Mon, 28 Sep 2020 11:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

I have a few related questions about the kernel.
I have never written kernel code, so maybe you have some configuration
that I don't know, but I've seen a few things that look a bit weird.

1)

The kernel has ARRAY_SIZE() in <linux/kernel.h>,
but still a lot of files either use the raw sizeof division, or
define a simple ARRAY_SIZE() (sometimes with that name,
and sometimes with a different name) without using __must_be_array()
(and therefore being unsafe).

Is there any reason for any of those files to not use the definition in
<linux/kernel.h>, or should all of them be fixed to use it?

2)

Glibc may provide __must_be_array() in the near future.
I designed it so that it should be 100% compatible with the one in
<linux/compiler.h>.  It will be provided in <sys/param.h>.

I'd add a
#if !defined(__must_be_array) [...] #endif
enclosing its definition in <linux/compiler.h>,
to avoid possible redefinitions.

3)

Does the kernel always compile against glibc?

If that's the case, the kernel could include <sys/param.h> to get the
definitions of __must_be_array() and nitems(), couldn't it
(if/when they merge the patch I sent, of course)?

If not, I'd like to know which other libraries are possible, and I'd
like to patch them to also have nitems() and __must_be_array().

4)

I'd like to know your thoughts about the following macro for getting
array sizes in bytes safely:

#define array_bytes(arr) (sizeof(arr) + __must_be_array(arr))

I already have a patch prepared for glibc, in case they merge nitems().

It would help get rid once and for all of a whole class of bugs,
and at the same time allow for the sintactic sugar of
arrays in function parameters:

https://lkml.org/lkml/2015/9/3/428


I'll be happy to write any patches for the kernel that are neccessary
related to these things.


Thanks,

Alex
