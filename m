Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84C8272ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgIUPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgIUPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:53:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F59C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:53:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so13346010wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KTBpsSohstfdxMCBUF81EcDDdz06RoEyYMuNoZotyCo=;
        b=famILgKo1O88xDk5AaXOek1uxyqZObcL9K6qvjo0azlyjsg7v7iDgG9+PGPL8NcU9w
         2/m2NQTTomJgdDPXlhkkewzzopjPRU3Q9dOXfkCQ8LoKknK8z9PJNKkph5lQUD+fdU8F
         Jdih1cwR+CG3Jbdn20qourw/iguPUz++2PjGeSFmXqHaR/0JNN7dp0ND1NZOfIfh1kBx
         wSHdRBJeUKD41c3q8VVI+NTmGxlmkUaQ9FlvoWEJdS/NR3r00n4qX9Fgow9RFRPCDgnk
         1gKVdq6e1DFOseXsXbUReVAyX+Coa6hGPo4da7o+ISqXnHgIo6cBb1KDfStXwEi3TTH3
         oR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KTBpsSohstfdxMCBUF81EcDDdz06RoEyYMuNoZotyCo=;
        b=katUY1+wmXGAQlyI0mE1PVDTQTPSzN1+BWz8rA7sv9F/t3+8XvKF/pf4LRMdDUxt2+
         5pBSeYzuHFBqC8VNAU0WiFB690lk7ewfcDvXXlaCTFVIR/0s+EvfBwddc4AIhzno+9Sg
         XdL+MeI6gbddthW+bPI2FDCjzShhwrNUs7Sqo9pm7ZVtT9O9dLPmA7dAVjKaMQhZlHcB
         //8Uk09bUJ0Asl7F7TpAkxNdj4RuqMpRyLSA1ibqV507QooBcy1EcDlolbzzZwWZgOU6
         D94soT7tco4bxzUYry02ARbEspbrAM8t/774lZm9PWfOb2/L+OBIi+8C2aP+e99XNnFt
         BYng==
X-Gm-Message-State: AOAM530lkcJ6hvSIE/rhXLHRgz3O/bH2n/XKWVYmB+Ci/XOAdQcbTCfu
        qgQR4Ldg/7z2L/670w7xISXgzQ==
X-Google-Smtp-Source: ABdhPJyNCd7UpIRBrJBPlKXwCCU7poZm1KA+CUVsd8NiT+RLNIDpMICY3MKvb+cogfmje7NojwyJWw==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr437511wrp.396.1600703629473;
        Mon, 21 Sep 2020 08:53:49 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f173:2b51:521d:d30b? ([2a01:e34:ed2f:f020:f173:2b51:521d:d30b])
        by smtp.googlemail.com with ESMTPSA id l4sm19642474wme.43.2020.09.21.08.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 08:53:48 -0700 (PDT)
Subject: Re: [PATCH 0/3] powercap: Enable RAPL for AMD Fam17h
To:     Victor Ding <victording@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <jbeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <20200729105206.2991064-1-victording@google.com>
 <CAJZ5v0jfMAi2UjvwjYG6=hytGeHZkuaeNEsu+oaz8tEMcuHnPg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <29fb8ba3-8f7c-7736-201e-fec1b0a0d702@linaro.org>
Date:   Mon, 21 Sep 2020 17:53:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jfMAi2UjvwjYG6=hytGeHZkuaeNEsu+oaz8tEMcuHnPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2020 17:51, Rafael J. Wysocki wrote:
> On Wed, Jul 29, 2020 at 12:52 PM Victor Ding <victording@google.com> wrote:
>>
>> This patch series adds support for AMD Fam17h RAPL counters. As per
>> AMD PPR, Fam17h support RAPL counters to monitor power usage. The RAPL
>> counter operates as with Intel RAPL. Therefore, it is beneficial to
>> re-use existing framework for Intel, especially to allow existing tools
>> to seamlessly run on AMD.
>>
>> From the user's point view, this series enables the following two sysfs
>> entry on AMD Fam17h:
>>   /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
>>   /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj
>>
>>
>> Victor Ding (3):
>>   x86/msr-index: sort AMD RAPL MSRs by address
> 
> I haven't received this patch.
> 
> Any chance to resend the entire series with a CC to linux-pm?

Is it possible to add me in Cc too ?

Thanks




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
