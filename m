Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BEA2DB42E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgLOTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731819AbgLOTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608058812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5HE8p4803nr8EEV2Foh/7Cpa0TkBbGGqMwRHap2gZvI=;
        b=PAVcZGk1IvgxPRwFC6cHi7zqI+Apamb+E7kOHYhTF1fPIdXavGb6gjxgDQrXfu8hcRei3K
        0kDC9v8xkCgyB4aOwtkljdqsCQZ8Rdx4dPrhE3SRWBGL1gHT81yUI6nvEZ2VA3n5OdnI4b
        lzUCGYNFq4EUBg3QnufIIzxeZde4Jos=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-llvD48JxMtqU7OlNDoTDcw-1; Tue, 15 Dec 2020 14:00:10 -0500
X-MC-Unique: llvD48JxMtqU7OlNDoTDcw-1
Received: by mail-qk1-f199.google.com with SMTP id 189so12395172qko.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 11:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5HE8p4803nr8EEV2Foh/7Cpa0TkBbGGqMwRHap2gZvI=;
        b=VFVwxW9Cq7gJMKJboVGfWmZmOHC6L5naGfdc8DvpnMwKi1YFOjWiCLhH0EDoFZbfQR
         XqsIcgC9XmnOnSbhxZ6Nmr0aZnzIWUzaH11J64084mpKXEx6TRv8NKSrZXrU5vRRbNGC
         UKhvUoURSw2LKfawrSjFaQ3F5EeudY+c2FRUSP4EoTpthH1fmEZR2dokXOjs+piLdVGa
         ZNP9AJnUblDbKXWNz/S3A223srlNL7xyo3qFUQYgezA7wJ4qoItuomdTWF/5v8egU65/
         uZOymE+WuSYSSzXa2GPQ3wTydP+J/GgKFCzdg1lENdNOGc7VJAxmeZqyzHCj5JMFt9aN
         1feg==
X-Gm-Message-State: AOAM533odAcsjTZ2PeaE5VU3sEqMTI/xENxRdpEPwjwFPXrpO/6trbL8
        dOU5nY1Hv9zQnWdtrszB3S0I7P57AIxSHxdp0rk08D/eTLt0JNc0id+CtN3/xOItb6lJORfW6rw
        /+QvMatbewui8pquVL7xPAu0pt41L//srAG2sSQa+YlV0SWrOQXZzWwIj2uyeULeo/ELrnKI=
X-Received: by 2002:a37:8d01:: with SMTP id p1mr20046605qkd.31.1608058809663;
        Tue, 15 Dec 2020 11:00:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsEMbKSsCB6tRrwkxY7WiocSFllMT54n4GdhwdkEoxTJJmDGKfXjf4l0GrD1Ds/zJlQ5106w==
X-Received: by 2002:a37:8d01:: with SMTP id p1mr20046566qkd.31.1608058809388;
        Tue, 15 Dec 2020 11:00:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r6sm18260743qkk.127.2020.12.15.11.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 11:00:08 -0800 (PST)
Subject: Re: [PATCH] drm/i915: remove h from printk format specifier
To:     Chris Wilson <chris@chris-wilson.co.uk>, airlied@linux.ie,
        daniel@ffwll.ch, daniele.ceraolospurio@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        lionel.g.landwerlin@intel.com, rodrigo.vivi@intel.com,
        tejaskumarx.surendrakumar.upadhyay@intel.com,
        tvrtko.ursulin@intel.com, venkata.s.dhanalakota@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20201215144101.1878719-1-trix@redhat.com>
 <160805599050.14591.5854311082825914383@build.alporthouse.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <12579dc7-603e-2fbe-85c0-0a4110b8992a@redhat.com>
Date:   Tue, 15 Dec 2020 11:00:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <160805599050.14591.5854311082825914383@build.alporthouse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/20 10:13 AM, Chris Wilson wrote:
> Quoting trix@redhat.com (2020-12-15 14:41:01)
>> From: Tom Rix <trix@redhat.com>
>>
>> See Documentation/core-api/printk-formats.rst.
>> h should no longer be used in the format specifier for printk.
> It's understood by format_decode().
> * 'h', 'l', or 'L' for integer fields
>
> At least reference commit cbacb5ab0aa0 ("docs: printk-formats: Stop
> encouraging use of unnecessary %h[xudi] and %hh[xudi]") as to why the
> printk-formats.rst was altered so we know the code is merely in bad
> taste and not using undefined behaviour of printk.

Ok, i will fix this after the first run of patches.

Tom

> -Chris
>

