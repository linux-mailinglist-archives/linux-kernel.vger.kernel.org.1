Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8F2D02AF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgLFKTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727641AbgLFKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607249905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WgJlDTyqqD0UA02NymSR8vLhTBhzQGimKmQPRsZt2A=;
        b=ghYjwbCDl2+AZL6Oqe7NirZ6DJx+SXIDZpDJ6au2U7u3PLu57h39ebbP+7k/u0JE/6jYY0
        TNwIaxXxnWaO95PeCc7mvXvoxa1Ihqvm3e+kmvpMBSA0KenOq6tjZGXKT3cicFgIFa/59v
        FF/3hoxWhMvog3BP3yVLdbNz3nIE/to=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Ej1VNvCTMZKvErckIgaW-A-1; Sun, 06 Dec 2020 05:18:23 -0500
X-MC-Unique: Ej1VNvCTMZKvErckIgaW-A-1
Received: by mail-wr1-f71.google.com with SMTP id p16so4157628wrx.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WgJlDTyqqD0UA02NymSR8vLhTBhzQGimKmQPRsZt2A=;
        b=Wwxinec083oJtNBBpVf4EEE54vKYi7OLBAerJWdURwJsEvcKPfFDCsqzOL6w9WnJU+
         Qk4ZkupDIecrVz/779eSeVM+gA5UnRwMY9+YiyyBEpRIL94Yg3dqXaIH2ei8y+XJs6g7
         wPsEHhJxMEo/5L1o9rm9n31huw9kExfvtpdxprPWWY6dk0AgR9o5nmYJYv1Yaxw/v5eZ
         VsRu5qP8HTy7B5jD5SVvIeU4mMsuboGm4jcqk64ML9Sb2cBfAKrF4cP1DQBvr6sTvyXJ
         68CswiRx+v880xsdT1AdQ7z8UAqxxmz3yEFtc0V4FvvWBRKlBXjz5oZ5dgGac+YUqmyd
         7Xug==
X-Gm-Message-State: AOAM531+nkSHtBlZZ/iiX934AoxOFeAzE8IOyYDg1i5i6tUZb+rGW+YE
        I+m9fq5ralI/c6JzESuFGFMFsba8qmGvru75hpd/KoPCr9ZEVZQB90dmcEUCB1Z64qr6i5cxrK/
        0FRV7QV/Y47szX0PSQ/oQvepx
X-Received: by 2002:a1c:b104:: with SMTP id a4mr12873866wmf.138.1607249902687;
        Sun, 06 Dec 2020 02:18:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKL28b3RkwPomzNpWHRBxNztsP32mJ0efGXUhURZiiadlEdqgo0yjCDjLRc30KIdsJYk1tZA==
X-Received: by 2002:a1c:b104:: with SMTP id a4mr12873851wmf.138.1607249902507;
        Sun, 06 Dec 2020 02:18:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id y18sm10465741wrr.67.2020.12.06.02.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:18:21 -0800 (PST)
Subject: Re: [PATCH v8 18/18] KVM: SVM: Enable SEV live migration feature
 implicitly on Incoming VM(s).
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, Thomas.Lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, rientjes@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1588711355.git.ashish.kalra@amd.com>
 <a70e7ea40c47116339f968b7d2d2bf120f452c1e.1588711355.git.ashish.kalra@amd.com>
 <7a3e57c5-8a8c-30dc-4414-cd46b201eed3@redhat.com>
 <20201204214656.GC1424@ashkalra_ubuntu_server>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17551007-bcc9-e772-5318-264287ee8ae9@redhat.com>
Date:   Sun, 6 Dec 2020 11:18:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204214656.GC1424@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/20 22:46, Ashish Kalra wrote:
>> I would prefer that userspace does this using KVM_SET_MSR instead.
>
> Ok.
> 
> But, this is for a VM which has already been migrated based on feature
> support on host and guest and host negotation and enablement of the live
> migration support, so i am assuming that a VM which has already been
> migrated can have this support enabled implicitly for further migration.

It's just that it is a unexpected side effect of 
KVM_SET_PAGE_ENC_BITMAP.  I prefer to have it tied to the more obvious 
KVM_SET_MSR ioctl.

Paolo

