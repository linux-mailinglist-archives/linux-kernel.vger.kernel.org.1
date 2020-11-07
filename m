Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652652AA551
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 14:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKGNYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 08:24:17 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43934 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGNYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 08:24:16 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4CSydn27sqz1qrfr;
        Sat,  7 Nov 2020 14:24:13 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4CSydn1Br0z1qvh7;
        Sat,  7 Nov 2020 14:24:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id yx6A5fhOWZED; Sat,  7 Nov 2020 14:24:12 +0100 (CET)
X-Auth-Info: 7bE/BA4ypitYUy/vkFxt9WFQ+74DxPJApc0pbxU19YnMQEFls8n4mCuBA20ORM6x
Received: from igel.home (ppp-46-244-173-93.dynamic.mnet-online.de [46.244.173.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat,  7 Nov 2020 14:24:12 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 8184C2C35EC; Sat,  7 Nov 2020 14:24:11 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32s: Use relocation offset when setting early
 hash table
References: <9e225a856a8b22e0e77587ee22ab7a2f5bca8753.1604740029.git.christophe.leroy@csgroup.eu>
        <87blg9lchr.fsf@depni.sinp.msu.ru>
X-Yow:  Will the third world war keep ``Bosom Buddies'' off the air?
Date:   Sat, 07 Nov 2020 14:24:11 +0100
In-Reply-To: <87blg9lchr.fsf@depni.sinp.msu.ru> (Serge Belyshev's message of
        "Sat, 07 Nov 2020 12:53:04 +0300")
Message-ID: <87lffdqozo.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07 2020, Serge Belyshev wrote:

> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>
>> When calling early_hash_table(), the kernel hasn't been yet
>> relocated to its linking address, so data must be addressed
>> with relocation offset.
>>
>> Add relocation offset to write into Hash in early_hash_table().
>>
>> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
>> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>> Fixes: 69a1593abdbc ("powerpc/32s: Setup the early hash table at all time.")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> Tested-by: Serge Belyshev <belyshev@depni.sinp.msu.ru>

Works here as well.

Thanks, Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
