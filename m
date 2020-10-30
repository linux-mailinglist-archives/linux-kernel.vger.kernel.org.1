Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9C29FCFE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 06:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJ3FTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 01:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3FTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 01:19:17 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DF6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 22:19:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CMrFp2wQkz9sSn;
        Fri, 30 Oct 2020 16:19:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604035152;
        bh=g17NLadQlMNHRS3Ht5UYozcNciyiTHzLrix1dfy+teg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZWtYU3oSZTvC/DroUBsF45c5IzIXb9Ywz7/J0acvBPlTOIC27HaTAZBYB1mteG1AQ
         2945SGAhJd2MoV9nM98Q4otxrL2LRV4tWbDT0kphAbPQfHfGMJCCKR2/ra8WxRT/H4
         RCxDdE6kuqmmiO2sF56YnnRqVOhupzboRbIDFiVknOSEl2irTF6sYNo4gJG1NHmTPg
         JYFzBZDiFZxLFdciSH8jFET35mJv/DBAvReGwuzYQqBRlhDNfAiD7Md2MLlbHHUlTt
         9dm+DM5qKPb/27a4kgX/G8IfWfEbB+jtP5CYahjGPAGl0+SNCMcsStY+iEwrWUKdo/
         WdvWpTqgItTfw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
In-Reply-To: <87wnz8vizm.fsf@igel.home>
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu> <87wnz8vizm.fsf@igel.home>
Date:   Fri, 30 Oct 2020 16:19:07 +1100
Message-ID: <87y2jouw8k.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:
> On Okt 01 2020, Christophe Leroy wrote:
>
>> At the time being, an early hash table is set up when
>> CONFIG_KASAN is selected.
>>
>> There is nothing wrong with setting such an early hash table
>> all the time, even if it is not used. This is a statically
>> allocated 256 kB table which lies in the init data section.
>>
>> This makes the code simpler and may in the future allow to
>> setup early IO mappings with fixmap instead of hard coding BATs.
>>
>> Put create_hpte() and flush_hash_pages() in the .ref.text section
>> in order to avoid warning for the reference to early_hash[]. This
>> reference is removed by MMU_init_hw_patch() before init memory is
>> freed.
>
> This breaks booting on the iBook G4.

Do you get an oops or anything?

cheers
