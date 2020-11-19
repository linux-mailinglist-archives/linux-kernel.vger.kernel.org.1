Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831502B913F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgKSLkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:40:39 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:57979 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgKSLki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:40:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605786038; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TZuoUsP+pVhkkcsYgHVPSePfqLr7Z1daxKU3o4tjMyc=; b=jlweLvEYZJCLhuh0jesSZOBmXeBm+V28JPMovs4HC9L997t29bENpsFMynVX5BVY4Po8MDfj
 axW9OZE9uzK3pd6RMkdHCEhsHu4yl/S7YXt/ZNpmd6qKs3CIoSsRlGkcA89ogs0CARWQBCDX
 5KEbHF+UIjJ4cb5mh2hcfCqP6ME=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fb659b31b731a5d9c1912e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Nov 2020 11:40:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7B3BC43463; Thu, 19 Nov 2020 11:40:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF026C43462;
        Thu, 19 Nov 2020 11:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF026C43462
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH 4/6] ath11k: make relay callbacks const
References: <20201118165320.26829-1-jani.nikula@intel.com>
        <20201118165320.26829-4-jani.nikula@intel.com>
        <871rgppu9s.fsf@intel.com>
Date:   Thu, 19 Nov 2020 13:40:30 +0200
In-Reply-To: <871rgppu9s.fsf@intel.com> (Jani Nikula's message of "Thu, 19 Nov
        2020 11:31:43 +0200")
Message-ID: <87wnyhtw0h.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Nikula <jani.nikula@intel.com> writes:

> On Wed, 18 Nov 2020, Jani Nikula <jani.nikula@intel.com> wrote:
>> Now that relay_open() accepts const callbacks, make relay callbacks
>> const.
>>
>> Cc: Kalle Valo <kvalo@codeaurora.org>
>> Cc: ath11k@lists.infradead.org
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Kalle, thanks for the acks on the other two ath patches - can I have
> your ack on this one too please?

Oops, missed that:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
