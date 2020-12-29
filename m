Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70B92E7500
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 23:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgL2WbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 17:31:06 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:24036 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgL2WbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 17:31:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609281046; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=n+6eVcATYzCYH9Gui9+EIQL/b4y5Xq2qg33ZvEXVemk=; b=gwF7AwyighpH9VCtmRi2TqIgkwrm9BGTeG6cuzaN0XZ8u8tBhTqzVBgyl83jYlzvcAj9Dbh8
 kViiychlEog8KctPE4qU3ckTVoztiHl9SMJyvmi5UN9AXQJH3heGFhIRCZWNvOcnO9Jk+xvy
 Arc+eG/OQWhxLsnKIgy0kxwVLKE=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5febadfae61d77c9715a693f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Dec 2020 22:30:18
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C565DC43463; Tue, 29 Dec 2020 22:30:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5AA38C433ED;
        Tue, 29 Dec 2020 22:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AA38C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Tue, 29 Dec 2020 14:30:13 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: gadget: u_audio: remove struct uac_req
Message-ID: <20201229222949.GC31406@jackp-linux.qualcomm.com>
References: <20201221173531.215169-1-jbrunet@baylibre.com>
 <20201221173531.215169-4-jbrunet@baylibre.com>
 <X+nzWs3nOrcqu4F2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X+nzWs3nOrcqu4F2@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Jerome,

On Mon, Dec 28, 2020 at 04:01:46PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 21, 2020 at 06:35:30PM +0100, Jerome Brunet wrote:
> > 'struct uac_req' purpose is to link 'struct usb_request' to the
> > corresponding 'struct uac_rtd_params'. However member req is never
> > used. Using the context of the usb request, we can keep track of the
> > corresponding 'struct uac_rtd_params' just as well, without allocating
> > extra memory.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/usb/gadget/function/u_audio.c | 58 ++++++++++++---------------
> >  1 file changed, 26 insertions(+), 32 deletions(-)
> 
> This patch doesn't apply, so I can't apply patches 3 or 4 of this series
> :(
> 
> Can you rebase against my usb-testing branch and resend?

From the cover letter:

On Mon, Dec 21, 2020 at 06:35:27PM +0100, Jerome Brunet wrote:
> The series depends on this fix [0] by Jack Pham to apply cleanly
> 
> [0]: https://lore.kernel.org/linux-usb/20201029175949.6052-1-jackp@codeaurora.org/

My patch hadn't been picked up by Felipe, so it's not in your tree
either, Greg. Should I just resend it to you first?  Or shall I invite
Jerome to just include it in v2 of this series? 

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
