Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D99D2AB41D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgKIJ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:57:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33264 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgKIJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id v4so8056928edi.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 01:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HB7PqyM3M8LN/TXDaTwoFfWeBEek1r/7MQX0qVK33ZA=;
        b=mFBnGxPKJEZUpdMZUAzEcxmmPPY2r7xrkLwRuKcyDdEXuOAU7c7iN/nRQ7hKCIblIw
         9753EdaOULf8kvjkjDPgLEGCA2rDRwPAFq3DbPAAKUgbnJPGkUU95/2Qx78u00nQRGLD
         CIi9sKensqBb8syXvzJSwAqS+u6rDNR2ZIYoX8OnmZck3PveL5Z/i59P45RlrkkQvzrs
         XxilbttPW5S2BX9BEaaP/KBClLeZJ+CHDTdenaHGwGeKJGgcJHacSsnoFvTDlZgZDvTi
         qiIy/sZPafTNN+6pvYcuDoqLyr/KIQG1D/t9Q5/GuuOpUOYgoKLL7TJ8OxLYKucd+0lK
         QtRQ==
X-Gm-Message-State: AOAM531oIFUWS0J/e7pR+auYYvdiJjMhsGuKrAvDRxMcW+Thwd8NGEGT
        H2IsCRLgpPlEoRnoX5CiUM0=
X-Google-Smtp-Source: ABdhPJyLfaF3JpRuwgXZ1sPIapKan1J0yKoWAJEzSTpzFAarTCeypxdZojbXemwnjd0jAlJWWv/c9w==
X-Received: by 2002:a05:6402:947:: with SMTP id h7mr14490724edz.85.1604915842716;
        Mon, 09 Nov 2020 01:57:22 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id la9sm8300736ejb.121.2020.11.09.01.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 01:57:21 -0800 (PST)
Subject: Re: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@aculab.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
 <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
Date:   Mon, 9 Nov 2020 10:57:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 11. 20, 17:06, Andy Shevchenko wrote:
> On Fri, Nov 6, 2020 at 5:35 PM David Laight <David.Laight@aculab.com> wrote:
>>
>> From: Andy Shevchenko
>>> Sent: 06 November 2020 14:36
>>>
>>> There are few places when GENMASK() or BIT() macro is suitable and makes code
>>> easier to understand.
>>>
>> ...
>>> -     if ((d & ~0xff) == BRL_UC_ROW) {
>>> -             if ((ch & ~0xff) == BRL_UC_ROW)
>>> +     if ((d & ~GENMASK(7, 0)) == BRL_UC_ROW) {
>>> +             if ((ch & ~GENMASK(7, 0)) == BRL_UC_ROW)
>>>                        return d | ch;
>>
>> Do you really think that makes it more readable?
> 
> Yes. Because this tells explicitly how many bits are used for metadata
> vs. data.

No, because ~0xff is clearly what it is. GENMASK(7, 0) is:
1) longer to read & parse by brain with result: "GENMASK undefined"
2) terrible in this particular use case

Another instance of an even worse switch:
-		if (arg & ~0x77)
+		if (arg & ~(GENMASK(6, 4) | GENMASK(2, 0)))

OTOH, the switch to BIT is legit in all cases except the comparisons 
with keycode:
-	if (keycode > 127)
+	if (keycode >= BIT(7))
-		if (keycode < 128) {
+		if (keycode < BIT(7)) {

That's horrid and non-sense too.

sorry,
-- 
js
suse labs
