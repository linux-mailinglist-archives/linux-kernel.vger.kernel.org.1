Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5D2D0287
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgLFKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgLFKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607249779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nlq3Q4NGrUjO0X6nFE1J9dRrjXRFJHjkBDkZG6Th+xA=;
        b=XZY9RGu9DLfz31sW4f2oyCEuKQ9iBL8sKZxFpdl+v2S830/y+qT63l3hswheHVxPppko+h
        a4n38uMWVBuXmFZHxwfcvOPVh2cAjCD8sLUaksJlV+dOHysGSUztGoPCugcZfK0InWoAhU
        qRXwnM2SeDgtvU8XtVgwluoBcbHCuNM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-mzRSk6RkNMKd4n4K62b-JA-1; Sun, 06 Dec 2020 05:16:17 -0500
X-MC-Unique: mzRSk6RkNMKd4n4K62b-JA-1
Received: by mail-wr1-f71.google.com with SMTP id j5so2067235wro.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nlq3Q4NGrUjO0X6nFE1J9dRrjXRFJHjkBDkZG6Th+xA=;
        b=JTsNcpCy2jYz8j+tMU5fSNCbEshTrWepA433iPuNK7FHGV7Qz3MiUScqKzf2nGzAJ+
         SYqn0PE8+l9YdFBpLLs8w+m9tlWZ5nM2SF1M6UVergCjzAgvlJaTigFyNmg4A8CLq8QU
         ZFiyRSwq3Mazc5kITZVqILtT3snqO5P7D38ivXgOn7bwt8cQD2brQEpOHT8lPgxLdiHD
         VXE6NUjWsRl+014pbSplc6JdH4+/iS59x8F4kysPP64oJ7x4mKmcy+u/ID0DvYEkUipY
         fIsqLnRPW8ij2E2Y4AUdC4+wVWVfeFZla1v3IQYD6SXk4IiLixWyXAu46L+lxNj6i7Br
         cLPQ==
X-Gm-Message-State: AOAM5331iYIgVtG8KMfiQo5hLN/vq6KrhmZofV0gEeWACC7F7+xkTYMO
        RNfr+MjfEE/XuguCc3uXLXm7iVJ1m9wDQvsbXlmmHlTlBxRIEAhXKWomr4alEcTDQCZW3+SbVHf
        MT3Vi+Sw9MbgoKVwDnC1y+APz
X-Received: by 2002:a5d:690a:: with SMTP id t10mr14261092wru.203.1607249776383;
        Sun, 06 Dec 2020 02:16:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDq6pF9i55QF5IGljkHwdiLBLZZsbGpe+TI+yU+M6yEDL8SU6uwGNHpnOSnRBRhfU1AwJyFg==
X-Received: by 2002:a5d:690a:: with SMTP id t10mr14261066wru.203.1607249776176;
        Sun, 06 Dec 2020 02:16:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id v4sm10615141wru.12.2020.12.06.02.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:16:15 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: reinstate vendor-agnostic check on SPEC_CTRL
 cpuid bits
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org, "Denis V . Lunev" <den@openvz.org>
References: <20201203151516.14441-1-pbonzini@redhat.com>
 <X8pt5WxwJ+yOZUAq@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b117165b-2ae5-e197-8f91-8827d1e0ceb9@redhat.com>
Date:   Sun, 6 Dec 2020 11:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X8pt5WxwJ+yOZUAq@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/20 18:12, Sean Christopherson wrote:
> Assuming that's
> the case, adding helpers in cpuid.h to detect guest support for SPEC_CTRL (and
> maybe for PRED_CMD?) would be helpful.  It'd reduce duplicate code and document
> that KVM allows cross-vendor emulation.  The condition for SPEC_CTRL support is
> especially long.

That's a great idea nevertheless.

Paolo

