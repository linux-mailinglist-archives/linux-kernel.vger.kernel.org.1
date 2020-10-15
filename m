Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740B628FBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbgJOX5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:57:10 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.200]:28167 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbgJOX5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:57:10 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 5E3156AF043
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 18:57:08 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id TD7MkIjeEOIGpTD7MkRPrS; Thu, 15 Oct 2020 18:57:08 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gy3P67RxNUL9omx5MlSP0/Wj6c2IxeNn3fMV33pKe/8=; b=ZVcnMlOYnf+TIKhFwR374JfrnZ
        6andPUbQDwXLgS87uNZxg3+ZZQPi3Zt4SkFuaMigJ2okoZV4umgaXwFUM2GnmI/aiEAKXvP9+21ki
        BRXYQCf8I78kxAJMW8LB7+TrvN+NDnZdkQ1xuE82VV4nyztV4CunUuY8S0qr6+S8X7TExYzj5gZpT
        qYQajBgg+pC9Xsn11LctlAiRGLPUgO6Bmt/kiQq54rKStD8E2+ESD4u1I7Li9/E4HcXzfJHqneHE+
        dK4ti91e4uQ7kPEt1apPM6K7sqxTWv1S4vY06BYERMEAuU/rwMbpFC5cCREiiibVks+IwuNH2JVab
        WS9v2JqQ==;
Received: from 179-197-124-241.user.veloxzone.com.br ([179.197.124.241]:57026 helo=[192.168.1.69])
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1kTD7L-0019KL-Sd; Thu, 15 Oct 2020 20:57:08 -0300
Subject: Re: [PATCH v7 4/4] arm64: dts: Add Caninos Loucos Labrador v3
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, edgar.righi@lsitec.org.br,
        igor.lima@lsitec.org.br, Helen Koike <helen.koike@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-actions@lists.infradead.org, Will Deacon <will@kernel.org>
References: <20200922024302.205062-1-matheus@castello.eng.br>
 <20200922024302.205062-5-matheus@castello.eng.br>
 <20200922061454.GA29035@Mani-XPS-13-9360>
 <CAK8P3a0yGN80nJU0kcrvYGsSjpaNpU_nmu-ENwE3GMC_9DNBhg@mail.gmail.com>
 <20200922102605.GE15643@gaia>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <4fc1047f-2b14-4430-b9b2-1e682881de0c@castello.eng.br>
Date:   Thu, 15 Oct 2020 20:57:01 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200922102605.GE15643@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1kTD7L-0019KL-Sd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.user.veloxzone.com.br ([192.168.1.69]) [179.197.124.241]:57026
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 14
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Em 9/22/20 7:26 AM, Catalin Marinas escreveu:
> On Tue, Sep 22, 2020 at 10:32:06AM +0200, Arnd Bergmann wrote:
>> On Tue, Sep 22, 2020 at 8:15 AM Manivannan Sadhasivam
>> <manivannan.sadhasivam@linaro.org> wrote:
>>> On Mon, Sep 21, 2020 at 11:43:02PM -0300, Matheus Castello wrote:
>>>> +     /* Labrador v3 firmware does not support PSCI */
>>>
>>> Oops. This is unfortunate... I'm not sure if this is even acceptable for
>>> ARM64 machines.
>>>
>>> Let me add Olof and Arnd...
>>
>> Adding Catalin and Will for additional input as well, this is more their
>> area than ours.
>>
>> I don't think we have formalized this as a policy, but we clearly don't
>> want new boards to use the spin table hack. As there are other
>> boards using psci on the same chip, I don't think this is a
>> hardware bug.
> 
> I fully agree, we shouldn't allow new boards to use the spin-table
> method unless EL3 is missing on the CPU implementation (not the case
> here; only the APM hardware has this issue). Unfortunately we missed
> another platform with A53, see commit bc66392d8258 ("arm64: dts: fsl:
> Add device tree for S32V234-EVB").
> 
> The kernel relies on firmware for other things (power management, errata
> workarounds), so an SMC calling convention compliant firmware is highly
> recommended. I also don't see why it would be that hard to add PSCI.
> Even if you don't port something like Trusted Firmware, U-Boot has basic
> support for PSCI.
> 
> So from my perspective, NAK on this patch.
>

Thanks Arnd and Catalin, this is really just a limitation of the 
bootloader developed by manufactures that comes embedded in the board. I 
will drop this in the next version.

> I'm tempted to also modify smp_spin_table_cpu_init() to print a big
> warning and return an error if this is attempted on new platforms. IOW,
> we make it a policy from now on.
> 
