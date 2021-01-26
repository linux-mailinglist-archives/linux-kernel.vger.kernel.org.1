Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E567304F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhA0DQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:16:49 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:10032 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbhAZUcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:32:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611693110; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=3tzwSCJKiPhnGKVQZS0Wr8QjsKWCsKhgKn+r0/Rsax4=; b=X1loSl2NKGMdNOyXe6xcynH50GyNQRMME07FA9/8WDXbC2jZkpbQFaTGzqWu91pg2wKUxXXQ
 jXMbFFzydBu+m/DGFcS9Gb+WXAno367S410IVjpWN6/WzcxMt9hiaFR1IF9SA64e1TKMoXO3
 t9bMduFB6VyDCmEiMhB8lmiYj8g=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60107c0abdcf46828782c1cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Jan 2021 20:31:06
 GMT
Sender: sramana=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BD8ECC43463; Tue, 26 Jan 2021 20:31:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.11] (cpe-70-95-74-122.san.res.rr.com [70.95.74.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sramana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 729B0C43469;
        Tue, 26 Jan 2021 20:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 729B0C43469
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sramana@codeaurora.org
Subject: Re: [PATCH v4 21/21] arm64: cpufeatures: Allow disabling of Pointer
 Auth from the command-line
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-22-maz@kernel.org>
 <YAwydxY68TULznr1@Catalins-MacBook-Air.local>
From:   Srinivas Ramana <sramana@codeaurora.org>
Message-ID: <accc21e9-f987-7244-b10a-a01842a3da3c@codeaurora.org>
Date:   Tue, 26 Jan 2021 12:30:51 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAwydxY68TULznr1@Catalins-MacBook-Air.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 1/23/2021 6:28 AM, Catalin Marinas wrote:
> On Mon, Jan 18, 2021 at 09:45:33AM +0000, Marc Zyngier wrote:
>> In order to be able to disable Pointer Authentication  at runtime,
>> whether it is for testing purposes, or to work around HW issues,
>> let's add support for overriding the ID_AA64ISAR1_EL1.{GPI,GPA,API,APA}
>> fields.
>>
>> This is further mapped on the arm64.nopauth command-line alias.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Verified this Series for PAC control feature from command line. with 
arm64.nopauth, we could see PAUTH is disabled on both primary and 
secondary cores as expected.

HWCAPs show no PAC support and kernel instructions are being treated as 
NOPs.

Tested-by: Srinivas Ramana <sramana@codeaurora.org>

