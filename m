Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73222E09FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgLVMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:19:27 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:63292 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLVMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:19:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608639547; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4Pjy6oXt8m46ugTOK9z6c9JGgi4a6imnMwcwh9QIWLA=;
 b=I2Zpx4oW9zU4wJTvaz3s7Hdv/3Ecxyr9v4Ahj5yimmZTkWYCdsfk2KE6vSL7FOlw4RoYK2g/
 tohC5uUYRaVla5lQxWLJ10vKcQ+Pdg8IiY8+FyO3RaiiYhhyXT5rhM/jRS7oXuHuy+z5IK+j
 6OJ1wtTXjjOedufEA0+8PMGugY4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fe1e418db8e07fa6c20411c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 12:18:32
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7EDD9C43461; Tue, 22 Dec 2020 12:18:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B11F4C433CA;
        Tue, 22 Dec 2020 12:18:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Dec 2020 17:48:31 +0530
From:   mdalam@codeaurora.org
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     vkoul@kernel.org, corbet@lwn.net, agross@kernel.org,
        bjorn.andersson@linaro.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Add LOCK and UNLOCK flag bit
 support
In-Reply-To: <8c86f4db-9956-10d1-b380-a207137b50ef@linaro.org>
References: <1608215842-15381-1-git-send-email-mdalam@codeaurora.org>
 <6c85436d-e064-367e-736b-951af82256c8@linaro.org>
 <9769c54acf54617a17346fea60ee38b6@codeaurora.org>
 <8c86f4db-9956-10d1-b380-a207137b50ef@linaro.org>
Message-ID: <11f538a697de934551bcec5036d7fb17@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-21 23:39, Thara Gopinath wrote:
> On 12/21/20 2:35 AM, mdalam@codeaurora.org wrote:
>> On 2020-12-19 09:05, Thara Gopinath wrote:
>>> On 12/17/20 9:37 AM, Md Sadre Alam wrote:
>>>> This change will add support for LOCK & UNLOCK flag bit support
>>>> on CMD descriptor.
>>>> 
>>>> If DMA_PREP_LOCK flag passed in prep_slave_sg then requester of this
>>>> transaction wanted to lock the DMA controller for this transaction 
>>>> so
>>>> BAM driver should set LOCK bit for the HW descriptor.
>>>> 
>>>> If DMA_PREP_UNLOCK flag passed in prep_slave_sg then requester of 
>>>> this
>>>> transaction wanted to unlock the DMA controller.so BAM driver should 
>>>> set
>>>> UNLOCK bit for the HW descriptor.
>>> Hi,
>>> 
>>> This is a generic question. What is the point of LOCK/UNLOCK with
>>> allocating LOCK groups to the individual dma channels? By default
>>> doesn't all channels fall in the same group. This would mean that
>>> a lock does not prevent the dma controller from not executing a
>>> transaction on the other channels.
>>> 
>> 
>> The Pipe Locking/Unlocking will be only on command-descriptor.
>> Upon encountering a command descriptor with LOCK bit set, the BAM
>> will lock all other pipes not related to the current pipe group, and 
>> keep
>> handling the current pipe only until it sees the UNLOCK set then it 
>> will
>> release all locked pipes.
> 
> So unless you assign pipe groups, this will not work as intended
> right? So this patch is only half of the solution. There should also
> be a patch allowing pipe groups to be assigned. Without that extra bit
> this patch does nothing , right ?

Yes you are right.
We are having some register which will configure the pipe lock group.
But these registers are not exposed to non-secure world. These registers
only accessible through secure world. Currently in IPQ5018 SoC we are 
configuring
these register in secure world to configure pipe lock group.
