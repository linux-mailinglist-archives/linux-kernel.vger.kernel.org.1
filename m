Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352D52869E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgJGVMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728227AbgJGVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602105134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDK3Gt9aT4einF5OjoqPRMgVOrOe8nFuHhFEtB2s2qQ=;
        b=TUnMsCVfe4iM+eFMVc1WikcR5P0Gk69yhUJQkQlXcl3zXoLoPpbD5COpKxfesR+73QWjkI
        DcNKtR0FvGhwJUIv/NbYTS8mAUvkehLzJ2HQpBFhNqU+vW3/PyIrC9vtlKLXKnVKY1UfVC
        8CUhiTKddHaxn8wDFH97CYJfCKA8ieA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-lQvGFbo4PQmYVIJJIy3BzQ-1; Wed, 07 Oct 2020 17:12:13 -0400
X-MC-Unique: lQvGFbo4PQmYVIJJIy3BzQ-1
Received: by mail-ed1-f69.google.com with SMTP id y8so1440588edj.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 14:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDK3Gt9aT4einF5OjoqPRMgVOrOe8nFuHhFEtB2s2qQ=;
        b=qS6QVbsmeEy1T3LfqmooyOTqXhEnXaQah6uPjGjUhNxvNl6ICilatW01ZN4v+o1XCp
         Pqb+PjtKXp1IwC66bMpyVwLagJyRse4NTR+p44UTUc1KXLoFr0mTjhvmRckPgv+oWBf2
         atYur2rHMbT87vxz4MaNgJLkTDaUijQMR4S+GBOh/DG7sDDP7m/6yHFAoaNzJ2Iwm7Ah
         wYtvIkLffc1JioR+w4TG5rYr3Wdwx9xAStuDy32uzLlfeCWnfZnqlPjJVDdXDNMRD5Og
         RLjTanjZdBQmxaGA4/mMnTFtdnsLqi2S+4lNctFHXqnt6sylFsyQ8PvpYRgLJalT8NmR
         EXUw==
X-Gm-Message-State: AOAM530w0PO0kBEJN4gwYhZkwnbCCs6HwXf6DLZCwi/fC3sZ5qE8zLTD
        tdMkmdYL1slyVlPQPW+k1rP15IGzYKNxFOp1AwbiXhvb75zmy8YCfm8YnOYAOvl8J4jSc2a1zT/
        zTresg6S6IROfP5QCBJHHhtih
X-Received: by 2002:aa7:c90a:: with SMTP id b10mr5800430edt.163.1602105131359;
        Wed, 07 Oct 2020 14:12:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjvdi7t9Ou7H9+JvHcCbilja8b5Sc3ql4mlKCyEKyXLa6QzXgT8fPdMx4sgqSar2mUADDCFg==
X-Received: by 2002:aa7:c90a:: with SMTP id b10mr5800409edt.163.1602105131083;
        Wed, 07 Oct 2020 14:12:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id f20sm2232254ejc.90.2020.10.07.14.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 14:12:09 -0700 (PDT)
Subject: Re: [PATCH 0/3] Tiger Lake PMC core driver fixes
To:     "David E. Box" <david.e.box@linux.intel.com>, dvhart@infradead.org,
        andy@infradead.org, gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201006224702.12697-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ad5c6d7c-351f-c1ee-7cab-6d3f083a10a1@redhat.com>
Date:   Wed, 7 Oct 2020 23:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006224702.12697-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/20 12:46 AM, David E. Box wrote:
> This patch set adds several critical fixes for intel_pmc_core driver.
> 
> Patch 1: Uses descriptive register names for the TigerLake low power
> 	 mode registers. Not critical, but was requested in review of
> 	 Patch 2.
> 
> Patch 2: Fixes the register mapping to the correct IPs in the power
> 	 gating status register for TigerLake.
> 
> Patch 3: Fixes the slps0 residency multiplier to use the correct, platform
> 	 specific values.
> 
> David E. Box (1):
>    platform/x86: pmc_core: Use descriptive names for LPM registers
> 
> Gayatri Kammela (2):
>    platform/x86: intel_pmc_core: Fix TigerLake power gating status map
>    platform/x86: intel_pmc_core: Fix the slp_s0 counter displayed value

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up there once I've pushed my local branch there,
which might take a while.

Once I've run some tests on this branch the patches there will be added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans

