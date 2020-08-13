Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02812433B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 07:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMF41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 01:56:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51300 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMF41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:56:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRwmm2XF4z9tyg4;
        Thu, 13 Aug 2020 07:56:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8pcqs7f3aQ33; Thu, 13 Aug 2020 07:56:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRwmm140Jz9tyg3;
        Thu, 13 Aug 2020 07:56:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C5D78B780;
        Thu, 13 Aug 2020 07:56:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Dvdo23uApDSf; Thu, 13 Aug 2020 07:56:25 +0200 (CEST)
Received: from [172.25.230.104] (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E7F428B768;
        Thu, 13 Aug 2020 07:56:24 +0200 (CEST)
Subject: Re: [PATCH v3 2/2] powerpc/uaccess: Add pre-update addressing to
 __get_user_asm() and __put_user_asm()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <c27bc4e598daf3bbb225de7a1f5c52121cf1e279.1597235091.git.christophe.leroy@csgroup.eu>
 <13041c7df39e89ddf574ea0cdc6dedfdd9734140.1597235091.git.christophe.leroy@csgroup.eu>
 <20200812193712.GV6753@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <37d2f5ea-6d10-ec6d-4725-95bc51aae9fd@csgroup.eu>
Date:   Thu, 13 Aug 2020 07:56:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812193712.GV6753@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/08/2020 à 21:37, Segher Boessenkool a écrit :
> On Wed, Aug 12, 2020 at 12:25:17PM +0000, Christophe Leroy wrote:
>> Enable pre-update addressing mode in __get_user_asm() and __put_user_asm()
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3: new, splited out from patch 1.
> 
> It still looks fine to me, you can keep my Reviewed-by: :-)
> 

Ah yes thanks, forgot it when I commited it.

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Christophe
