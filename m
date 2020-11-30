Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE802C8620
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgK3OB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:01:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbgK3OBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606744829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z1V5TP+t4YgIIKSdanYDtXXCORZzAdrzBJD0xz3ZJJ4=;
        b=SuHIjvdeFRWWvfKZjk2vgFB2VaI92+X7aOVamwDnXIZ1Va0LvI9ci4m4WIXrgem1WRVnel
        WmiYMtO2pzJwzRf7gztzj1P9CqghTaKu3uqiP58nr4njV17AKDw1yNuC+GXOOwPDi1Frfo
        csq5zGwH28BtTS0NBbcrFUD2fqqVJ+M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-20lmt-NTPEqYINshFkpYcA-1; Mon, 30 Nov 2020 09:00:21 -0500
X-MC-Unique: 20lmt-NTPEqYINshFkpYcA-1
Received: by mail-ej1-f72.google.com with SMTP id t4so4119317eju.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 06:00:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z1V5TP+t4YgIIKSdanYDtXXCORZzAdrzBJD0xz3ZJJ4=;
        b=PjsfncGkj0M84PIFH4BURma5PGv8b/fipjS4NgW4MwSnxg8p10ld38LHDfh9G1Kocq
         t5kPqF7WOXamGhFqJhpkryf2vihs6gRw+gItUtvBiTPFcq5ycdpFAiGWnizHXBP/DmnN
         tTsTV9e21r2i0GKuI3x/zvy2glk2Is6WjSl9YrsKSKP5Jm0+0W8kBuWPpuD8Eoq2+De9
         xZuen4VeuWkhj+n0GXcAEXNjxsfKcJS7DLb1DH93fp2FozTYEZWL6aZc6rogSyIupArg
         8zE/9EXqKkA3L7p09rQRnzqCSf82hIg8YLNSxHbNJ2HsL6gKgzckSySOVGOH07pSLcfU
         TTMA==
X-Gm-Message-State: AOAM533n55Iqmj5Rq+fCallXoyCw+EoMm4iS40B2XqaGLEzXjDI2ZmYZ
        PKfbe8Wq7cYPsT5MUuGCNGsmGXB7d2K4lSacedqILzbahXtukY4FttNNUPfkV5VEN/nDOf5jwa/
        jfmMIN2jJibGuQxOZ2sfImib4
X-Received: by 2002:a17:906:e093:: with SMTP id gh19mr16467838ejb.510.1606744817460;
        Mon, 30 Nov 2020 06:00:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPMhCAxuB2B/TcTZz4LyxRjBTd2O6WcbKZeK0qo3nFya2kmMSturj18lyD86gg2TrlnvR3iQ==
X-Received: by 2002:a17:906:e093:: with SMTP id gh19mr16467362ejb.510.1606744815303;
        Mon, 30 Nov 2020 06:00:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f25sm8943114edr.53.2020.11.30.06.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 06:00:14 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org
References: <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
 <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <X8TzeoIlR3G5awC6@kroah.com>
 <17481d8c-c19d-69e3-653d-63a9efec2591@redhat.com>
 <X8T6RWHOhgxW3tRK@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8809319f-7c5b-1e85-f77c-bbc3f22951e4@redhat.com>
Date:   Mon, 30 Nov 2020 15:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8T6RWHOhgxW3tRK@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 14:57, Greg KH wrote:
>> Every patch should be "fixing a real issue"---even a new feature.  But the
>> larger the patch, the more the submitters and maintainers should be trusted
>> rather than a bot.  The line between feature and bugfix_sometimes_  is
>> blurry, I would say that in this case it's not, and it makes me question how
>> the bot decided that this patch would be acceptable for stable (which AFAIK
>> is not something that can be answered).
> I thought that earlier Sasha said that this patch was needed as a
> prerequisite patch for a later fix, right?  If not, sorry, I've lost the
> train of thought in this thread...

Yeah---sorry I am replying to 22/33 but referring to 23/33, which is the 
one that in my opinion should not be blindly accepted for stable kernels 
without the agreement of the submitter or maintainer.

Paolo

