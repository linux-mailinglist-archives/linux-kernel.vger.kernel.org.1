Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07E2869F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgJGVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727821AbgJGVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602105280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsS4juZFqfcdzrHO2PVDQfEmKbf/j75qDjzNdWA/dp4=;
        b=eHYuQz9yiSb+JthQq3Emx9QWifQtjXehOT/nJXh4ka3i1gIKOUBMAzG5qOTrzwQebGnKBw
        u9kCGxiyTRL+rSUA3NEBiLLyncfpYWDvFWm63vLThqYQ5OkbFuPnVC1s2mkTjMeT5JABY7
        ztrTu4vFxBk1fLjLHrSl1ryGxFenYWc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-fwXe9clPMcuKnZKjwbStAw-1; Wed, 07 Oct 2020 17:14:39 -0400
X-MC-Unique: fwXe9clPMcuKnZKjwbStAw-1
Received: by mail-ed1-f70.google.com with SMTP id i22so1447970edu.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 14:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UsS4juZFqfcdzrHO2PVDQfEmKbf/j75qDjzNdWA/dp4=;
        b=SMRkLDYi1xUSuLjKO3FhoBlWOAQjdEFQKHzZXFKVIMsKzL9r9+SOLWAXNLOwHi9WQV
         Yc3ArhUpnvvsnZiOzeR8/L3kysviU3+Ac4Ji2vom0lBu/hGpZ85JhML3NNUfWPRLcvcJ
         hoL3GNu53k4LKt7ZTVL9UYFdgZk9ehsD2jmFexqrCKZDdai/kZwz9a9sZnL+IRKETdfz
         yoe046qGSLby0MDuC+pgsT60mvvS012rtyqniLR7FP0r6Z+mPUHSDHZadFMVhPP7wIQg
         olcNmH6E1x83lVfpkls8p2W38PQwQBqYIa6wZeiG95SRw3hd3vgNmKTKqJsX8/B/mJrB
         06cQ==
X-Gm-Message-State: AOAM530sCFTrSdfp/Pg/M0xifcudd5Ch0W3S2fSy2++2wBMsr1SI2CVg
        4kqorPjinIhWXT+zp/dlNIbcX4O+w7JV66GeyCzx3w6xrSbpMT0iuw/aI3OCSig4SJqfTjIH/eO
        ZbowFNCciNYJjwj7Tmoy/aS6J
X-Received: by 2002:a17:907:4365:: with SMTP id nd5mr5461678ejb.56.1602105277814;
        Wed, 07 Oct 2020 14:14:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO3AZ/uQr60oWbsGvXQf5H0kkUbwZNu5WCxlnZdO17Gf+feZ0U52eqMaLw6eAyuOOFTA+hQA==
X-Received: by 2002:a17:907:4365:: with SMTP id nd5mr5461667ejb.56.1602105277642;
        Wed, 07 Oct 2020 14:14:37 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id bt16sm2309673ejb.89.2020.10.07.14.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 14:14:37 -0700 (PDT)
Subject: Re: [PATCH 0/4] pmc_core: Add RocketLake and other changes
To:     "David E. Box" <david.e.box@linux.intel.com>,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20201007035108.31078-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <74b92bc3-2126-a11a-5de3-3f594c6af82c@redhat.com>
Date:   Wed, 7 Oct 2020 23:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007035108.31078-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/20 5:51 AM, David E. Box wrote:
> Add RocketLake platform support and other driver maintainance.
> 
> Gayatri Kammela (4):
>    platform/x86: intel_pmc_core: Clean up: Remove the duplicate comments
>      and reorganize
>    platform/x86: intel_pmc_core: Add Intel RocketLake (RKL) support
>    platform/x86: intel_pmc_core: fix: Replace dev_dbg macro with
>      dev_info()
>    MAINTAINERS: Update maintainers for pmc_core driver

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up there once I've pushed my local branch there,
which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

