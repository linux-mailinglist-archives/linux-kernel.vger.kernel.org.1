Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181E32E3391
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL1COW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:14:22 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:56925 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgL1COV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:14:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609121636; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=mYORjiFJJbAfZksEaiM6My9YtYKQ214bMoCNAouYZUQ=; b=iBQ5o1p8mhoOfKoPy6Lq1F1wrSRfDw44zusrn+jKqnNhWyxIjIezVujLJoTvyQJ7qRGZcji0
 MAjgHPGYgW1T07YWBe43WKrBeSgkTB3oRSSidN15Gt8T7G7gTIDUAFELpdtQ9y7mtAUvKTu3
 uyDI5cazVK1MCKNznoqPf4r6Ktc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fe93f476d011aad66d4301c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Dec 2020 02:13:27
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51D05C433CA; Mon, 28 Dec 2020 02:13:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37B6DC433ED;
        Mon, 28 Dec 2020 02:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37B6DC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Sun, 27 Dec 2020 19:13:25 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, rnayak@codeaurora.org
Subject: Re: [PATCH -next] regulator: qcom-rpmh: fix build after
 QCOM_COMMAND_DB is tristate
Message-ID: <X+k/RZ1LnG2Wx7FH@codeaurora.org>
References: <20201225185004.20747-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201225185004.20747-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25 2020 at 11:50 -0700, Randy Dunlap wrote:
>Restrict REGULATOR_QCOM_RPMH to QCOM_COMMAND_DB it the latter is enabled.
>
>Fixes this build error:
>  microblaze-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_probe':
>  (.text+0x354): undefined reference to `cmd_db_read_addr'
>
>Fixes: 778279f4f5e4 ("soc: qcom: cmd-db: allow loading as a module")
>Reported-by: kernel test robot <lkp@intel.com>
>Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>Cc: Lina Iyer <ilina@codeaurora.org>
>Cc: Liam Girdwood <lgirdwood@gmail.com>
>Cc: Mark Brown <broonie@kernel.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>

>---
> drivers/regulator/Kconfig |    1 +
> 1 file changed, 1 insertion(+)
>
>--- linux-next-20201223.orig/drivers/regulator/Kconfig
>+++ linux-next-20201223/drivers/regulator/Kconfig
>@@ -881,6 +881,7 @@ config REGULATOR_QCOM_RPM
> config REGULATOR_QCOM_RPMH
> 	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
> 	depends on QCOM_RPMH || (QCOM_RPMH=n && COMPILE_TEST)
>+	depends on QCOM_COMMAND_DB || !QCOM_COMMAND_DB
> 	help
> 	  This driver supports control of PMIC regulators via the RPMh hardware
> 	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
