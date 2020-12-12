Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362CA2D8889
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436464AbgLLRGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 12:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389080AbgLLRFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 12:05:55 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D1C0613CF;
        Sat, 12 Dec 2020 09:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=z3TCRxZk++lJppjCuU9kk0bzCHxvETkF/5TPfmBMnBk=; b=cWoP0VaPCasVtshx8N8Y+XYwIZ
        gJMcVr7MAYWbb+pXDFrmfCzedo3YvwWNG0ZgVG5C+LcZicmS6yz8x9G6JigWlqNs3kuGY2jqeuOWp
        kmcIdsUVS/g4zSN2pgBkfTbV2dBUX0IFLqsEbP+rEWB+PrMbCkqkWrIuPWj+snsILwUD/AL8eIeU3
        L3BBRodVbrwNuf4tfmPDFchKxadx4cvKNt03ceLJswCqjT5stA0yDhnYCk2mjZW0b/pJUnkjY3Gn3
        +2REFGsvtmn1n+RCEmOGOoljKCozmglVTpjCn+blTFW78qI2dCCskCuFHyDSEel2Xq0citpZETnsP
        F+O5cS/w==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ko8KQ-0004ub-CF; Sat, 12 Dec 2020 17:05:06 +0000
Subject: Re: [PATCH -next] platform: surface: fix non-PM_SLEEP build warnings
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20201211190335.16501-1-rdunlap@infradead.org>
 <CAHp75Vcckb5NA=tc5s5p_qzYE2qhJOT0vhCtfKhT_eqZe+PgXw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec8e703f-e1ea-1253-edc9-311f0ee3e8fd@infradead.org>
Date:   Sat, 12 Dec 2020 09:05:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcckb5NA=tc5s5p_qzYE2qhJOT0vhCtfKhT_eqZe+PgXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/20 5:24 AM, Andy Shevchenko wrote:
> On Fri, Dec 11, 2020 at 9:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix build warnings when CONFIG_PM_SLEEP is not enabled and these
>> functions are not used:
>>
>> ../drivers/platform/surface/surface_gpe.c:189:12: warning: ‘surface_gpe_resume’ defined but not used [-Wunused-function]
>>  static int surface_gpe_resume(struct device *dev)
>>             ^~~~~~~~~~~~~~~~~~
>> ../drivers/platform/surface/surface_gpe.c:184:12: warning: ‘surface_gpe_suspend’ defined but not used [-Wunused-function]
>>  static int surface_gpe_suspend(struct device *dev)
>>             ^~~~~~~~~~~~~~~~~~~
> 
> ...
> 
>> +#ifdef CONFIG_PM_SLEEP
>>  static int surface_gpe_suspend(struct device *dev)
> 
> Perhaps __maybe_unused ?
> 

Yes, I am aware of that option.
I don't know why it would be preferred though.

-- 
~Randy

