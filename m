Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF332AA91B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 05:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKHEyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 23:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgKHEyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 23:54:17 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C9CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 20:54:17 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e21so4150913pgr.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F1OfcUiT8PCqG13bu2Daw7S9aBJED13dekqt0FlSaVI=;
        b=D4/QPIBAxCnbpRD0Lqy33tmcROAoXd7FnBEzg+ti4r0y08uco04p3tTGZlsXU42KNl
         bj8M99/gF9xlCReURvUregYPOfO1X4jRl4xxYGBfljuMv9oOHzXJF6BcjVBI3xK58S0A
         jiJnUNIsIuENzdXeZ3Qwyx91L2vkVj2P9KNIp+PYyINP0Ex5KywYwXV1vzm+2zE9XqCk
         1fl28ovs5AAHLjcSkEGcRPbI9lwX44l6RBR/l6H5wjqP+b5VW4IuXOIDlpx8UnoDwamy
         0z4+itJfsam2DOV8GAHVjKJyz47jq/JAfpXd6JXiTYBnSILeqx3NIQsS9BOysBrdHcKz
         2phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F1OfcUiT8PCqG13bu2Daw7S9aBJED13dekqt0FlSaVI=;
        b=KfBsmB/IOYY4HZu8DFmlqA2F3PJVGyXTTE4E94CxbWRWGMHZEJzqaJcjEXZxFCJqfq
         fOd8dR6biEuLBbTRXfr6efGsh9BLauEzIlO3Dw441iepw8ON0aYcTtR0BhFajWqWOn0E
         YcQ4Y2thpCC/gqfJdx62p8P7VPMZIFEXK/v2Bvnf/B58sTxUVJ61oJGInanmHcV2GH5l
         hgqZzetN8qKJymlHV0/0vZ76Cr66zdZHCoIt3xiSbTi/P1k3+grSKBdv41MsMC/nYT8F
         VQpmuxEsg2TFBW3VvCMZyCi8E+nU9uRwHV5CCBPVPvEDQGS2xyKl7ypGm4HgJYc0gez/
         Sg0A==
X-Gm-Message-State: AOAM533pUixl38kcpNLjKPIQRaenNB6lQt/sDHySSRQWc1XGTQhPmBfo
        jJJOG1BmOAyPVtjhIQz6Se1tVMX+SVo=
X-Google-Smtp-Source: ABdhPJzr0We/2944Bv+0jqST+vRUDGQ0+D651QrDBbeZE29JDnUkIiysug8N4SqQ0Qfh1jHJS+VPlA==
X-Received: by 2002:a63:d54c:: with SMTP id v12mr8343961pgi.429.1604811256496;
        Sat, 07 Nov 2020 20:54:16 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y10sm12205852pjr.2.2020.11.07.20.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 20:54:15 -0800 (PST)
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
To:     Stefan Agner <stefan@agner.ch>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, sjenning@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201107165645.1b139b595b6b64feaca61bcb@linux-foundation.org>
 <fb776accd14ddb5ec1251a6147a2ff45@agner.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <29cb13a4-e10d-a394-3c00-1d7721a2dc0a@gmail.com>
Date:   Sat, 7 Nov 2020 20:54:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <fb776accd14ddb5ec1251a6147a2ff45@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2020 5:16 PM, Stefan Agner wrote:
> On 2020-11-08 01:56, Andrew Morton wrote:
>> On Sat,  7 Nov 2020 16:22:06 +0100 Stefan Agner <stefan@agner.ch> wrote:
>>
>>> Most architectures define MAX_PHYSMEM_BITS in asm/sparsemem.h and don't
>>> include it in asm/pgtable.h. Include asm/sparsemem.h directly to get
>>> the MAX_PHYSMEM_BITS define on all architectures.
>>>
>>> This fixes a crash when accessing zram on 32-bit ARM platform with LPAE and
>>> more than 4GB of memory:
>>>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>
>> Mysterious.  Presumably without this include, some compilation unit is
>> picking up the wrong value of MAX_PHYSMEM_BITS?  But I couldn't
>> actually see where/how this occurs.  Can you please explain further?
> 
> Not sure if I got that right, but from what I understand if
> MAX_PHYSMEM_BITS is not set in mm/zsmalloc.c it will set
> MAX_PHYSMEM_BITS to BITS_PER_LONG. And this is 32-bit, too short when
> LPAE is in use...

You should probably include this in your commit message since that is
describing the bug and then your fix makes complete sense.
-- 
Florian
