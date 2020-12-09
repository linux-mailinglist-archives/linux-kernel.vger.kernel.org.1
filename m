Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB32D3D68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgLIIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:30:53 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:32139 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgLIIax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:30:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607502629; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=US7I9Jxk2V33c8DwknWZ5ZyHOLeSlMGpz/OnKDqm8xs=;
 b=lpGPR7Bc1eS3WobsFQrEig78AqOYKofHSKFZveJDOspk85sRxbMCcLxWDPsoKGZF38mwCIuX
 TCZA6Znjh6m72kRhSWlJzQ1o3qrpZeszaUFegPdhjJN7l6VWDqYBX0bL8+i/v+rtwj/kDkbl
 WbkkoUvPRE8Qymf+mHMO9PK+zx4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fd08b02395c822bfe738e24 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 08:29:54
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0A36C43465; Wed,  9 Dec 2020 08:29:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF386C433C6;
        Wed,  9 Dec 2020 08:29:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 09 Dec 2020 16:29:52 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] scsi: ufs: Clean up some lines from
 ufshcd_hba_exit()
In-Reply-To: <1607502147.3580.33.camel@mtkswgap22>
References: <1607497100-27570-1-git-send-email-cang@codeaurora.org>
 <1607497100-27570-3-git-send-email-cang@codeaurora.org>
 <1607502147.3580.33.camel@mtkswgap22>
Message-ID: <527089ac0a43d9095131103f7a274cf1@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-09 16:22, Stanley Chu wrote:
> Hi Can,
> 
> On Tue, 2020-12-08 at 22:58 -0800, Can Guo wrote:
>> ufshcd_hba_exit() is always called after ufshcd_exit_clk_scaling() and
>> ufshcd_exit_clk_gating(), so no need to suspend clock scaling again in
>> ufshcd_hba_exit().
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  drivers/scsi/ufs/ufshcd.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>> 
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 12266bd..0a5b197 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -7765,6 +7765,7 @@ static void ufshcd_async_scan(void *data, 
>> async_cookie_t cookie)
>>  	if (ret) {
>>  		pm_runtime_put_sync(hba->dev);
>>  		ufshcd_exit_clk_scaling(hba);
>> +		ufshcd_exit_clk_gating(hba);
> 
> How about moving above two lines to ufshcd_hba_exit()?
> 
> Otherwise looks good to me!
> Reviewed-by: Stanley Chu <stanleyc.chu@mediatek.com>

You read my mind - I thought about that too, but in ufshcd_init(),
they are separately called on different error out paths.

11232 exit_gating:
11233 	ufshcd_exit_clk_scaling(hba);
11234 	ufshcd_exit_clk_gating(hba);
11235 out_disable:
11236 	hba->is_irq_enabled = false;
11237 	ufshcd_hba_exit(hba);

Thanks,

Can Guo.

> 
>>  		ufshcd_hba_exit(hba);
>>  	}
>>  }
>> @@ -8203,10 +8204,6 @@ static void ufshcd_hba_exit(struct ufs_hba 
>> *hba)
>>  	if (hba->is_powered) {
>>  		ufshcd_variant_hba_exit(hba);
>>  		ufshcd_setup_vreg(hba, false);
>> -		ufshcd_suspend_clkscaling(hba);
>> -		if (ufshcd_is_clkscaling_supported(hba))
>> -			if (hba->devfreq)
>> -				ufshcd_suspend_clkscaling(hba);
>>  		ufshcd_setup_clocks(hba, false);
>>  		ufshcd_setup_hba_vreg(hba, false);
>>  		hba->is_powered = false;
