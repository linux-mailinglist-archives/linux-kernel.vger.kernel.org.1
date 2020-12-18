Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A212DE7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbgLRRAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgLRRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:00:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B32C061282
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=+xN9GQRorrUGy150P3shy7r3NADexgIi08+DtMTl7Js=; b=g3Q59fqOx9DsUxJUKJorQaUhot
        97VRI3w+Yrvz6gfvgXBeIg2tY0xSmaj2UyCdY5gZc09+Zya1TiyHMwn4Dqwanz0kXbDBEr0lgyq+I
        q2scXZvRREVhcBm4UTnz+NPIn3gud21neOLzO7c9nKU0IJHvKuzSCN1eeao0MMXx47JQhhOgY8FNa
        aXk5kqfHjVGkwKjkOdOD+UJjNrnbvGwsuanKMspWzolqQloccEVVescD3nMxVK8r/MR05aM7FO51I
        odCu6Xr9hLufdyG+ose8ND27YtuJ+IlNMJe9xiy6lIWFCsFAxOTKygvWBzBtjTKprfmS5NS1edSav
        OOleA0fA==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kqJ6I-0006FS-KV; Fri, 18 Dec 2020 16:59:30 +0000
Subject: Re: [PATCH] add pin memory method for checkout add restore
To:     hejingxian <hejingxian@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Hushiyuan <hushiyuan@huawei.com>,
        "hewenliang (C)" <hewenliang4@huawei.com>
References: <a68df79992c04bbf8167748dbeca1fcc@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cff4fee2-af5a-c77c-c085-7a2aaa6c40ff@infradead.org>
Date:   Fri, 18 Dec 2020 08:59:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a68df79992c04bbf8167748dbeca1fcc@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/18/20 6:25 AM, hejingxian wrote:
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 26956c0..73af2f0 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -560,3 +560,10 @@ config RANDOM_TRUST_BOOTLOADER
>        booloader is trustworthy so it will be added to the kernel's entropy
>        pool. Otherwise, say N here so it will be regarded as device input that
>        only mixes the entropy pool.
> +
> +config PIN_MEMORY_DEV
> +       bool "/dev/pinmem character device"
> +       depends PIN_MEMORY

	depends on

> +       default n

Don't need default n, it's already the default.

> +       help
> +       pin memory driver

Better help text, please. Also, it should be indented by 2 (more) spaces.


thanks.
-- 
~Randy

