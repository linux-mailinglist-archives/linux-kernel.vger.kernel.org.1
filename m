Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD12835B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJEMRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:17:45 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:29334 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEMRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:17:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601900263; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=SqBll03vz8tkoTVqtnH/E1PbOvt4zgIElzQO16Ufl8s=;
 b=ltlmv8qRW2IGr4V5Gx/1WiVmwtZsO2KG4TDzWb8MxaCLxWXWzwLj4ajFxMttrNTiF4MRF4zL
 7+QUMZSVw1AqZHHqnjcBvj5pIVuXoRmroT9UQxRsYRwVQf0RqFepi7upRbObRPM1akp5dym2
 JBlTscdPWuFdKU7bdUeq2Fx1Ifo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f7b0ee7a03b63d673b84ebb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Oct 2020 12:17:43
 GMT
Sender: b_lkasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3EFCC433F1; Mon,  5 Oct 2020 12:17:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b_lkasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48C64C433C8;
        Mon,  5 Oct 2020 12:17:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Oct 2020 17:47:42 +0530
From:   b_lkasam@codeaurora.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     broonie@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH] regmap: irq: Add support to clear ack registers
In-Reply-To: <20200927122315.GA179084@kroah.com>
References: <1601036740-23044-1-git-send-email-lkasam@codeaurora.org>
 <65dd6c86415a3d8f565160ca0cd66f2c@codeaurora.org>
 <553eabe7ebfb94ac2e76323ef339634b@codeaurora.org>
 <20200927122315.GA179084@kroah.com>
Message-ID: <e1edfdea7df170dc47d94471d1e8efa4@codeaurora.org>
X-Sender: b_lkasam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-27 17:53, Greg KH wrote:
> On Fri, Sep 25, 2020 at 07:14:01PM +0530, b_lkasam@codeaurora.org 
> wrote:
>> For particular codec HWs have requirement to
>> writing interrupt clear and mask interrupt clear
>> register to toggle interrupt status. To accommodate it,
>> need to add one more field (clear_ack) in the regmap_irq
>> struct and update regmap-irq driver to support it.
>> 
>> Signed-off-by: Laxminath Kasam <lkasam@codeaurora.org>
>> ---
>>  drivers/base/regmap/regmap-irq.c | 52
>> ++++++++++++++++++++++++++++++++++++----
>>  include/linux/regmap.h           |  2 ++
>>  2 files changed, 49 insertions(+), 5 deletions(-)
> 
> Patch is line-wrapped :(
Will fix and send new v2 patch.
