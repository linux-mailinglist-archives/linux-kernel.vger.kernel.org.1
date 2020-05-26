Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B791A1101
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgDGQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 12:11:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54272 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgDGQLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:11:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48xXTb0gyqz9v16D;
        Tue,  7 Apr 2020 18:11:31 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rQePjIhN; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ql_PfMohPlTm; Tue,  7 Apr 2020 18:11:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48xXTZ6YCHz9v16C;
        Tue,  7 Apr 2020 18:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586275890; bh=0/rdVOr3u5i2ymBgDoIN9hE0ZQznL4f0oL64O+q9Kv8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rQePjIhNGThb9qEO4Fu3PoBYHijoaw3WYYMkhu5bBY/+MoZcwE1oKEJKpRiN1ZTcL
         9BoWbCvcFH84Os6RDKM9cVG4Qdzp1VGJkbp7tSqlwyGq/O76EAIz6vI/HUQFrejBaK
         4CXn0HHFvmjFW1S4dGnC6zeKXnBVSw7xLYkB2x9s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 549098B7EE;
        Tue,  7 Apr 2020 18:11:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6sj_Lv0zLOAp; Tue,  7 Apr 2020 18:11:32 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C7C0F8B7EC;
        Tue,  7 Apr 2020 18:11:31 +0200 (CEST)
Subject: Re: [PATCH vdsotest] Use vdso wrapper for gettimeofday()
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0eddeeb64c97b8b5ce0abd74e88d2cc0303e49c6.1579090596.git.christophe.leroy@c-s.fr>
 <871rrzjq5j.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1c2c6da1-e10f-d2a8-fc5e-ecf405879df5@c-s.fr>
Date:   Tue, 7 Apr 2020 18:11:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <871rrzjq5j.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Le 16/01/2020 à 17:56, Nathan Lynch a écrit :
> Hi Christophe,
> 
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> To properly handle errors returned by gettimeofday(), the
>> DO_VDSO_CALL() macro has to be used, otherwise vdsotest
>> misinterpret VDSO function return on error.
>>
>> This has gone unnoticed until now because the powerpc VDSO
>> gettimeofday() always succeed, but while porting powerpc to
>> generic C VDSO, the following has been encountered:
> 
> Thanks for this, I'll review it soon.
> 
> Can you point me to patches for the powerpc generic vdso work?
> 

I have not seen any update on the vdsotest repository, have you been 
able to have a look at the patch ?

Thanks
Christophe
