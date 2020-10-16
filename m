Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74E228FE14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 08:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgJPGMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 02:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393968AbgJPGM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 02:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602828748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhTK8mlZxJsJRt3mlsGbPE50FFeq5Q196dDwcFogQmo=;
        b=hJfsxaY/3vRvC1Wxg2gQ/wcsb5ORnX8UCcjrvTpqHphl3C3hB/N/JY5AGR2VMZGNaEROYH
        Pl6dZPA/6j0ZJJkIsxfYr2+PUuuygDhL+EG9gMqhfoizdGzg1fjmZb+95uElAH4ulOnNye
        Re9VnkZFkVgIgX4KxElhM0PAey58cxc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-XebdCiUhN1ybm8dBxLj-bQ-1; Fri, 16 Oct 2020 02:12:26 -0400
X-MC-Unique: XebdCiUhN1ybm8dBxLj-bQ-1
Received: by mail-ej1-f72.google.com with SMTP id i21so530131ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 23:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lhTK8mlZxJsJRt3mlsGbPE50FFeq5Q196dDwcFogQmo=;
        b=cqEmNQlhB640kc0VNikPuGA+IgBlLXRNsFN7fPNUF2fQwmHxWdGV3y2JpqQq4NvWM5
         y5+ZTeFk1Qgp2b9NT+fOjhbze3i/Gq/PYRByLLIWLA8LZEQCU3PIdGaECbji1W0qXO8b
         lwes3bImzYXY5nKoauLvB2g6ojHUKasLHwNBNJPCH2jUFu3Qycs7g/68DH60qewIi4T6
         E5MRPZ3HpxLZhGfmlCm6IqQG80FxGZMl8zIj5Mh+aDOgdmKhwC9M7/ayPN2CtuNnYMcT
         OkvxrqzArsisEujEFbemLqJkAwaJ3T618UmuajzEhaXAEE0wKAitekmL3FVN7DXzKsEo
         PnHQ==
X-Gm-Message-State: AOAM532jDHc02uh4L9qJXHHbpPpaG1WHJ+x/NsPXog8ZimVIT95Mu9XB
        xBGKpEUP8TuVT4MwkkYNibaHTzmY3viJ1EESr5KOWXriMN0bS6SyKl42K6vUUAD7ozOQdHnzLHI
        YD1GLpbt+6cecmz3QBsX/CW/t
X-Received: by 2002:a17:906:24cd:: with SMTP id f13mr2017855ejb.329.1602828745170;
        Thu, 15 Oct 2020 23:12:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/K8DEVgXJsmt9WpWdtv4pG66MeCo3OswfXyYcHMAjSnoFnImSjx9DipncVCYra8h270BN/w==
X-Received: by 2002:a17:906:24cd:: with SMTP id f13mr2017835ejb.329.1602828744997;
        Thu, 15 Oct 2020 23:12:24 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u26sm625366edt.39.2020.10.15.23.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 23:12:24 -0700 (PDT)
Subject: Re: [PATCH] tpm_tis: Disable interrupts on ThinkPad T490s
To:     Matthew Garrett <mjg59@google.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20201015214430.17937-1-jsnitsel@redhat.com>
 <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <78839bb8-dd17-0e55-3d22-be476b71ece5@redhat.com>
Date:   Fri, 16 Oct 2020 08:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CACdnJuuAyBYacCiOOZ8-L-0Xnfa3+pCVY_oejOJ8RPzuG2QgrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/16/20 12:39 AM, Matthew Garrett wrote:
> On Thu, Oct 15, 2020 at 2:44 PM Jerry Snitselaar <jsnitsel@redhat.com> wrote:
>>
>> There is a misconfiguration in the bios of the gpio pin used for the
>> interrupt in the T490s. When interrupts are enabled in the tpm_tis
>> driver code this results in an interrupt storm. This was initially
>> reported when we attempted to enable the interrupt code in the tpm_tis
>> driver, which previously wasn't setting a flag to enable it. Due to
>> the reports of the interrupt storm that code was reverted and we went back
>> to polling instead of using interrupts. Now that we know the T490s problem
>> is a firmware issue, add code to check if the system is a T490s and
>> disable interrupts if that is the case. This will allow us to enable
>> interrupts for everyone else. If the user has a fixed bios they can
>> force the enabling of interrupts with tpm_tis.interrupts=1 on the
>> kernel command line.
> 
> I think an implication of this is that systems haven't been
> well-tested with interrupts enabled. In general when we've found a
> firmware issue in one place it ends up happening elsewhere as well, so
> it wouldn't surprise me if there are other machines that will also be
> unhappy with interrupts enabled. Would it be possible to automatically
> detect this case (eg, if we get more than a certain number of
> interrupts in a certain timeframe immediately after enabling the
> interrupt) and automatically fall back to polling in that case? It
> would also mean that users with fixed firmware wouldn't need to pass a
> parameter.

IIRC then at least on the T490 the irq storm caused systems to not boot
in some cases. I guess if we detect the storm and disable the irq we might
fix that... OTOH this problem seems to only hit a certain generation of
Thinkpads so with some luck the denylist should not be too big and the denylist
approach should work.

Regards,

Hans

