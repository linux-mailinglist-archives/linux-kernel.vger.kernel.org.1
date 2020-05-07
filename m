Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F2F1C82EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 08:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgEGG73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 02:59:29 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:34321 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgEGG72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:59:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588834768; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LeUIWoVmutVvpuWX4N/QYk1z/s6WxKkdF5HJ+N/Lrls=; b=uGdPdbaLzf3ByZ1kTTCl85RYXuiW/c+QzXvnI0VcPZcGGs6F7pGf+f7F6gOyLhtc83wHjDhu
 au/l1YO6R34rgXmCBZiD8ErsfCz5GoJNO2WzKBYoIMvA2iOgD+yrsA/aSN8gNKYAm/jnmbse
 rVzkLPiiOBruLMz1TqCYSFAnCtE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3b1bd.7f77611ef490-smtp-out-n02;
 Thu, 07 May 2020 06:59:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BA637C432C2; Thu,  7 May 2020 06:59:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 068BEC43636;
        Thu,  7 May 2020 06:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 068BEC43636
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <pillair@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ath10k: Remove msdu from idr when management pkt send fails
References: <1588667015-25490-1-git-send-email-pillair@codeaurora.org>
        <875zd88ei8.fsf@kamboji.qca.qualcomm.com>
        <000001d62436$f253f230$d6fbd690$@codeaurora.org>
Date:   Thu, 07 May 2020 09:59:05 +0300
In-Reply-To: <000001d62436$f253f230$d6fbd690$@codeaurora.org>
        (pillair@codeaurora.org's message of "Thu, 7 May 2020 11:45:42 +0530")
Message-ID: <871rnw8c3q.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<pillair@codeaurora.org> writes:

> Yes, The change you did is correct and better.

Thanks for checking.

> So should I be sending a v3 for this patch ?

No need, the patch with this change is now in my pending branch and I'll
apply it to ath-next it in the next few days.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
