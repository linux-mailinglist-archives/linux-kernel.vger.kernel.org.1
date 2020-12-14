Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3412D917C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 01:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437029AbgLNAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 19:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLNAye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 19:54:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946B1C0613CF;
        Sun, 13 Dec 2020 16:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eXHSUbHUuYdNdh6eTrrSzxWBQFgcFwTnIcLbyddVGcM=; b=Xq5FbABOhc4h8CPpAYOl5jrWkG
        K/8VvDrguxThk9MW0Q6cp1qWjEkIVo47hR7n3xzDnJWtukgpThX71EjRuS02fIZwKldt4qlNDqYRW
        oiXimXtskggcIY/mnYhHWk/C4wNLPsSHwqJBJ6EJs/L5opqiK06upHb6+260jUfVQNrrvM6qijnkM
        zXmcXVxjdUagu971UyF34xpHq1Fwzd5cfXpr2jRj5af9EXQt/jEso8PlVYe8E3Z8Fs3V+Fm2F3NJ3
        p4rUaqCvR6++cobMFALadL5JXRKhHJa2hpxjYosFfHhI14ZOPmrIuE+byxnrkAa8tr64IAteUuXOV
        LW1Vhk6Q==;
Received: from [2601:1c0:6280:3f0::1494]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1koc7c-0004n5-6H; Mon, 14 Dec 2020 00:53:52 +0000
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20201211190335.16501-1-rdunlap@infradead.org>
 <CAHp75Vcckb5NA=tc5s5p_qzYE2qhJOT0vhCtfKhT_eqZe+PgXw@mail.gmail.com>
 <ec8e703f-e1ea-1253-edc9-311f0ee3e8fd@infradead.org>
 <CAHp75Vf-QcdL+FOd=8fUUQ0+ORC-RVKG+3Yqrar1J7wZMSDF+A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3d5a5c8f-4bb1-6205-ae76-354473d59a18@infradead.org>
Date:   Sun, 13 Dec 2020 16:53:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf-QcdL+FOd=8fUUQ0+ORC-RVKG+3Yqrar1J7wZMSDF+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/20 11:07 AM, Andy Shevchenko wrote:
> On Sat, Dec 12, 2020 at 7:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 12/12/20 5:24 AM, Andy Shevchenko wrote:
>>> On Fri, Dec 11, 2020 at 9:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> ...
> 
>>>> +#ifdef CONFIG_PM_SLEEP
>>>>  static int surface_gpe_suspend(struct device *dev)
>>>
>>> Perhaps __maybe_unused ?
>>
>> Yes, I am aware of that option.
>> I don't know why it would be preferred though.
> 
> Here [1] is the rationale behind annotation vs. ifdeffery.
> 
> [1]: https://lore.kernel.org/patchwork/patch/732981/
>
Thanks for the link.  I'll send a v2.

Could we add that to the Linux BKP (Best Known Practices)
document?


-- 
~Randy

