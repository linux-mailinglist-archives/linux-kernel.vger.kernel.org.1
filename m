Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6B1AFD49
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 21:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDSTLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 15:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:11:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5655C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 12:11:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so9416949wrs.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FI/d5vUanPoY/w9CFz9ztVpckNOs2yAH7yeEI0jwxxk=;
        b=TeAKEJzXgkKQhogSLGSn3QaBpFFxEN1BViaBJF/CftadXJ2I3zyKKZx0gMaO2FScIE
         2NqxB2LNRovAFP/SWkRHiY44djHp4V1CKXU8CzD77GKxQA2AgVA9PuB9xxXYVAYZznI6
         IufvgdMwOmyu7zNnNcerNjs3pyrlT0wIX1gMjOf20IDehbLEq1/QUD2BH5KSPGrbmPpx
         pFZstrOVagYMhdr880HK8V0g8ZUcG8IIObqAFAKyYyvPWXmjYjdBMozf2wW1uZnWxAW0
         S8Da0bZNpOOb/PBOedvafNDBingCq3Drfw8XOXRZD0l85k09dEQ8tySumOfWezGaFVJ6
         k51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FI/d5vUanPoY/w9CFz9ztVpckNOs2yAH7yeEI0jwxxk=;
        b=D6TEq6IuQNef40mzEJtnqNg4eDluTzLdhIkBL5WzC/Jf4ZExIbtx+ztyRP2aCFI/xo
         5acrqDA2NkSU+A3ud0k41TlzX1DmRR+j6hGb3niNrIgtBX0H8hsSpibkGJaDP3OWY4zg
         fAeQ8veMTFE2zsnIN0cZjq1iFCMITIS8UGstrZAz+RsFpS4i+1IByv4H2QON7EI/DoWT
         SUHWbbgO9U4qdVY1HmBMF5XjKOEVqEizgyPoJH9cHDhBlgyLkUA+J/PCpHp+6/dW91Fy
         xSS6+LZw0JtkyQU/WfMT8wZzRAVrMFttN+jzdU+WDc/Yyp+m8XI047604CfSqCy3RXmr
         rLwA==
X-Gm-Message-State: AGi0PubY32qWHrpAzY+pYnPyrZtoWr3UGW6OSYW3581BkMKIeKz3nnyl
        vlUiBpVQYMl0JyLgpNZtpfhDA1W0
X-Google-Smtp-Source: APiQypJ7QXh3q+4eyBwvhIYkqxsNrT160nQ7vd8xptJcjjP5IyLErVTGIC/rUAmErJovrneYnG4Low==
X-Received: by 2002:adf:b6a8:: with SMTP id j40mr15692991wre.255.1587323512211;
        Sun, 19 Apr 2020 12:11:52 -0700 (PDT)
Received: from [192.168.43.227] (188.29.165.57.threembb.co.uk. [188.29.165.57])
        by smtp.gmail.com with ESMTPSA id x6sm10940118wrg.58.2020.04.19.12.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 12:11:51 -0700 (PDT)
Subject: Re: [PATCH] staging: vt6656: Refactor the vnt_ofdm_min_rate function
To:     Stefano Brivio <sbrivio@redhat.com>,
        Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        "John B . Wyatt IV" <jbwyatt4@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200418134553.6415-1-oscar.carter@gmx.com>
 <20200419195534.1463ddcd@elisabeth>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <1c118ba5-627e-17ee-7f21-100e2eb67cf1@gmail.com>
Date:   Sun, 19 Apr 2020 20:11:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200419195534.1463ddcd@elisabeth>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

On 19/04/2020 18:55, Stefano Brivio wrote:
> Hi Oscar,
> 
> On Sat, 18 Apr 2020 15:45:53 +0200
> Oscar Carter <oscar.carter@gmx.com> wrote:
> 
>> Replace the for loop by a ternary operator whose condition is an AND
>> bitmask against the priv->basic_rates variable.
>>
>> The purpose of the for loop was to check if any of bits from RATE_54M to
>> RATE_6M was set, but it's not necessary to check every individual bit.
>> The same result can be achieved using only one single mask which
>> comprises all the commented bits.
<snip>

>>
>> -int vnt_ofdm_min_rate(struct vnt_private *priv)
>> +bool vnt_ofdm_min_rate(struct vnt_private *priv)
>>   {
>> -	int ii;
>> -
>> -	for (ii = RATE_54M; ii >= RATE_6M; ii--) {
>> -		if ((priv->basic_rates) & ((u16)BIT(ii)))
>> -			return true;
>> -	}
>> -
>> -	return false;
>> +	return priv->basic_rates & GENMASK(RATE_54M, RATE_6M) ? true : false;
> 
> priv->basic_rates & GENMASK(RATE_54M, RATE_6M) is already true if
> non-zero and false otherwise. Note that I haven't checked if the
> rest is correct.
> 
Yes only 1 or more needs to be true and it is false when none present.

I have run-time checked the patch and it does function as before.

Regards

Malcolm.
