Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA02E2AA8B9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 02:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgKHBQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 20:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHBQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 20:16:42 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360AC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 17:16:42 -0800 (PST)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 44BBE5C0578;
        Sun,  8 Nov 2020 02:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1604798198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLE43ZLA8hp6UktmPV/LfyXxESj/KMWUrBP1RF1ENVY=;
        b=DsC/Mq/XXB7fYqz/csDP6ii7P2ZroqESQeOI2mC9ux6+0qR/orbNMOgN1vhjTJA+VtOB9C
        bFCraFNMPo/XNjKrub1zkWK/TaphtteLuzCx5zQy3p6w16pMDvDWVUIIJrbRiMsDE4s+px
        ijemFdXgotntVsYjiqoCT0X9Zs6/0D4=
MIME-Version: 1.0
Date:   Sun, 08 Nov 2020 02:16:37 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, sjenning@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
In-Reply-To: <20201107165645.1b139b595b6b64feaca61bcb@linux-foundation.org>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201107165645.1b139b595b6b64feaca61bcb@linux-foundation.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <fb776accd14ddb5ec1251a6147a2ff45@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-08 01:56, Andrew Morton wrote:
> On Sat,  7 Nov 2020 16:22:06 +0100 Stefan Agner <stefan@agner.ch> wrote:
> 
>> Most architectures define MAX_PHYSMEM_BITS in asm/sparsemem.h and don't
>> include it in asm/pgtable.h. Include asm/sparsemem.h directly to get
>> the MAX_PHYSMEM_BITS define on all architectures.
>>
>> This fixes a crash when accessing zram on 32-bit ARM platform with LPAE and
>> more than 4GB of memory:
>>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> Mysterious.  Presumably without this include, some compilation unit is
> picking up the wrong value of MAX_PHYSMEM_BITS?  But I couldn't
> actually see where/how this occurs.  Can you please explain further?

Not sure if I got that right, but from what I understand if
MAX_PHYSMEM_BITS is not set in mm/zsmalloc.c it will set
MAX_PHYSMEM_BITS to BITS_PER_LONG. And this is 32-bit, too short when
LPAE is in use...

--
Stefan
