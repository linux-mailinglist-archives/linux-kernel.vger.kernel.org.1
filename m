Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC03A1AB689
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 06:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391682AbgDPELo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 00:11:44 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:26904 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbgDPELi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:11:38 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 5B1A54E17F0;
        Thu, 16 Apr 2020 12:11:32 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     oss@buserror.net, Wang Wenhu <wenhu.wang@vivo.com>,
        gregkh@linuxfoundation.org
Cc:     christophe.leroy@c-s.fr, kernel@vivo.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH v2,1/5] powerpc: 85xx: make FSL_85XX_CACHE_SRAM configurable
Date:   Wed, 15 Apr 2020 21:11:13 -0700
Message-Id: <20200416041113.112735-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <36961f9d8c533d8b576043a2c6fc4859accfd9f1.camel@buserror.net>
References: <36961f9d8c533d8b576043a2c6fc4859accfd9f1.camel@buserror.net>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVJTkhLS0tJTkJIQkJPSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6NSo6LTg2PAg9MEIrTD0V
        NRAaFE9VSlVKTkNMS0pLSUJPTE9PVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlNWVdZCAFZQUlNSEI3Bg++
X-HM-Tid: 0a71812f4ba89376kuws5b1a54e17f0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <oss@buserror.net>

>> +	bool "32-bit kernel"
>
>Why make that user selectable ?
>
>Either a kernel is 64-bit or it is 32-bit. So having PPC64 user 
>selectable is all we need.
>
>And what is the link between this change and the description in the log ?
>
>>   	default y if !PPC64
>>   	select KASAN_VMALLOC if KASAN && MODULES
>>   
>> @@ -15,6 +15,7 @@ config PPC_BOOK3S_32
>>   	bool
>>   
>>   menu "Processor support"
>> +
>
>Why adding this space ?
>
>>   choice
>>   	prompt "Processor Type"
>>   	depends on PPC32
>> @@ -211,9 +212,9 @@ config PPC_BOOK3E
>>   	depends on PPC_BOOK3E_64
>>   
>>   config E500
>> +	bool "e500 Support"
>>   	select FSL_EMB_PERFMON
>>   	select PPC_FSL_BOOK3E
>> -	bool
>
>Why make this user-selectable ? This is already selected by the 
>processors requiring it, ie 8500, e5500 and e6500.
>
>Is there any other case where we need E500 ?
>
>And again, what's the link between this change and the description in 
>the log ?
>
>
>>   
>>   config PPC_E500MC
>>   	bool "e500mc Support"
>> 
>
>Christophe

Hi, Scott, Christophe!

I find that I did not get the point well of the defferences between
configurability and selectability(maybe words I created) of Kconfig items.

You are right that FSL_85XX_CACHE_SRAM should only be selected by a caller
but never enable it seperately.

Same answer for the comments from Christophe. I will drop this patch in v3.

Thanks,
Wenhu
