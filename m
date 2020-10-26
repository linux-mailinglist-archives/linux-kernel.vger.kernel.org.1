Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F3C298A39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 11:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769183AbgJZKRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 06:17:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57576 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422436AbgJZKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 06:17:20 -0400
Received: from [IPv6:2a00:23c5:9900:2d00:fa7c:ed23:2f0a:448d] (unknown [IPv6:2a00:23c5:9900:2d00:fa7c:ed23:2f0a:448d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 49C851F44F40;
        Mon, 26 Oct 2020 10:17:18 +0000 (GMT)
Subject: Re: Build regressions/improvements in v5.10-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        Joe Perches <joe@perches.com>
References: <20201026081811.3934205-1-geert@linux-m68k.org>
 <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
From:   Christopher Obbard <chris.obbard@collabora.com>
Message-ID: <ed39a579-62c9-de88-3550-f21382b804a8@collabora.com>
Date:   Mon, 26 Oct 2020 10:17:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 26/10/2020 09:48, Geert Uytterhoeven wrote:
> On Mon, Oct 26, 2020 at 10:46 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.10-rc1[1] compared to v5.9[2].
>>
>> Summarized:
>>    - build errors: +3/-7
>>    - build warnings: +26/-28
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3650b228f83adda7e5ee532e2b90429c03f7b9ec/ (all 192 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
>>
>>
>> *** ERRORS ***
>>
>> 3 error regressions:
>>    + /kisskb/src/arch/um/kernel/skas/clone.c: error: expected declaration specifiers or '...' before string constant:  => 24:16

For me, reverting commit 33def8498fdde180023444b08e12b72a9efed41d 
("treewide: Convert macro and uses of __section(foo) to 
__section("foo")") fixed this compile error and one other introduced by 
the same patch.
Unfortunately I wasn't able to come up with a fix for that, but I have 
CC the author of that patch.

Thanks!
Christopher Obbard

> 
> um-all{mod,yes}config
> 
>>    + error: hotplug-memory.c: undefined reference to `of_drconf_to_nid_single':  => .text+0x5e0)
> 
> powerpc-gcc5/pseries_le_defconfig+NO_NUMA
> 
>>    + {standard input}: Error: inappropriate arguments for opcode 'adc':  => 170
> 
> arc-gcc10/axs101_defconfig
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
