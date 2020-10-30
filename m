Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82D72A0C42
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgJ3RNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgJ3RNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:13:50 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48AC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:13:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s7so8240511iol.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szMBELtKzxhB5vLQY6nxOOzk0TwbzjSvsZ1JzLhDTHA=;
        b=JpyR7lxktxfr3/YD/6xwXxm05y5jNPrsXLiJegDHwonoSCqIAk2lEuNHqIbvcdtDsO
         BgdxMYv2cd++kiv+rCWkSjtRxn/nqTUI21yQ5PtEf0uQ9IPaj2eOHTDqOjattOXdrmlx
         IG2NbG4Gf41pP6W724rMLpZ0KN1/0UhZG0ixQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szMBELtKzxhB5vLQY6nxOOzk0TwbzjSvsZ1JzLhDTHA=;
        b=JqY1CqDsFsJxhznjjEHmFF24e75y4rjMVNIIjwaf74rvcbI9guBKn6OOKiNzW+PCXK
         ypTF7za3sAoLbZU3v1CwIE6GqaM+Yx7i/Ay1wgIQV7VevmwUJ6WdmUBZqKyL4MgJT8mH
         4/fZaaNTDenZD3KQWKZ01wJFy8o0Z2XzgXIWM75IJcO2mqHH+g3Zny1phwqrOsd0+1uu
         dVYgVug9Y62jHiORFOLPbgwz7H3K8+qXtw4RofJ+o0tUV52cUAqbOggTkIVpL3/z0Zvn
         ptNqDL0pEnOogMs7GoFnYyC7fyWE8rK2XNDoPFvoHWaP/hxkwCBlbXf49h3whDZvvLya
         vP3Q==
X-Gm-Message-State: AOAM533c8dPYpnjvtBQoNspMP5AtgFJM4obccDEkJ+piW0rGIILs14l9
        825VPfonIwBgIpasWInzmIvb2pqlPvsWQg==
X-Google-Smtp-Source: ABdhPJwR/vg8mQM9eAwkk849NXVDcx1hD8BS8XYHU3zHgKwqHAGUB6c+au2wXZij9PQCOQKCd9v2Gg==
X-Received: by 2002:a6b:3c10:: with SMTP id k16mr2671008iob.209.1604078028191;
        Fri, 30 Oct 2020 10:13:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k8sm5259666ilh.8.2020.10.30.10.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 10:13:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201029190259.3476-1-bp@alien8.de>
 <20201029190259.3476-2-bp@alien8.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d6da5f48-5f50-a201-1f6c-5084466f81ee@linuxfoundation.org>
Date:   Fri, 30 Oct 2020 11:13:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029190259.3476-2-bp@alien8.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 1:02 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... instead of poking at the MSR. For that, move the accessor functions
> to misc.c and add a sysfs-writing function too.
> 
> There should be no functional changes resulting from this.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
>   tools/power/cpupower/lib/cpupower.c          | 23 +++++++++-
>   tools/power/cpupower/lib/cpupower_intern.h   |  5 ++
>   tools/power/cpupower/utils/cpupower-info.c   |  2 +-
>   tools/power/cpupower/utils/cpupower-set.c    |  2 +-
>   tools/power/cpupower/utils/helpers/helpers.h |  8 ++--
>   tools/power/cpupower/utils/helpers/misc.c    | 48 ++++++++++++++++++++
>   tools/power/cpupower/utils/helpers/msr.c     | 28 ------------
>   7 files changed, 81 insertions(+), 35 deletions(-)
> 

Thanks. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
