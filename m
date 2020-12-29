Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E452E72ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgL2SMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgL2SMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:12:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=viV2rX2w2i9Hdm9ONoTqTJFY2cOrENzdsrkBg4PRr5I=; b=0WfJGaCXCUrUAefVlFICv4ymRr
        YI+ZcwDuluq7ussSVYQn0C3pjBbJX80DPtG0sMPBHFFJJG+o0s3SIq6KYzsmHVT6XHo/czVUixzw4
        9s/VsFvCRO2fVLyND9RVCr6RKtT1pQ67041UKS3ORBNdzwUS+ukIwsKgVQs2IsEEsOP0J7OGEjBjK
        rrz/IBNvMyOsLYMabG3Y7vl/i3Ro9junBMg+zYBnJuBRhTPK1ez6Vd8AAwdek/owHP0aIWpXEcbZh
        uc+zfHt6BUmHlTMJQmCB7nmnNe04LaVaJkctJmYX8iVDFa5LZwOsNx5QOWdIBq4A/bvDs+73iZV4a
        B1Ji1YFg==;
Received: from [2601:1c0:6280:3f0::2c43]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kuJSo-0003sk-Ry; Tue, 29 Dec 2020 18:11:19 +0000
Subject: Re: [RFC PATCH 2/2] mm: readahead: handle LARGE input to
 get_init_ra_size()
To:     =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
References: <20201220211051.1416-1-rdunlap@infradead.org>
 <20201222173533.c9e28416835d7487b0e28cda@linux-foundation.org>
 <6a595671-20a8-e63f-f3ea-f4749a574efa@infradead.org>
 <d2edfb69-93b4-d938-faf0-5f7c0f1158b9@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f5a6e7b-c779-861e-fde8-409ca8e2541b@infradead.org>
Date:   Tue, 29 Dec 2020 10:11:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <d2edfb69-93b4-d938-faf0-5f7c0f1158b9@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 10:01 AM, Toralf Förster wrote:
> On 12/23/20 2:50 AM, Randy Dunlap wrote:
>>> What motivates this change?  Is there any reason to think this can
>>> happen?
>> Spotted in the wild:
> I run 2 hardened Gentoo systems, a server and a desktop.
> 
> I patched the server with this:
> 
> mr-fox ~ # cat ubsan.patch
> --- linux-5.10.1.orig/mm/readahead.c
> +++ linux-5.10.1/mm/readahead.c
> @@ -310,7 +310,11 @@ void force_page_cache_ra(struct readahea
>   */
>  static unsigned long get_init_ra_size(unsigned long size, unsigned
> long max)
>  {
> -       unsigned long newsize = roundup_pow_of_two(size);
> +       unsigned long newsize;
> +
> +       if (!size)
> +               size = 32;
> +       newsize = roundup_pow_of_two(size);
> 
>         if (newsize <= max / 32)
>                 newsize = newsize * 4;
> 
> 
> 
> and the issue did no longer occurred at the server (5.10.2).
> 
> I did not patched the desktop system and the issue occurred still 3
> times since 21th of december (5.10.2/3)

Yes, that's the patch that I posted on 2020-DEC-22.

Looks like I should submit a real patch for that.

thanks.
-- 
~Randy

