Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27E28373E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgJEODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:03:42 -0400
Received: from z5.mailgun.us ([104.130.96.5]:55615 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgJEODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:03:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601906621; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=d8/j0WohtLw8caac/1nFPHB9Q430my5uOxGa1hN8aB0=;
 b=NE2IkCkDY2zUNATPXFeMSzZtlGjnhmdfZnHbWVfs1afqknxlwY6rsQKXMwHCoY1X9N+K7x7o
 1kRU7J0PFd/YR9/CUAd68Mnabvi6qrQlH7YzohlvGEaR8s4w5kmzxXNJTGXF5b3BYFEdX7Gu
 6A9kBf1dciAa2gY/2CNKD78/YxA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f7b277c319d4e9cb5450934 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 05 Oct 2020 14:02:36
 GMT
Sender: b_lkasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B9910C433FF; Mon,  5 Oct 2020 14:02:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b_lkasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1771C433CB;
        Mon,  5 Oct 2020 14:02:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Oct 2020 19:32:34 +0530
From:   b_lkasam@codeaurora.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     broonie@kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v2] regmap: irq: Add support to clear ack registers
In-Reply-To: <20201005124152.GB800868@kroah.com>
References: <1601896560-27938-1-git-send-email-lkasam@codeaurora.org>
 <0f3da3b378ee9af7030d8bafa30b8dfd@codeaurora.org>
 <20201005124152.GB800868@kroah.com>
Message-ID: <d5e5f874f2cd42d2b639a5556bd67136@codeaurora.org>
X-Sender: b_lkasam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-05 18:11, Greg KH wrote:
> On Mon, Oct 05, 2020 at 05:55:27PM +0530, b_lkasam@codeaurora.org 
> wrote:
>> <diff in v1 to v2 , addressed formatting and simplified logic >
> 
> That goes below the --- line, as the documentation says, right?
> 
> And this whole thing was attached, twice, why?  Can't you use 'git 
> send-email'?
> 
Sure, will fix it and send via git mail option, also will update below
commit text to use upto 72 columns.

>> For particular codec HWs have requirement to
>> toggle interrupt clear register twice 0->1->0.
>> To accommodate it, need to add one more field
>> (clear_ack) in the regmap_irq struct and update
>> regmap-irq driver to support it.
> 
> Nit, we have 72 columns to fill, might as well use it :)
> 
> thanks,
> 
> greg k-h
