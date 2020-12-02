Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED82CC2E0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgLBQ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:57:48 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:49334 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgLBQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:57:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606928249; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=77lkc+Fwzqw6vH9v3hrB6uxt0a/hYvTrBtSFTxu/PlY=; b=cHGiNLhPI3Eb2nF46qWVO3ONFCMwLTEjqqpIlLDQh2F3HpnU7zAAwKwCpWh2GHnA6dNR0mzh
 ng+2TJIjT6WY61wc7nlX8c0J7ivtY6EHySrtw3XZAFhZbFpkIzzi9ckgWg8SeXJlo4IVFzIY
 bTJxmhzXlHq5AVEbRK2OBQN81Rs=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fc7c771f2eedd9084fec7f2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 16:57:21
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2AC09C43462; Wed,  2 Dec 2020 16:57:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E41FC433ED;
        Wed,  2 Dec 2020 16:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E41FC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gregkh@linuxfoundation.org, hemantk@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH 01/29] bus: mhi: Remove auto-start option
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
        <20201202094159.107075-2-manivannan.sadhasivam@linaro.org>
        <87pn3si4fu.fsf@codeaurora.org> <20201202162716.GA3033@thinkpad>
Date:   Wed, 02 Dec 2020 18:57:15 +0200
In-Reply-To: <20201202162716.GA3033@thinkpad> (Manivannan Sadhasivam's message
        of "Wed, 2 Dec 2020 21:57:16 +0530")
Message-ID: <87eek8i1sk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Wed, Dec 02, 2020 at 06:00:05PM +0200, Kalle Valo wrote:
>> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
>> 
>> > From: Loic Poulain <loic.poulain@linaro.org>
>> >
>> > There is really no point having an auto-start for channels.
>> > This is confusing for the device drivers, some have to enable the
>> > channels, others don't have... and waste resources (e.g. pre allocated
>> > buffers) that may never be used.
>> >
>> > This is really up to the MHI device(channel) driver to manage the state
>> > of its channels.
>> >
>> > While at it, let's also remove the auto-start option from ath11k mhi
>> > controller.
>> >
>> > Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>> > Acked-by: Kalle Valo <kvalo@codeaurora.org>
>> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> > [mani: clubbed ath11k change]
>> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> 
>> Hmm, didn't we apply this already? At least I pulled the immutable
>> branch to my tree:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=526740b495059ebbc0c3c086dceca1263820fa4f
>> 
>> So if there's a new version of this patch (and a new commit id) the
>> immutable branch I pulled is not immutable anymore.
>
> This is not a new version of the patch. The commit SHA of this patch in
> immutable branch is ed5298c7d500abaf34ed7783969e953a1f028e5b and that is same
> in mhi-next as well.
>
> Now I'm funneling all patches in mhi-next to mainline through Greg, so this
> patch is part of the (MHI changes for v5.11) patch series. Perhaps you might be
> dealing with pull requests to Dave/Jakub but since the MHI patch flow is usually
> fairly low, Greg is happy with patch series.
>
> But since we are dealing with immutable branch I should send the pull request
> to Greg now.

Yes, I very much prefer you send a pull request so that we can avoid
conflicts between ath11k and mhi. If Greg would apply this patch as is,
we would have two versions of the same commit (with different commit
ids) and git would get confused.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
