Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345962C5BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404896AbgKZSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:25:31 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:52015 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404630AbgKZSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:25:31 -0500
Received: from [192.168.42.210] ([81.185.169.32])
        by mwinf5d14 with ME
        id x6RL230040iH0YH036RMEn; Thu, 26 Nov 2020 19:25:26 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Nov 2020 19:25:26 +0100
X-ME-IP: 81.185.169.32
Subject: Re: [PATCH] crypto: qat - Use dma_set_mask_and_coherent to simplify
 code
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Trahe, Fiona" <fiona.trahe@intel.com>,
        "Ziemba, Wojciech" <wojciech.ziemba@intel.com>,
        "Chiappero, Marco" <marco.chiappero@intel.com>,
        qat-linux <qat-linux@intel.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Newsgroups: gmane.linux.kernel.cryptoapi,gmane.linux.kernel,gmane.linux.kernel.janitors
References: <20201121071359.1320167-1-christophe.jaillet@wanadoo.fr>
 <20201126120408.GA21666@silpixa00400314>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f8d556f4-75da-7daf-a4af-8335788ff4a1@wanadoo.fr>
Date:   Thu, 26 Nov 2020 19:25:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126120408.GA21666@silpixa00400314>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/11/2020 à 13:04, Giovanni Cabiddu a écrit :
> Hi Christophe,
> 
> On Sat, Nov 21, 2020 at 07:13:59AM +0000, Christophe JAILLET wrote:
>> 'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
>> an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.
>>
>> While at it, also remove some unless extra () in the 32 bits case.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Instead of returning -EFAULT, we could also propagate the error returned
>> by dma_set_mask_and_coherent()
> I'm going to re-submit implementing the comment above and also including
> qat_4xxx.
> 
> Regards,
> 

Sure,
sorry for missing this one.

CJ
