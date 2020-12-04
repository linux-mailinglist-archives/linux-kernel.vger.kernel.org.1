Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847C62CE82B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgLDGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:31:37 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:29290 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgLDGbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:31:37 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CnNBP22Bcz9tyVM;
        Fri,  4 Dec 2020 07:30:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7EEkoEIMxYcR; Fri,  4 Dec 2020 07:30:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CnNBP0qKPz9tyVJ;
        Fri,  4 Dec 2020 07:30:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D73088B7F5;
        Fri,  4 Dec 2020 07:30:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LesFRRD4IsuQ; Fri,  4 Dec 2020 07:30:53 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21C0F8B75E;
        Fri,  4 Dec 2020 07:30:53 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: Don't see NULL pointer dereference as a KUAP
 fault
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <8b865b93d25c15c8e6d41e71c368bfc28da4489d.1606816701.git.christophe.leroy@csgroup.eu>
 <87mtyvumrn.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <16dd1637-cfaf-bfb3-07c6-7e71d33640b8@csgroup.eu>
Date:   Fri, 4 Dec 2020 07:30:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87mtyvumrn.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/12/2020 à 12:55, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Sometimes, NULL pointer dereferences are expected. Even when they
>> are accidental they are unlikely an exploit attempt because the
>> first page is never mapped.
> 
> The first page can be mapped if mmap_min_addr is 0.
> 
> Blocking all faults to the first page would potentially break any
> program that does that.
> 
> Also if there is something mapped at 0 it's a good chance it is an
> exploit attempt :)

Ok, I see.

In fact, we hit this warning because we don't provide copy_from_kernel_nofault_allowed()

I'll cook a patch for that.

Christophe
