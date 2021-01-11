Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC0B2F0DC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 09:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbhAKIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 03:20:23 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:64350 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbhAKIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 03:20:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610353198; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qw/c4lu6kAigwWBL51ikONX2GIaFw4LqTFQWJ2iKgGs=;
 b=coA3HRfmFyDTUEoBbxZXeTa8sOUulEPXwWzg8u2hU9LfOtkzVjU0HSF4UV8EkTHHvKziDAMY
 PUHYHbGXPfV24lVTCtXAObyT5REijg+RZMw8CJ28TKrhTq9m8XTdxw7aK1H1xsbSVlQ7TGBN
 OXC/voan6zZDD5rQn7QX+SmHyC4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ffc0a0a4dcca12475f03fbb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 08:19:22
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CBD47C43462; Mon, 11 Jan 2021 08:19:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4ABCCC433C6;
        Mon, 11 Jan 2021 08:19:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 16:19:21 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        alim.akhtar@samsung.com, bvanassche@acm.org,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        Jaegeuk Kim <jaegeuk@google.com>
Subject: Re: [PATCH] scsi: ufs: should not override buffer lengh
In-Reply-To: <DM6PR04MB65753C88CF333FABF5CB1704FCAB0@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210111044443.1405049-1-jaegeuk@kernel.org>
 <6551e7d6dd7dc4132dc69e77a51f6f21@codeaurora.org>
 <e1b29f7cdd62cefcc9355baaed66641f@codeaurora.org>
 <DM6PR04MB65753C88CF333FABF5CB1704FCAB0@DM6PR04MB6575.namprd04.prod.outlook.com>
Message-ID: <f4f633617ce91628b251b6ba668df820@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-11 16:15, Avri Altman wrote:
>> 
>> Sorry, typo corrected.
>> 
>> Hi Jaegeuk,
>> 
>> I think the problem is that func ufshcd_read_desc_param() is not
>> expecting
>> one access unsupported descriptors on RPMB LU.
> Correct.
> This is about wb introducing a new constraint: wb buffer is only
> allowed in lu 0..7.
> And this is why, IMHO, the fix should be in ufs_is_valid_unit_desc_lun,
> To include param offset, as it is only called in contingency of
> ufshcd_read_desc_param.
> 
> Thanks,
> Avri

Yeah... Fixing it in ufs-sysfs.c also works. Anyways, the math in
ufshcd_read_desc_param is already complex. Let's fix it somewhere
close to the source/initiator.

Thanks,
Can Guo.
