Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889672A00D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgJ3JJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:09:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51487 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3JJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:09:52 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CMxMx5vhpz1qs0Y;
        Fri, 30 Oct 2020 10:09:49 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CMxMx4dgTz1qsWc;
        Fri, 30 Oct 2020 10:09:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id wAF-Y83BoLiQ; Fri, 30 Oct 2020 10:09:48 +0100 (CET)
X-Auth-Info: 4AtbbN48/aZMiOAZFS4xlKpOKabhtpCSh7fP3AYSsvWeDjdfAfWjfqVMzEwh5No5
Received: from igel.home (ppp-46-244-190-51.dynamic.mnet-online.de [46.244.190.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 30 Oct 2020 10:09:48 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 2DAC62C089E; Fri, 30 Oct 2020 10:09:48 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
        <87wnz8vizm.fsf@igel.home> <87y2jouw8k.fsf@mpe.ellerman.id.au>
X-Yow:  NOT fucking!! Also not a PACKAGE of LOOSE-LEAF PAPER!!
Date:   Fri, 30 Oct 2020 10:09:48 +0100
In-Reply-To: <87y2jouw8k.fsf@mpe.ellerman.id.au> (Michael Ellerman's message
        of "Fri, 30 Oct 2020 16:19:07 +1100")
Message-ID: <87v9esaxlv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 30 2020, Michael Ellerman wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>> On Okt 01 2020, Christophe Leroy wrote:
>>
>>> At the time being, an early hash table is set up when
>>> CONFIG_KASAN is selected.
>>>
>>> There is nothing wrong with setting such an early hash table
>>> all the time, even if it is not used. This is a statically
>>> allocated 256 kB table which lies in the init data section.
>>>
>>> This makes the code simpler and may in the future allow to
>>> setup early IO mappings with fixmap instead of hard coding BATs.
>>>
>>> Put create_hpte() and flush_hash_pages() in the .ref.text section
>>> in order to avoid warning for the reference to early_hash[]. This
>>> reference is removed by MMU_init_hw_patch() before init memory is
>>> freed.
>>
>> This breaks booting on the iBook G4.
>
> Do you get an oops or anything?

Nope, nothing at all.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
