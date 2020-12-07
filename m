Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADD2D1862
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgLGSTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbgLGSTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607365061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOBmTGb65u1zbDQhSNHIQ5RWUBC279gK5SaIcPJyzDo=;
        b=V+T7hBd4V+5TEPhpW4SSW8kBBp1IqrH1GNKYNIiEzDGqJS0Ri7NAhrPcSQUIo+OmJwNCyb
        6ToD6aE5spwDmd2o/vARmVrKzOs5+tPPu5488UdicA3FAKjHF9eRP89HApYkONqnTjbv4J
        tarzU5Kbwk+borENgoqvXxpUgakzRyo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-XjK6ygPNNsaKXBso8eOYug-1; Mon, 07 Dec 2020 13:17:39 -0500
X-MC-Unique: XjK6ygPNNsaKXBso8eOYug-1
Received: by mail-ej1-f69.google.com with SMTP id k3so650383ejr.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 10:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UOBmTGb65u1zbDQhSNHIQ5RWUBC279gK5SaIcPJyzDo=;
        b=oiF1BlWJqNo6C9wlRSI1xL97aI5cnuCXWzZrn9CKMyqEeF0/omZrnPvURP0X8J9Tud
         QJPyi2wR6ZEmzXPfOBE/ahS67sr9WVciGcq2A0wIF3HWtzCVBr5ccFlp74Oa0YbR2z+N
         vdqqcU2ArOoBVM7NRqewQFKNY62ECW8y0OO7i6eZl0vS5DQkNiHKgvBjARDGHUV/LNBB
         yZHBWnltPWbf4HeSSD1F2IACAkxfRZ1jPIbZoejZZHENjSai0SotQpERzQzBFN5tJvhG
         rdZiyBPJ6xHezzrHwiVJLhFz3b7iaOyLmBaQRD5NWzLFaiKFg1vnCrdjelgmDyeDelPp
         YnHw==
X-Gm-Message-State: AOAM5312xs3I2bHrjaFkhRJuxHupwlAtjBVhoMI0F/5kuq/yvo9HKGDN
        VQJbFAeRY2IZ6byGqmvHe5HAOQiuRIlLwHk3NvN6lb4Xp/kytaZFWn0o416bY2BxDBrlRaJTDix
        xUGkuGV9DpR4lNX5QsUo+ECJd2mDnzZZD1OlWlLjIFeT1frTEdVEmqn+AjfCkLCKBl8KryKtKs2
        pK
X-Received: by 2002:a17:906:60d4:: with SMTP id f20mr20589576ejk.156.1607365057926;
        Mon, 07 Dec 2020 10:17:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ2UVolp/mUMVoCZonZ/BlCiEw3d8F4JXSVAzGqtdkFNKFHLH4lljaPQwj3ehl2bSuTH0s/A==
X-Received: by 2002:a17:906:60d4:: with SMTP id f20mr20589563ejk.156.1607365057749;
        Mon, 07 Dec 2020 10:17:37 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o13sm3915461edr.94.2020.12.07.10.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:17:37 -0800 (PST)
Subject: Re: [PATCH v2 0/3] Intel Speed Select interface changes for 5.11
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2f663d89-184b-f52e-6156-f485205f27f5@redhat.com>
Date:   Mon, 7 Dec 2020 19:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201207181531.1718148-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/7/20 7:15 PM, Srinivas Pandruvada wrote:
> v2
> Fix sparse warnings reported by LKP.
> 
> Srinivas Pandruvada (3):
>   platform/x86: ISST: Check for unaligned mmio address
>   platform/x86: ISST: Allow configurable offset range
>   platform/x86: ISST: Change PCI device macros

I've already added these to the for-next branch of:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/

Please send the changes in this v2 as (a) follow-up
patch(es).

Regards,

Hans

