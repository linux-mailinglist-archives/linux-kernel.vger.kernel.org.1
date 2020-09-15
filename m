Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4608F269C24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIOCyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgIOCyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:54:05 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784CEC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:54:05 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so1053561qvk.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AENtihZFanz7AK6JAQj2iuXl1rr5XpuLAyHhP2fdTxc=;
        b=g/h4wKVtRzze15q7+YBYa8/BU5+91OBLBnKQ/0b/r2PCfF49nXRZnsElWP3ecnuHzq
         EM+R+PjHIbUv4pd2JUJas4i+d5pUKdy9OTUdEQV0Jp/NSiPGV+e1D3wEDcIX9ApI4VZX
         +2hwSCeDbmLrnG73Up5dRLqZUF5RHBnT6IW8iKDIXbMiCbHpDWiltkYTycPejWzqC51j
         BBZ1YVVBSbAJWyAdGZFgkBnMExUoSyMG1P+uKDzN7nytHu5Ma5cnNSBYbf7sqU0C3gWL
         X+VYR+LyvNH3CiR5df85wESmzQ3Vr1NkafTjaDAcbBb/ODyyAqY8VmL9u6+dfOwcvlXl
         hUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AENtihZFanz7AK6JAQj2iuXl1rr5XpuLAyHhP2fdTxc=;
        b=Zig8x+jfTJvEy9Wtna/acR5ozhIcwZ4SGdTdxDl7ZmDvkLWnKOq6hJieZiaNCyksH6
         Y9wDpsOFVkLKH3yjXam2GSQxiN7ZgRHMwmZh++wfLr02ZCe2l2d4kISyjl6eGvmKuLYM
         X1p2QSJI4RFZ45u+m7GqYI0Mbvzfuu+h5GuQxZIizmUg3uQ5VVJdjeK/YEdUdW9lEWYd
         266jNtzNmHceO5vygnKO8Z3BAyaZbBO5wnWhPCHfLhH+UqnK8eM2prltoaba6F0hlMqh
         Fw3k8iMIvSWfW+m5Pn6KoMNGKpj7eHatw0vqbyK/ol4FJVrWe+Yi/KEKLFDzjRlWUrNX
         U82A==
X-Gm-Message-State: AOAM531U+lcY26zwd+Cahj+V8NO5YBZQ78KPSzKonuW3u+rz7oVa+iDy
        cl4E0j7lLqH3m9MccLsvesA8R9tYThA5qQ==
X-Google-Smtp-Source: ABdhPJxHxWeHi97ePv3FCP2DV1zftb/XyH1vIFWezkQmVxts9NiBBIfqccJnCV2mwFphJKlRWsDQuA==
X-Received: by 2002:a05:6214:12c:: with SMTP id w12mr16299144qvs.18.1600138444488;
        Mon, 14 Sep 2020 19:54:04 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
        by smtp.gmail.com with ESMTPSA id s47sm16504448qtb.13.2020.09.14.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 19:54:03 -0700 (PDT)
Date:   Tue, 15 Sep 2020 02:54:01 +0000
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     cang@codeaurora.org, asutoshd@codeaurora.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] scsi: ufshcd: Properly set the device Icc Level
Message-ID: <20200915025401.GD471@uller>
References: <5c9d6f76303bbe5188bf839b2ea5e5bf530e7281.1598923023.git.nguyenb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c9d6f76303bbe5188bf839b2ea5e5bf530e7281.1598923023.git.nguyenb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Sep 01:19 UTC 2020, Bao D. Nguyen wrote:

> UFS version 3.0 and later devices require Vcc and Vccq power supplies
> with Vccq2 being optional. While earlier UFS version 2.0 and 2.1
> devices, the Vcc and Vccq2 are required with Vccq being optional.
> Check the required power supplies used by the device
> and set the device's supported Icc level properly.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 06e2439..fdd1d3e 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6845,8 +6845,9 @@ static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
>  {
>  	u32 icc_level = 0;
>  
> -	if (!hba->vreg_info.vcc || !hba->vreg_info.vccq ||
> -						!hba->vreg_info.vccq2) {
> +	if (!hba->vreg_info.vcc ||

How did you test this?

devm_regulator_get() never returns NULL, so afaict this conditional will
never be taken with either the old or new version of the code.

Regards,
Bjorn

> +		(!hba->vreg_info.vccq && hba->dev_info.wspecversion >= 0x300) ||
> +		(!hba->vreg_info.vccq2 && hba->dev_info.wspecversion < 0x300)) {
>  		dev_err(hba->dev,
>  			"%s: Regulator capability was not set, actvIccLevel=%d",
>  							__func__, icc_level);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
