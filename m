Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6812A2DCFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgLQLAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 06:00:09 -0500
Received: from www381.your-server.de ([78.46.137.84]:55782 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLQLAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=RRx/h839wV5nOIRm9dajsmuYgNt4G4OBmOVQ8v0tdwA=; b=iJy6U5pHViaL1l/fUY3FirDZZe
        Vr/tg18GLYNHvsn8hwZa/WNCo/ODBKRudq3c+DtSjJgBaAfkBa0Tsytkmqq3lnG0b0h/1SYCFG9Yp
        Jj9F+Zk6ZsOCcQ2BgG37dLl/DK1T/h174cJ9a6kRGDCDKcBwJM2RXOQCqfI1KX616K1+jPlY/XhJE
        KKvkCtg+VffNLEF85dEX2m1UgR8aVmg+kc+0eFoF4v0+mssP6yB8EWJT28p0hmWIaD8dnHBZ0ZgsC
        eIqGiUGEil5u2Lr647pZXR7MR/WYZcu3LG+lZXziTWIjuZ5d00oC7MZocpPIjkHiY5NipKkMIKNNZ
        kz+4BrtA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kpr0G-000DHr-HM; Thu, 17 Dec 2020 11:59:24 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kpr0G-0004yH-9J; Thu, 17 Dec 2020 11:59:24 +0100
Subject: Re: [PATCH v1 ] ALSA: core: memalloc: add page alignment for iram
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        xiang@kernel.org, Robin Gong <yibin.gong@nxp.com>,
        akpm@linux-foundation.org
References: <1608221747-3474-1-git-send-email-yibin.gong@nxp.com>
 <05c824e5-0c33-4182-26fa-b116a42b10d6@metafoo.de>
 <s5h5z50n4dd.wl-tiwai@suse.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <70074f62-954a-9b40-ab4a-cb438925060c@metafoo.de>
Date:   Thu, 17 Dec 2020 11:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <s5h5z50n4dd.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26019/Wed Dec 16 15:36:02 2020)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 10:55 AM, Takashi Iwai wrote:
> On Thu, 17 Dec 2020 10:43:45 +0100,
> Lars-Peter Clausen wrote:
>> On 12/17/20 5:15 PM, Robin Gong wrote:
>>> Since mmap for userspace is based on page alignment, add page alignment
>>> for iram alloc from pool, otherwise, some good data located in the same
>>> page of dmab->area maybe touched wrongly by userspace like pulseaudio.
>>>
>> I wonder, do we also have to align size to be a multiple of PAGE_SIZE
>> to avoid leaking unrelated data?
> Hm, a good question.  Basically the PCM buffer size itself shouldn't
> be influenced by that (i.e. no hw-constraint or such is needed), but
> the padding should be cleared indeed.  I somehow left those to the
> allocator side, but maybe it's safer to clear the whole buffer in
> sound/core/memalloc.c commonly.

What I meant was that most of the APIs that we use to allocate memory 
work on a PAGE_SIZE granularity. I.e. if you request a buffer that where 
the size is not a multiple of PAGE_SIZE internally they will still 
allocate a buffer that is a multiple of PAGE_SIZE and mark the unused 
bytes as reserved.

But I believe that is not the case gen_pool_dma_alloc(). It will happily 
allocate those extra bytes to some other allocation request.

That we need to zero out the reserved bytes even for those other APIs is 
a very good additional point!

I looked at this a few years ago and I'm pretty sure that we cleared out 
the allocated area, but I can't find that anymore in the current code. 
Which is not so great I guess.

