Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1912FB3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbhASIFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:05:07 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:64509 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbhASIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:04:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611043452; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=G6CrMrwkBlH/hAife+o1/KscQx/5H1OEZNAP7AT9sBg=; b=A/7TMF18TF9/TxatgLX8LySEVilpoIpS/KMeWzI5fJCAWyuCBPK89Pyr210giejTUskeM6W3
 40v5NNwxrj0X5u9lkNQaa/ulGYh1vb77MD7E28A6ogf4A9oUzn6l33lw7eGcmpEY6aimtooV
 qy8puVZ0WJUQTNtd0EFRVELl43I=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6006925d75e5c01cba0b46ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 08:03:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D376FC43463; Tue, 19 Jan 2021 08:03:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6F62C433CA;
        Tue, 19 Jan 2021 08:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6F62C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     "abaci-bugfix\@linux.alibaba.com" <abaci-bugfix@linux.alibaba.com>,
        "Larry.Finger\@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chiu\@endlessos.org" <chiu@endlessos.org>,
        "kuba\@kernel.org" <kuba@kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] rtlwifi: rtl8192se: Simplify bool comparison.
References: <1611037955-105333-1-git-send-email-abaci-bugfix@linux.alibaba.com>
        <1611041680.9785.1.camel@realtek.com>
Date:   Tue, 19 Jan 2021 10:03:36 +0200
In-Reply-To: <1611041680.9785.1.camel@realtek.com> (pkshih@realtek.com's
        message of "Tue, 19 Jan 2021 07:35:19 +0000")
Message-ID: <87v9btqron.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pkshih <pkshih@realtek.com> writes:

> On Tue, 2021-01-19 at 14:32 +0800, Jiapeng Zhong wrote:
>> Fix the follow coccicheck warnings:
>>=20
>> ./drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c:2305:6-27:
>> WARNING: Comparison of 0/1 to bool variable.
>>=20
>> ./drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c:1376:5-26:
>> WARNING: Comparison of 0/1 to bool variable.
>>=20
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
>> ---
>> Changes in v2:
>> =C2=A0 -Modified subject.
>>=20
>
> You forget to remove the period at the end of subject.
> i.e.
> "rtlwifi: rtl8192se: Simplify bool comparison"

I can fix that during commit.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
