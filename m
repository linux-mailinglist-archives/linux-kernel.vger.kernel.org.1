Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2557F2DDE87
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 07:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbgLRGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 01:21:36 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:45958 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLRGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 01:21:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608272475; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3I0o3xJ2Hiy9cLv5QyzG4KVqp5WoYuUKcUvkm17bXjI=;
 b=VNKmVbqY1H9JZ+Dra6y0eI1wUc9YfNCokLAIwtF4NnJdvqoTKeVCQ9+d0/ymQOpgia8BPwsl
 i71TQ8JSx9tg7SIELfLeu/tzt/u/s3LEfx45Bvn+n8fy/moaS1pc+L7kuFrZ7NoVp36RuEG3
 hw3A0N3DO+dKGmXW+E4/LxjbwgY=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fdc4a3e93a3d2b1cdcc3f0b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Dec 2020 06:20:46
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE8A2C43468; Fri, 18 Dec 2020 06:20:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEDE5C433CA;
        Fri, 18 Dec 2020 06:20:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Dec 2020 14:20:45 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com,
        jiajie.hao@mediatek.com, alice.chao@mediatek.com
Subject: Re: [PATCH v2 0/4] scsi: ufs: Cleanup and refactor clock scaling
In-Reply-To: <20201216131639.4128-1-stanley.chu@mediatek.com>
References: <20201216131639.4128-1-stanley.chu@mediatek.com>
Message-ID: <e939a0fd4afd1691f3e1a8182515ca64@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-16 21:16, Stanley Chu wrote:
> Hi,
> This series cleans up and refactors clk-scaling feature, and shall not
> change any functionality.
> 
> This series is based on Can's series "Three changes related with UFS
> clock scaling" in 5.10/scsi-fixes branch in Martin's tree.
> 

Hi Stanley,

Thanks for noticing my changes, will you review them?
I see customers manipulte UFS scaling related sysfs
nodes more often than before, so we may want to fix it asap.

Regards,

Can Guo.

> However this series may not be required to be merged to 5.10. The
> choice of base branch is simply making these patches easy to be
> reviewed because this series is based on clk-scaling fixes by Can. If
> this series is decided not being merged to 5.10, then I would rebase
> it to 5.11/scsi-queue.
> 
> Changes since v1:
>   - Refactor ufshcd_clk_scaling_suspend() in patch [3/4]
>   - Change function name from ufshcd_clk_scaling_pm() to
> ufshcd_clk_scaling_suspend() in patch [3/4]
>   - Refine patch titles
> 
> Stanley Chu (4):
>   scsi: ufs: Refactor cancelling clkscaling works
>   scsi: ufs: Remove redundant null checking of devfreq instance
>   scsi: ufs: Cleanup and refactor clk-scaling feature
>   scsi: ufs: Fix build warning by incorrect function description
> 
>  drivers/scsi/ufs/ufshcd.c | 90 +++++++++++++++++++--------------------
>  1 file changed, 43 insertions(+), 47 deletions(-)
