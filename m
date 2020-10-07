Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E359F286861
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgJGTdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgJGTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:33:45 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F682C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 12:33:45 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c5so3405206ilr.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5tsGx1C3M8k1XOAUr8ZBwF76yg1FVkRlYjDJ/ypWZnw=;
        b=gPb2p8W0O7YirEDJZl5Y+VFIN+vcdha6G88ff/GonZ0jKruvoA3AoOewa/sDRL/LI/
         aL+SMGT5/5kDNIIX7g6XviztX5fepJOmgH1wjVgFmPDhuOZ18cRJmjl+cVeWffFcAVvu
         yvXoz/hyPu4eS9LTHIM4xNoMaNOcaITVrcwZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5tsGx1C3M8k1XOAUr8ZBwF76yg1FVkRlYjDJ/ypWZnw=;
        b=eVLuEMLg8+xYhzZQGA3Fdrg1UoVzo9YB1OF7Kpg0nYAj2QO28UEaUBDft4aamQeXBl
         GLBCGzJw3c221o62IQEHcbrpr3nfjUb9JUpGCtHbxAc+cI4q0YlZlq5I1U0InYXZGqxl
         /vdPmwa0jQVwImS2mVGZeo7Ty8SS6jqWiuSEjqGBIzBLegc6ukXGJaWkC7mSvGreat4o
         XTPFhQFn7BBa4tS4BnYULxWP+TE/tgIYyyOvlI2TyBgzJw+OhVn17q3TSedaQ8wErqDJ
         1EAvTfEm0T5KtsIXRhsW+csB7fs9GeZh8rcIPzMSJuwm58gzm/KSGksi2Ds8lDPz0Y/E
         Gcaw==
X-Gm-Message-State: AOAM533l+2YIYYZBiQqpRwHQo0VJvPTE4zi6JxUh8Q5EQ0t4c5rdehoF
        OiwzvOkaqA4xqnKdZxWpWG5m+5ca7C0f9A==
X-Google-Smtp-Source: ABdhPJwaP08uxae1WxBovYDz8kN+RKGaUs91K9fEcq4edhWiCbpMqgyMRlgVfye/MqPcFbdHyUK6ig==
X-Received: by 2002:a92:6811:: with SMTP id d17mr3964192ilc.145.1602099224892;
        Wed, 07 Oct 2020 12:33:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q16sm1451758ilj.71.2020.10.07.12.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 12:33:44 -0700 (PDT)
Subject: Re: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count to
 counter_atomic32
To:     Kees Cook <keescook@chromium.org>, gregkh@linuxfoundation.org
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
 <202010071114.EE9A2A47C@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cb86761a-5531-cbb2-3987-0897771949b8@linuxfoundation.org>
Date:   Wed, 7 Oct 2020 13:33:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010071114.EE9A2A47C@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 12:15 PM, Kees Cook wrote:
> On Tue, Oct 06, 2020 at 02:44:35PM -0600, Shuah Khan wrote:
>> counter_atomic* is introduced to be used when a variable is used as
>> a simple counter and doesn't guard object lifetimes. This clearly
>> differentiates atomic_t usages that guard object lifetimes.
>>
>> counter_atomic* variables will wrap around to 0 when it overflows and
>> should not be used to guard resource lifetimes, device usage and
>> open counts that control state changes, and pm states.
>>
>> devcd_count is used to track dev_coredumpm device count and used in
>> device name string. It doesn't guard object lifetimes, device usage
>> counts, device open counts, and pm states. There is very little chance
>> of this counter overflowing. Convert it to use counter_atomic32.
>>
>> This conversion doesn't change the overflow wrap around behavior.
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> I actually wonder if this should use refcount_t just because it is
> designed to be an alway-unique value. It is hard to imagine ever causing
> this to overflow, but why not let it be protected?
> 

This is one of the cases where devcd_count doesn't guard lifetimes,
however if it ever overflows, refcount_t is a better choice.

If we decide refcount_t is a better choice, I can drop this patch
and send refcount_t conversion patch instead.

Greg! Any thoughts on refcount_t for this being a better choice?


thanks,
-- Shuah
