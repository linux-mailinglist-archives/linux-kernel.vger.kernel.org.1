Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A729F703
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgJ2Viq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgJ2Vip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:38:45 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868DCC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:38:45 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q1so4614593ilt.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKe0JHOwCecKuAjkjMsnJIi75X/TchLoPWYf5BJqFJc=;
        b=ZQ39XwpWUNJe8NW3KoyvnAbECXCSATyqLgvcqrLpYj/kIDIPlOBi9fTaMntMJyMI7A
         YPQ3gUHr694j02xA7ohmTFSY+rdYpeWdQDx680pOMq68fQLCUK5Dy7hxCpIqbIZciqMO
         H8tGJ17IqenLb68NYiVVPQCPPUjmPA2UU16xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKe0JHOwCecKuAjkjMsnJIi75X/TchLoPWYf5BJqFJc=;
        b=KK91C392veKAckHTWBxFfRJBqhFwFC5stLFlveGXOnpwnGc/zpuZbQrRSnO4u68a25
         q24gJW9FBA6ceuciQMTUFeSW5gMOaRnRRkumGZ97haNj2SlErAYpBv0ZcjpjNXX+Bh73
         QIWc96IQs+BnXIz5NYFBiy042AWksRI7OStowN2qIWS4OybzbiLLLPMSJbNjqc3Wuv/d
         WOYlOfAy6ZxbzbTZTR4VKW8APWEnbnT/8LdSe9woxLTu1nfv/9FO0Gi1zZVT9LhhsNLv
         gWhY9kb3AKgyJ58i445aQnrbiY56qaKC4M/gPH2Ti7YEYcynD418sHfWWHgVkZgrvI7q
         TFew==
X-Gm-Message-State: AOAM533dEFXifqMwwt/1xOrdH3isS2OAzESTw3hx5f5+3IQ53dPycGmv
        5LNz4vB81qhr3tkwzl4oI22E0g==
X-Google-Smtp-Source: ABdhPJyIKKyr1RQ/foRBDKa42NKnbq4cRv7/IYbKyYjCLY5Dwe3mPE59xYB7kyc1g3jgTT5Tpx222g==
X-Received: by 2002:a92:41cf:: with SMTP id o198mr5013495ila.262.1604007524840;
        Thu, 29 Oct 2020 14:38:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k8sm3294272ilh.8.2020.10.29.14.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 14:38:44 -0700 (PDT)
Subject: Re: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201015144603.27933-1-bp@alien8.de>
 <20201015144603.27933-2-bp@alien8.de>
 <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
 <20201016083754.GB8483@zn.tnic>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ca53e90a-f4eb-5007-a137-62729e3d74f0@linuxfoundation.org>
Date:   Thu, 29 Oct 2020 15:38:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016083754.GB8483@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 2:37 AM, Borislav Petkov wrote:
> On Thu, Oct 15, 2020 at 11:49:32AM -0600, Shuah Khan wrote:
>> Is there a reason to move "int fd"?
> 
Sorry for a late response.

Okay. Looked odd since it didn't need changing.

> Habit from tip - we sort function-local variables in a reverse fir tree
> order. And since I'm adding cpupower_write_sysfs(), I made them look
> consistent.
> 
>>> +	numwritten = write(fd, buf, buflen - 1);
>>> +	if (numwritten < 1) {
>>> +		perror("write failed");
>>
>> Please add filename to the error message
> 
> 	perror(path);
> 
> or do you want me to build a string with an error message and filename?

Right. It will be great if you can add filename to the message.
> 
>> Please add return check for snprintf, please add a define for
>> "cpu%u/power/energy_perf_bias" since it is hardcoded in
>> read/write functions.
> 
> None of the other snprintf() calls in cpupower do that. Nothing checks
> snprintf() retval and the last part of the sysfs path is a naked string.
> 
> Why is this different?
> 

All of the other ones should be changed as such. Why add more?

thanks,
-- Shuah

