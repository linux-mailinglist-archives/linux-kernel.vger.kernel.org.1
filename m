Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C342D1C4F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 09:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgEEHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 03:36:31 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:25392 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbgEEHgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:36:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588664190; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=E5ikgPmsaSTtogguuprJ4svrQMsqzNWKpQn1yRMxllE=;
 b=oXtQWlXnCEt14ZM/zEdcqOorH4WVYlHa0eDfoAM35T/oiHOB1l2IV6h/uSNd/QB0NsWv36jY
 hREZCmiQlAuHkexcsx/1v3ropolbv8Nj08GHVuOG66zcLC/1q3BrXLACUV0iha2t0FRUXCSt
 dJht8l7Dwe1iD6E+S6Sg/a/CgjU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17A48C433F2; Tue,  5 May 2020 07:36:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 661CBC433D2;
        Tue,  5 May 2020 07:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 661CBC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] dt-bindings: ath10k: Add wifi-firmware subnode for
 wifi node
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1586971906-20985-2-git-send-email-pillair@codeaurora.org>
References: <1586971906-20985-2-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200505073625.17A48C433F2@smtp.codeaurora.org>
Date:   Tue,  5 May 2020 07:36:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> Add a wifi-firmware subnode for the wifi node.
> This wifi-firmware subnode is needed for the
> targets which do not support TrustZone.
> 
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

85325c24d5d2 dt-bindings: ath10k: Add wifi-firmware subnode for wifi node
727fec790ead ath10k: Setup the msa resources before qmi init
1423f4327331 ath10k: Add support for targets without trustzone

-- 
https://patchwork.kernel.org/patch/11491759/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

