Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D72A83B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKEQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:41:34 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46022 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:41:34 -0500
Received: by mail-ej1-f66.google.com with SMTP id dk16so3504114ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HgRzve+2l9mDjVRLSxnK1EHqmXzp2uhyn7xWM0S++hI=;
        b=sjrLbC/JxqHgsB/7Dsfvw8wy9LF2lhsuxDAXzSq3P5No1KM2etguzvKug2flwrhnc2
         rXd6qZBoRpRFyJkPSRXo5Q/O7DKgV1tqulXXyPX9c0Grxy12xEAZshNLVJ8QxVEYTz0b
         IJT4wrfB0JxSMfCvNuYqiTpCXdcDgTlckfs8c6N78wrHNXSqq+0KZDCuhg7goHV0xqCk
         9frKWcrr/ApNcxv4NZ4RoH/tMoCln3r1HW7UGjHifNqb8H0Z8B5ptwXqVKPonvGiRSMn
         39762XIC0oqp7ywtYcMfpV3y6A5FlmJLM4swGXs19l3OOlq0HaT4spbCgy0vSCBB0Gl5
         8JlQ==
X-Gm-Message-State: AOAM533amAu+J5iA613Zs+UXjfaAIW1GDkRW92v1VBXdm2HOS5HL4/Nf
        GYpXAI/lCd551BO0zVWWUlc=
X-Google-Smtp-Source: ABdhPJwJP63YQ7zo+IzG0WbNVOgAfIZzmVXwPsC1ys8UAQfx8GjOx5zGSW5Pz7REJO0daxv3r/+qMA==
X-Received: by 2002:a17:906:400c:: with SMTP id v12mr3295120ejj.387.1604594492326;
        Thu, 05 Nov 2020 08:41:32 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id x2sm1252676ejb.86.2020.11.05.08.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:41:31 -0800 (PST)
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
To:     David Laight <David.Laight@ACULAB.COM>,
        Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "paulkf@microgate.com" <paulkf@microgate.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
 <6515b9ff5a9343f5a713e337f41450cc@AcuMS.aculab.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <f9d933e5-1272-b479-b09a-f46f4a179905@kernel.org>
Date:   Thu, 5 Nov 2020 17:41:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <6515b9ff5a9343f5a713e337f41450cc@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 20, 12:04, David Laight wrote:
>>>> And the loop can be turned into ndelay:
>>>>
>>>>           /*
>>>>            * Force at least 170ns delay before clearing
>>>>            * reset bit. Each read from LCR takes at least
>>>>            * 30ns so 10 times for 300ns to be safe.
>>>>            */
>>>>           for(i=0;i<10;i++)
>>>>                   readval = *MiscCtrl;
>>>
>>> Again, since I can't test this, I do not want this patch to contain
>>> any functional changes.  AFAIC, the 10 register reads must still
>>> happen after this patch is applied.
> 
> You can't use ndelay(); the writes can get posted so can appear
> much closer together by the time they get to the actual hardware.

Ah, indeed, this is on PCI. One read would need to stay before ndelay 
then. But given it completely goes away, no need to worry. Thanks for 
heads up.

-- 
js
suse labs
