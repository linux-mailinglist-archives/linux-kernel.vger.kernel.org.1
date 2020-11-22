Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198BD2BC37D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 05:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKVEIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 23:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgKVEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 23:08:52 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D7C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 20:08:51 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id l36so12809531ota.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 20:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1+eyUtmtAjsxqioppn1au2QM1OrIpCppXp8wpa6NVJc=;
        b=H9o3IDcPqHxIRAJk/VPIody7M0PPT3eLBVvvSPaCQvdyWMPnIl2LDupEvrIFRXDpT0
         kkyVDf9AjK5fLIj8uPbM6V8RHgGMuk+N0mDcFUw8zwDDLtKGTtOFG69XSCO9QmDx6L8x
         svlwlSTuZLuKn2AdfDZ8xA4M45AjfxyUNRaM0CpWeDSYhlbk5UfEukhVCGpcPeVpJN50
         r9ZXOrs1DQWD2+4qaGmEG8xN3rEmKoBmBUhX2DetCfbUuVeO2QAyf90kixeKgfL6w57Q
         Ol/VE7kqOzrj1n/0jYfc+TtivFdj5xpP/rXR6ojRrulonHqV2oQvs+ESVoAS7nrecfsN
         6+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1+eyUtmtAjsxqioppn1au2QM1OrIpCppXp8wpa6NVJc=;
        b=GTjXbwYChSS+u7bTlJSFFlC9T6w5ORRpuzhPCPdjaYSb6v/7YOo3ISHG6QreTswpJo
         FjoXmKOQlcLyBC35+esSuLinEwtl50C8J+UzlY9+c3a3Zjotn7FtiuGysO0GE2s3sN8t
         nrlEYP+hsEQR+pXFT34KP0l/mrKEwNUmCovlgJ8zhn827nKFJkRNg/IuISL+GHhBpE5+
         oq/gLOZwcrNK7LAW0D/MfG5mKCUZiDxll85YK2gT0tHTgwPeofXohXSLr/Cd/zM/sUAs
         LOZarPmTMoTIgi95mlTZG/W8lqZRfnQjIU5fo8b0uu5fHQRZP4U25ijUyw/5uJVauNJ0
         Wv/g==
X-Gm-Message-State: AOAM533qnybYgsqEmpehfXSWZt48/KvqfN2M9JUcHBdCKVbefE1ZY+Ih
        mdeOJkVTvUk2zITNMAexYgbJuw==
X-Google-Smtp-Source: ABdhPJzDLfEkZxcFiWaLStMrxjN/UhXjzvllrqtvzx0fXPC+nCUgusgbAX6kKqGdHvA3LzoxEK2tgw==
X-Received: by 2002:a9d:892:: with SMTP id 18mr11024273otf.9.1606018130559;
        Sat, 21 Nov 2020 20:08:50 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p12sm4131377oti.35.2020.11.21.20.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 20:08:49 -0800 (PST)
Date:   Sat, 21 Nov 2020 22:08:48 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     agross@kernel.org, wsa@kernel.org, sricharan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] i2c: qup: Fix error return code in
 qup_i2c_bam_schedule_desc()
Message-ID: <20201122040848.GB95182@builder.lan>
References: <20201116141058.2365043-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116141058.2365043-1-chengzhihao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Nov 08:10 CST 2020, Zhihao Cheng wrote:

> Fix to return the error code from qup_i2c_change_state()
> instaed of 0 in qup_i2c_bam_schedule_desc().
> 
> Fixes: fbf9921f8b35d9b2 ("i2c: qup: Fix error handling")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  drivers/i2c/busses/i2c-qup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index fbc04b60cfd1..5a47915869ae 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -801,7 +801,8 @@ static int qup_i2c_bam_schedule_desc(struct qup_i2c_dev *qup)
>  	if (ret || qup->bus_err || qup->qup_err) {
>  		reinit_completion(&qup->xfer);
>  
> -		if (qup_i2c_change_state(qup, QUP_RUN_STATE)) {
> +		ret = qup_i2c_change_state(qup, QUP_RUN_STATE);

In the case that we entered this block because ret was -ETIMEDOUT then
this will overwrite this and the function will return -EIO.

But in the other paths out of this block ret is being overwritten
anyways, so I think it's fine.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +		if (ret) {
>  			dev_err(qup->dev, "change to run state timed out");
>  			goto desc_err;
>  		}
> -- 
> 2.25.4
> 
