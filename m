Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B142871E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgJHJth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:49:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44728 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJHJtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:49:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C6RHv6vbCz9v0Jb;
        Thu,  8 Oct 2020 11:49:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mnZbLhC9ScyS; Thu,  8 Oct 2020 11:49:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C6RHv5nYlz9v0JY;
        Thu,  8 Oct 2020 11:49:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A96338B832;
        Thu,  8 Oct 2020 11:49:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xNCjMtQPDKXQ; Thu,  8 Oct 2020 11:49:32 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A45508B82F;
        Thu,  8 Oct 2020 11:49:29 +0200 (CEST)
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: mm: Question about the use of 'accessed' flags and pte_young() helper
To:     linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Message-ID: <31ef1305-1fd4-8159-a2ca-e9968a568ff0@csgroup.eu>
Date:   Thu, 8 Oct 2020 11:49:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a 10 years old commit 
(https://github.com/linuxppc/linux/commit/d069cb4373fe0d451357c4d3769623a7564dfa9f), powerpc 8xx has 
made the handling of PTE accessed bit conditional to CONFIG_SWAP.
Since then, this has been extended to some other powerpc variants.

That commit means that when CONFIG_SWAP is not selected, the accessed bit is not set by SW TLB miss 
handlers, leading to pte_young() returning garbage, or should I say possibly returning false 
allthough a page has been accessed since its access flag was reset.

Looking at various mm/ places, pte_young() is used independent of CONFIG_SWAP

Is it still valid the not manage accessed flags when CONFIG_SWAP is not selected ?
If yes, should pte_young() always return true in that case ?

While we are at it, I'm wondering whether powerpc should redefine arch_faults_on_old_pte()
On some variants of powerpc, accessed flag is managed by HW. On others, it is managed by SW TLB miss 
handlers via page fault handling.

Thanks
Christophe
