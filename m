Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658262A781B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgKEHkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:40:01 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38364 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEHkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:40:00 -0500
Received: by mail-ej1-f65.google.com with SMTP id za3so1195216ejb.5;
        Wed, 04 Nov 2020 23:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/PoaxSQdQ0qc6MtVRWROcDbBKMBfI1ym4uPU4Lv069A=;
        b=Q8khOIeRSL5Po8/WTjKtcVgVmzqqH6erORbHN5YaN+dCWQdF7oKR8NhU3lMDmN/ydb
         3/uiH/SLOoZGK0LGmJci8tdRG7sconoo7laLeRA46Q9U0+LxXhu+S/SGCDzPbz7EkmQe
         UBSrH4cTnEtqVlAUQ0eBwQvwsWNAfYv67H0cVbNTFD+zbe8hMe+hlpYSebmvH6EoQTDN
         6//xr/HHtTccJJYgfdvXfxmNCZidH7OunD+TSgh4nMGqoX5oTVJdSh/sku1JveAImJS6
         wsvD7324LUvsb3KiugYn5ezWiYreXz1DGvQ7jvhqaRNCO+/vw/vAHviDoprpp1uPVDd6
         7ulw==
X-Gm-Message-State: AOAM533cVVTxGd3r4nKKweHYSsaUi+owwzxZ1VgEjXgu0FGAbc9CB/Wu
        p5YIbRk9Xh83UHg8S5MRzNZtPgBVqQc=
X-Google-Smtp-Source: ABdhPJwEt20G0n1D11J5pSfi2tvzsZnG0AfTtqEF0ANZdbe1XXAbrjEon+3CwZuTF7sgXsf/suDDWQ==
X-Received: by 2002:a17:906:7844:: with SMTP id p4mr1076205ejm.26.1604561998177;
        Wed, 04 Nov 2020 23:39:58 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id s3sm422116ejv.97.2020.11.04.23.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 23:39:57 -0800 (PST)
Subject: Re: [PATCH 34/36] tty: serial: pmac_zilog: Make disposable variable
 __always_unused
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, linux-serial@vger.kernel.org
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-35-lee.jones@linaro.org>
 <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <e027b620-56f8-7d8b-84ff-54839f94a4c7@kernel.org>
Date:   Thu, 5 Nov 2020 08:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <445a6440-b4c8-4536-891b-0cefc78e5f57@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 20, 8:04, Christophe Leroy wrote:
> 
> 
> Le 04/11/2020 à 20:35, Lee Jones a écrit :
>> Fixes the following W=1 kernel build warning(s):
>>
>>   drivers/tty/serial/pmac_zilog.h:365:58: warning: variable ‘garbage’ 
>> set but not used [-Wunused-but-set-variable]
> 
> Explain how you are fixing this warning.
> 
> Setting  __always_unused is usually not the good solution for fixing 
> this warning, but here I guess this is likely the good solution. But it 
> should be explained why.

Or, why is the "garbage =" needed in the first place? read_zsdata is not 
defined with __warn_unused_result__. And even if it was, would 
(void)!read_zsdata(port) fix it?

>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linux-serial@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> ---
>>   drivers/tty/serial/pmac_zilog.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/pmac_zilog.h 
>> b/drivers/tty/serial/pmac_zilog.h
>> index bb874e76810e0..968aec7c1cf82 100644
>> --- a/drivers/tty/serial/pmac_zilog.h
>> +++ b/drivers/tty/serial/pmac_zilog.h
>> @@ -362,7 +362,7 @@ static inline void zssync(struct uart_pmac_port 
>> *port)
>>   /* Misc macros */
>>   #define ZS_CLEARERR(port)    (write_zsreg(port, 0, ERR_RES))
>> -#define ZS_CLEARFIFO(port)   do { volatile unsigned char garbage; \
>> +#define ZS_CLEARFIFO(port)   do { volatile unsigned char 
>> __always_unused garbage; \
>>                        garbage = read_zsdata(port); \
>>                        garbage = read_zsdata(port); \
>>                        garbage = read_zsdata(port); \
>>

thanks,
-- 
js
