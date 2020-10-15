Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077AD28F33D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgJONcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:32:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29545 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgJONcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:32:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CBqvT6bzYzB09Zy;
        Thu, 15 Oct 2020 15:32:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r2mIeKUWihmY; Thu, 15 Oct 2020 15:32:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CBqvT5QtWzB09b4;
        Thu, 15 Oct 2020 15:32:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56B408B811;
        Thu, 15 Oct 2020 15:32:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VjYZ00gG4QY9; Thu, 15 Oct 2020 15:32:07 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C58558B7FF;
        Thu, 15 Oct 2020 15:32:06 +0200 (CEST)
Subject: Re: [PATCH] powerpc: force inlining of csum_partial() to avoid
 multiple csum_partial() with GCC10
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <a1d31f84ddb0926813b17fcd5cc7f3fa7b4deac2.1602759123.git.christophe.leroy@csgroup.eu>
 <20201015132512.GG2672@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1f745f94-c819-b708-815e-24946621a29d@csgroup.eu>
Date:   Thu, 15 Oct 2020 15:32:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201015132512.GG2672@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/10/2020 à 15:25, Segher Boessenkool a écrit :
> Hi!
> 
> On Thu, Oct 15, 2020 at 10:52:20AM +0000, Christophe Leroy wrote:
>> With gcc9 I get:
> 
> <snip>
> 
>> With gcc10 I get:
> 
> <snip>
> 
>> gcc10 defines multiple versions of csum_partial() which are just
>> an unconditionnal branch to __csum_partial().
> 
> It doesn't inline it, yes.
> 
> Could you open a GCC PR for this please?

Sure.

I also have get_order() 75 times in my vmlinux, all the same as the following:

c0016790 <get_order>:
c0016790:	38 63 ff ff 	addi    r3,r3,-1
c0016794:	54 63 a3 3e 	rlwinm  r3,r3,20,12,31
c0016798:	7c 63 00 34 	cntlzw  r3,r3
c001679c:	20 63 00 20 	subfic  r3,r3,32
c00167a0:	4e 80 00 20 	blr

Christophe
