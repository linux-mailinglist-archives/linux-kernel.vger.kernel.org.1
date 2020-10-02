Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B365281DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJBVoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJBVoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:44:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133FC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 14:44:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so2353213ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 14:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=eAwV6U5ahvTpKCZ5UaKtD2Y1EcpFb5M2DxULPwBOuyI=;
        b=JPuQYQNMeiw+8SxbJvN6+HWdt+wRJEnJij4CtnjJ/8uvJ+nmJDXKSMLZJzramQeVzQ
         dAGsDGUgeTe0NEVzrzje3BEZ+hM2IYlu/HaVrFPH1B5q0Hg3lQfpDhSrlJf0qoOg9tlj
         ax9bNnNxYpm3kUO/Ii+ybi7WSE5+JnOCWCbygsaI/bkGateA554KGpCuXro18MCogEkx
         /mwFhVkqpONYbVZ5tPbFtIFsNy2rVDnQ01v+Ue2aDA0neYUMQJufAUi21H5Vv1nzMxpA
         HvyFyKbackOaob9SbncthU/z2n3XpBTIj/QO1fwJBwYGyqE5hNC4gKve/ls6r6eiQmXm
         m46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eAwV6U5ahvTpKCZ5UaKtD2Y1EcpFb5M2DxULPwBOuyI=;
        b=VY4cxRNhEqhBk5UF+I5F54Y0s2DGA14QDcDKNK/CbMCdmj2RVkthzGto38MsHz3hPt
         k1HOckpvw2dFqfED3EEQtSSVidr0G3PrIZGIW33jQmaqMm/OSzevXQjMTg3QJkgbWZEI
         CPq3bW1vIW5K3snkY2aC9FHaZXrIIFCeZIQCsCVZsIstwk3XlPvfvRwPQaEx6Tf46250
         9bS1RKirhRlrg0tBwP7a9MV3wUSXrlK4oxwnamMzQkCy7jGJqxdwqysXydTfxLQXf5nY
         LgBjOYfYr8eShHee2oM8emrnEgE/DXuVt8Dbr/MeoWTtt20mgZFaeXirqODx8VGLts4j
         SiZg==
X-Gm-Message-State: AOAM530mnmjok8OqdGctNRqhrlKGJcYUBBWh3AJg342tbQWAoCVVqwZR
        qv9HaUIVMyRGzbi3K2lLGANUZ2nYcUc=
X-Google-Smtp-Source: ABdhPJxqTwlMlspJkUUgaH3YRy2gqtqnVmBlHyaYL3jmMJeGgFhH5qP3DHWF51cuFRKzly+l7XhNgg==
X-Received: by 2002:a05:651c:102a:: with SMTP id w10mr1221540ljm.64.1601675051875;
        Fri, 02 Oct 2020 14:44:11 -0700 (PDT)
Received: from [192.168.1.84] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id m1sm667520lfr.32.2020.10.02.14.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 14:44:11 -0700 (PDT)
Subject: Re: [PATCH] mm: optionally disable brk()
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
Date:   Sat, 3 Oct 2020 00:44:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.10.2020 20.52, David Hildenbrand wrote:
> On 02.10.20 19:19, Topi Miettinen wrote:
>> The brk() system call allows to change data segment size (heap). This
>> is mainly used by glibc for memory allocation, but it can use mmap()
>> and that results in more randomized memory mappings since the heap is
>> always located at fixed offset to program while mmap()ed memory is
>> randomized.
> 
> Want to take more Unix out of Linux?
> 
> Honestly, why care about disabling? User space can happily use mmap() if
> it prefers.

brk() interface doesn't seem to be used much and glibc is happy to 
switch to mmap() if brk() fails, so why not allow disabling it 
optionally? If you don't care to disable, don't do it and this is even 
the default.

-Topi


