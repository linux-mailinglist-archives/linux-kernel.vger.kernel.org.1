Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E882ADCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKJReZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:34:25 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:43452 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJReZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:34:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605029664; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=S4vIyjJlTrRKjf4Zg9NLssEHh5XPrU4sl8ZkKBXrdG4=; b=l4jetOiJWFaDTojXFiWLz2GkXC+DxI5rr7pdudxJE2eK/FMVMs7CIBD9SQ6mXLSKdMavHzyM
 IrN8H6kDEehz5YR4m9RwZed1LjY1ckGc9hkJijrnxxvjIPub/ojm/gvT2pifvelF3sSigWQt
 CmcDqtOrhmenwj3HmWaijvqi8A4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5faaceff24ba9b3b02ec1b4b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 17:33:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2E60C433C8; Tue, 10 Nov 2020 17:33:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 309F5C433C8;
        Tue, 10 Nov 2020 17:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 309F5C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Abhishek Kumar <kuabhs@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
        <20201106071107.D7CE3C433C6@smtp.codeaurora.org>
        <CACTWRwtjvQYUvbWHrajNRkK_sDZRv1hr0kp+o1=6504qv64qKQ@mail.gmail.com>
Date:   Tue, 10 Nov 2020 19:33:46 +0200
In-Reply-To: <CACTWRwtjvQYUvbWHrajNRkK_sDZRv1hr0kp+o1=6504qv64qKQ@mail.gmail.com>
        (Abhishek Kumar's message of "Tue, 10 Nov 2020 09:19:20 -0800")
Message-ID: <87imadce11.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abhishek Kumar <kuabhs@chromium.org> writes:

> Apologies for the delay, was busy so could not work on V2 . I have
> started working on V2 patch. Will upload by today/tomorrow.

Thanks, I'll then drop this v1.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
