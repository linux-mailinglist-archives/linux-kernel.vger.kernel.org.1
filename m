Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293F6216F39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGGOrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGOrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:47:45 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44542C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:47:45 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n24so32278420otr.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMQ6Ydbi+JLRxo2wUoaqNkEbroT35jIeSMVLdMnQJWE=;
        b=KKEOd/zcLE2AXf5EazxiwBI3wxnMQokNu1T7spQD5pucgLYbBftQ5GJMo7eNlBy5Bg
         1daQghNKmn3JNMiv+raekaRF5RbFEROANXZ3LlGN72LhRBAxRj9IBWmoxYrAhEMc5YNy
         uIaNwdXjfS56SVk/E6viWXQUSXgt4+0f4F0J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMQ6Ydbi+JLRxo2wUoaqNkEbroT35jIeSMVLdMnQJWE=;
        b=aPeFcaFwwQLpGANg0AtXOx53u+zrEkXILX0tzDvrMar7951eIaRB7iVrrO6dGkLmcE
         WxnaWbXeivtcafxW2cCkU6hQNKmqm8YwyOW1YS1N9kPHnc0Vs59RDUrmXYcGZgjIkwwv
         phqj4CrAsGpFFyiDo0/kIy3y0jlE+hKqRnbjUtq5dC+UBnPvZYg3mQ1948WmpScrTc+H
         6BmGNNqssotgNaoWhoBT0ZdmLTKjAHKLJwJipmGUuLWa+XyTUC52EXYaInrAJ2lTZADV
         JumoImDVo1NLd1Uh8vX1tE4aDs76sNNDPC8bWNEYnMCdWEQ2Siuz3FgoR8s2GvHpubxx
         86OA==
X-Gm-Message-State: AOAM530l8q4o+KdX5n1H416HyyCRQefTWmJWn9Dgugp8NpMZrVoItxXz
        C+qcKEhzLTR+rLD8G7ARIkBPYA==
X-Google-Smtp-Source: ABdhPJyfUM4uWVUnXhjAo/DPvH6bOqAhnd77oFnO76HAeZaTPhavgaDuQOEPEUkEdS9dr48siBZaWA==
X-Received: by 2002:a05:6830:1313:: with SMTP id p19mr42194391otq.132.1594133264580;
        Tue, 07 Jul 2020 07:47:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c206sm172930oob.22.2020.07.07.07.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:47:43 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] selftests: pidfd: prefer ksft_test_result_skip to
 ksft_exit_*
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        christian@brauner.io, shuah@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200707101936.12052-1-pbonzini@redhat.com>
 <20200707135257.u65ggyr2hcgjfgyh@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0c56c23f-284c-6904-8403-b2183eae2574@linuxfoundation.org>
Date:   Tue, 7 Jul 2020 08:47:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707135257.u65ggyr2hcgjfgyh@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 7:52 AM, Christian Brauner wrote:
> On Tue, Jul 07, 2020 at 06:19:34AM -0400, Paolo Bonzini wrote:
>> Calling ksft_exit_* results in executing fewer tests than planned, which
>> is wrong for ksft_exit_skip or suboptimal (because it results in a bail
>> out) for ksft_exit_fail_msg.
>>
>> Using ksft_test_result_skip instead skips only one test and lets the
>> test plan proceed as promised by ksft_set_plan.
>>
>> Paolo
> 
> Thanks for fixing this, Paolo!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Shuah, want me to take it or do you want to take it?
> 

I will apply it to my tree with Paolo's other patches in this series.

thanks,
-- Shuah
