Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3259D2DCFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgLQKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:45:38 -0500
Received: from www381.your-server.de ([78.46.137.84]:42726 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=L+YdKSAitreUN4tqczxAQRC86va3RNnQmUA8K2tUr9o=; b=KSqYBT8c0LlWwImBD2JkW0mRIY
        /bFTo0j15/zPNUlAloxgBKZgNGzVtAYJD4b46Q4R/2RO+HgPC0A8wjkHXlc+UkryLtfA1aPI3WkNr
        /Z80VlsPTMZGVPzXxab+Vz5/lUqXJgMa6WyRCFAIVF7X3TVzytSluaREPzEdH6xXOknCAkkGZcBWP
        JftleKJ/uH+v28lO7HIgMpfLVqPVkp7Ra153SYMUfajUtruFYQgT/PuH8Ix0ixRCRAMIULcKOBLZ8
        5c6T8AmKbjsCNiLvkTpJ/czeWMULK+lfDcLSIkVi+9Bl+sMutvo4YvvbS/hSDUpb8vrD84dlAnqKx
        bui3/9+Q==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kpqln-000BAI-TP; Thu, 17 Dec 2020 11:44:27 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kpqln-0006Dm-Ma; Thu, 17 Dec 2020 11:44:27 +0100
Subject: Re: [PATCH v1 ] ALSA: core: memalloc: add page alignment for iram
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Robin Gong <yibin.gong@nxp.com>, perex@perex.cz, tiwai@suse.com,
        akpm@linux-foundation.org, xiang@kernel.org,
        pierre-louis.bossart@linux.intel.com, gustavoars@kernel.org,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <1608221747-3474-1-git-send-email-yibin.gong@nxp.com>
 <05c824e5-0c33-4182-26fa-b116a42b10d6@metafoo.de>
 <s5h5z50n4dd.wl-tiwai@suse.de> <s5h1rfon3ho.wl-tiwai@suse.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <01cbc568-d476-5d19-9131-ed1ee24385c9@metafoo.de>
Date:   Thu, 17 Dec 2020 11:44:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <s5h1rfon3ho.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26019/Wed Dec 16 15:36:02 2020)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 11:14 AM, Takashi Iwai wrote:
> On Thu, 17 Dec 2020 10:55:42 +0100,
> Takashi Iwai wrote:
>> On Thu, 17 Dec 2020 10:43:45 +0100,
>> Lars-Peter Clausen wrote:
>>> On 12/17/20 5:15 PM, Robin Gong wrote:
>>>> Since mmap for userspace is based on page alignment, add page alignment
>>>> for iram alloc from pool, otherwise, some good data located in the same
>>>> page of dmab->area maybe touched wrongly by userspace like pulseaudio.
>>>>
>>> I wonder, do we also have to align size to be a multiple of PAGE_SIZE
>>> to avoid leaking unrelated data?
>> Hm, a good question.  Basically the PCM buffer size itself shouldn't
>> be influenced by that (i.e. no hw-constraint or such is needed), but
>> the padding should be cleared indeed.  I somehow left those to the
>> allocator side, but maybe it's safer to clear the whole buffer in
>> sound/core/memalloc.c commonly.
> That said, something like below (totally untested).
> We might pass the pass-aligned size to dmab->bytes field instead of
> keeping the original value, too.

We'd need this for those APIs that also pass the size to the free() 
function. Like dma_free_coherent() and free_pages_exact(), but maybe 
those round up internally as well.

I had a quick look and I could not find any place were the code relies 
on the requested buffer size being stored in dmab->bytes. In fact we 
already reuse the buffer if  there is an allocated buffer that is larger 
than the requested buffer (See snd_pcm_lib_malloc_pages), so this should 
be OK.

>
>
> Takashi
>
> ---
> --- a/sound/core/memalloc.c
> +++ b/sound/core/memalloc.c
> @@ -126,6 +126,7 @@ static inline gfp_t snd_mem_get_gfp_flags(const struct device *dev,
>   int snd_dma_alloc_pages(int type, struct device *device, size_t size,
>   			struct snd_dma_buffer *dmab)
>   {
> +	size_t orig_size = size;
>   	gfp_t gfp;
>   
>   	if (WARN_ON(!size))
> @@ -133,6 +134,7 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
>   	if (WARN_ON(!dmab))
>   		return -ENXIO;
>   
> +	size = PAGE_ALIGN(size);
>   	dmab->dev.type = type;
>   	dmab->dev.dev = device;
>   	dmab->bytes = 0;
> @@ -177,7 +179,8 @@ int snd_dma_alloc_pages(int type, struct device *device, size_t size,
>   	}
>   	if (! dmab->area)
>   		return -ENOMEM;
> -	dmab->bytes = size;
> +	memset(dmab->area, 0, size);
> +	dmab->bytes = orig_size;
>   	return 0;
>   }
>   EXPORT_SYMBOL(snd_dma_alloc_pages);


