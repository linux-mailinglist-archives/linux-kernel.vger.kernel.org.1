Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABE42AB528
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKIKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:41:36 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46875 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgKIKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:41:36 -0500
Received: by mail-ej1-f65.google.com with SMTP id w13so11490852eju.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 02:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iWcFzGCTmHsyXJXpqz9g/RyszlIitmDX077/Y3VFAtU=;
        b=EYUbtUrXjIv8MByv9DsZ9r9mTryNkhV6F0pOrIahg9irPcIJczCuw2MrcRK8qDI5fP
         KCyToOXG2O0816wOlKSp7mnJf6xCK7hGbdYP/E9UgvxqHqdx6QxBrKZ5jwZS8u7gX2Jh
         im3DNyoo4IXQUDUuwx4GaPc01DnoWX0nDjkoqfzNCgTlNBnrTVlb7RkYygwU7Y4gmhbp
         Kr2tuV1Xmawc5rNTAFcAcJQAJZprb317toZM26zCJA+vWfHolyTi2OZCu8oP2CMBntAi
         01M0jYqcLJlzUrnVSWA+Ksges4uQGHu/gt1lExjRDs7h5t6+Ima+cG5W2fGg61odtEYW
         O4yg==
X-Gm-Message-State: AOAM531jHSrzzl0fgHcsKhnQLmPm+eNKUZBaQ+b39+keKtDdv92qr2p9
        16+bNiy4BmiHmOSucbKotZM=
X-Google-Smtp-Source: ABdhPJwpOa6vHmVZkJ2mpXWkuyrEP964pcD9VT7jyzhW6QaKmxA7I5U9qrfR5Hkyjlk2SvQPPaqwZQ==
X-Received: by 2002:a17:906:7c54:: with SMTP id g20mr9462470ejp.105.1604918493399;
        Mon, 09 Nov 2020 02:41:33 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id w3sm8499016edt.84.2020.11.09.02.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 02:41:32 -0800 (PST)
Subject: Re: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
 <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
 <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
 <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
 <20201109102759.GT4077@smile.fi.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0bbc9282-3655-26f3-468f-4dccd7ded741@kernel.org>
Date:   Mon, 9 Nov 2020 11:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109102759.GT4077@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 11. 20, 11:27, Andy Shevchenko wrote:
> On Mon, Nov 09, 2020 at 12:10:27PM +0200, Andy Shevchenko wrote:
>> On Mon, Nov 9, 2020 at 11:57 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>> On 06. 11. 20, 17:06, Andy Shevchenko wrote:
> 
> ...
> 
>>> sorry,
>>
>> Consider this then as RFC.
>> What about the rest of the series?
> 
> I got the answer, thanks!
> So, I will drop the first patch and resend the rest with your Ack.

As I wrote the BIT pieces are mostly fine too…

-- 
js
suse labs
