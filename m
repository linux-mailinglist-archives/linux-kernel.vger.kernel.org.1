Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6762E9763
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbhADOgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:36:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbhADOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609770876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlGNmue/OEcc+LrokQ5uW+ClGR/N9N2hz5xtfGyMhr8=;
        b=SB3T5wEVE9a1BhpX+e46rGYN7csXHpDLYnqOAavVskWOI2NKrLtT1ttwz1Rlf0r8mGvIO8
        SqqqFqYQQM3IBhtuGEfgRLlCM4+ufZQ4Om4qGxWGRPpOjMAW3t8uQvlSMeCg3BsUzgua10
        ysHQ03OL9G9a7CRdd603qZiBOJZjiLU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-_2tJJvtLMaydFmQ-ce1wbg-1; Mon, 04 Jan 2021 09:34:34 -0500
X-MC-Unique: _2tJJvtLMaydFmQ-ce1wbg-1
Received: by mail-ej1-f71.google.com with SMTP id dc13so7041115ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MlGNmue/OEcc+LrokQ5uW+ClGR/N9N2hz5xtfGyMhr8=;
        b=Od/CeHC6agOP79AKK0Aj+s4g7Wpn32WDtZF6g21pdJHahT/xL/VNOv1Yj6XVqRcrbe
         Tj2WAyC1r4vUwPVdT6PteN0v5JvjccEj9Nia9SzvHCVKS1zzh90VbKxRUsHpumASEeHZ
         pmL5ozKSCAXQw5tjZIuAMi81/nb4gyfibkUzVv+ax4zOMzMcs9z/l3O9dG/VJislTntL
         glZynM4V9G7MhLZtRG3RPn6GDLSkFw0AOWb9rvS1ebFoexUUsdzPBzq0xphH84qrffTK
         BlS667KFN+moX/k7Oqvyv6PoZKzX1w+dZRUiboeLH2GcgfSoYWxDtjvLB+rEctXZLVBh
         J2JA==
X-Gm-Message-State: AOAM532u9H9+ROOy/Ah05C7wQp39TGUM4lD5FqndJxUQiIkqNGq8XjQL
        sRqYHGKCbbcli8zJbjmRbP/BlhoOk7l+e+53S2wZVio6zzwkDdbe26zVDCPNHww/VCqWgeMxe2B
        cR6a03G8J22UtKtLXpRIUq96hav691e6N1u8+oR6w9u6MLPukFcBLaeAl2b2vLMGGLyePWUAjPT
        P8
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr42799385ejy.199.1609770872706;
        Mon, 04 Jan 2021 06:34:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyznHvL5Jm3vifHBDmK8iYArUSZMyjWRdPfXkd44h1PErXhEC1aVo64TNJev5ys8eLkIEsggA==
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr42799366ejy.199.1609770872506;
        Mon, 04 Jan 2021 06:34:32 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id v24sm44039398edw.23.2021.01.04.06.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:34:32 -0800 (PST)
Subject: Re: [PATCH 0/2] IdeaPad platform profile support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Ike Panhc <ike.pan@canonical.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <35ac853a-266c-6944-6e5e-6286456865e3@redhat.com>
Date:   Mon, 4 Jan 2021 15:34:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210101125629.20974-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/1/21 1:56 PM, Jiaxun Yang wrote:
> Tested on Lenovo Yoga-14SARE Chinese Edition.
> 
> Jiaxun Yang (2):
>   ACPI: platform-profile: Introduce data parameter to handler
>   platform/x86: ideapad-laptop: DYTC Platform profile support
> 
>  drivers/acpi/platform_profile.c       |   4 +-
>  drivers/platform/x86/Kconfig          |   1 +
>  drivers/platform/x86/ideapad-laptop.c | 281 ++++++++++++++++++++++++++
>  include/linux/platform_profile.h      |   5 +-
>  4 files changed, 287 insertions(+), 4 deletions(-)


Thank you for your series, unfortunately the
"ACPI: platform-profile: Introduce data parameter to handler"
patch causes a conflict with the pending:
"[PATCH v8 3/3] platform/x86: thinkpad_acpi: Add platform profile support"
patch.

But I do agree that adding that data parameter makes sense, so
it might be best to merge:

"ACPI: platform-profile: Introduce data parameter to handler"

First and then rebase the thinkpad_acpi patch on top.

Rafael, do you think you could add:

"ACPI: platform-profile: Introduce data parameter to handler"

To the 2 ACPI: platform-profile patches which you already have pending for 5.11-rc# ?

Regards,

Hans

