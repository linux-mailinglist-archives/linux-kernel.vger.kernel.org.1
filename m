Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019A3202973
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgFUH63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgFUH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 03:58:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F27C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:58:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so6880501pjv.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3KPoOm+bLmC1v50pog5fL9P6LrRZAUQ+2yrNP8FscHk=;
        b=uClYwbC88vxgeN/XT3nnqSsi99mXsXx7ojH/vj7BsASRLl/1OSX16DO3qjAgjwUXlW
         NO2c6vjdEKZp9y0wUEeNy2TXN/noDCc8TAeDcj2uBnAbNioTFFCXmuwSnPpBhi8tOJm+
         ZFlOGKL2zgYdL7zemvAdWgVw7yu+HG5A1P1UOyAqCYKVVmGs512K+iGxl5Dfj16Zf4cd
         BlghMbYZN8BlrukCS7rPqEvb9L9rft4Kfk01ZJVKYJSOqbHCdl1dxuDtzBI/gC0GrLco
         4IKdaK9YiR2neltB+CWcALTR9hkwoRiFIMpV0iA7/UhY8lIfng7vtOt7UaIQZ3oL7nHh
         XXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KPoOm+bLmC1v50pog5fL9P6LrRZAUQ+2yrNP8FscHk=;
        b=U1Z6bG78jWNfeXmsdGDxVmkvRAZA59iSXlUTjxETgq+ILNPDmkSzgTieuaQTyT3Rc2
         VsRS32q7j/l4X7+V9G68gGjGZFYlMmyis+THnxH+zDDFVfXcaGZ5/3NrZ3qtG0CdOBYu
         Tbxup9Y3r8mOY37TgEgZTiU++QpQtLAoEYRwU9LVs533a0fQkgTSszcYeLF2fbcVoL+M
         UzkFxmCYQhVREvYi7WTWF9EUDCicn62tYBReeq3Xl5lMu3dnyajYEfUGkYLj42e7NI7r
         Z7CsBr/m0f+aXFsluZzpUvDaXclWHxMpWx/jpYJu2SK3UMiNAIwYTm1eP6W/EWPD/3Nn
         tdMg==
X-Gm-Message-State: AOAM533uPB6110KRFfnCnAlOFO3zcwAvMqr9sYN0P1Ne6dMDrUSWwcU4
        oO9tmldFUYQEcY36tXKphyTLkw==
X-Google-Smtp-Source: ABdhPJyYgyRKuQgyEvPMVmdcQi9PG+cATUzGiqQ36JN7poB94jEHsF8HcBDs5rU+G+S7sj/19/hoxA==
X-Received: by 2002:a17:90a:308c:: with SMTP id h12mr12261894pjb.194.1592726307108;
        Sun, 21 Jun 2020 00:58:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y6sm10675608pfp.144.2020.06.21.00.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 00:58:26 -0700 (PDT)
Date:   Sun, 21 Jun 2020 00:55:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] scsi: ufs: add write booster feature support
Message-ID: <20200621075539.GK128451@builder.lan>
References: <cover.1586374414.git.asutoshd@codeaurora.org>
 <3c186284280c37c76cf77bf482dde725359b8a8a.1586382357.git.asutoshd@codeaurora.org>
 <CAF6AEGvgmfYoybv4XMVVH85fGMr-eDfpzxdzkFWCx-2N5PEw2w@mail.gmail.com>
 <SN6PR04MB46402FD7981F9FCA2111AB37FC960@SN6PR04MB4640.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB46402FD7981F9FCA2111AB37FC960@SN6PR04MB4640.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 21 Jun 00:40 PDT 2020, Avri Altman wrote:

>  
> > 
> > On Wed, Apr 8, 2020 at 3:00 PM Asutosh Das <asutoshd@codeaurora.org>
> > wrote:
> > >
> > > The write performance of TLC NAND is considerably
> > > lower than SLC NAND. Using SLC NAND as a WriteBooster
> > > Buffer enables the write request to be processed with
> > > lower latency and improves the overall write performance.
> > >
> > > Adds support for shared-buffer mode WriteBooster.
> > >
> > > WriteBooster enable: SW enables it when clocks are
> > > scaled up, thus it's enabled only in high load conditions.
> > >
> > > WriteBooster disable: SW will disable the feature,
> > > when clocks are scaled down. Thus writes would go as normal
> > > writes.
> > 
> > btw, in v5.8-rc1 (plus handful of remaining patches for lenovo c630
> > laptop (sdm850)), I'm seeing a lot of:
> > 
> >   ufshcd-qcom 1d84000.ufshc: ufshcd_query_flag: Sending flag query for
> > idn 14 failed, err = 253
> >   ufshcd-qcom 1d84000.ufshc: ufshcd_query_flag: Sending flag query for
> > idn 14 failed, err = 253
> >   ufshcd-qcom 1d84000.ufshc: ufshcd_query_flag_retry: query attribute,
> > opcode 6, idn 14, failed with error 253 after 3 retires
> >   ufshcd-qcom 1d84000.ufshc: ufshcd_wb_ctrl write booster enable failed 253
> > 
> > and at least subjectively, compiling mesa seems slower, which seems
> > like it might be related?
> This looks like a device issue to be taken with the flash vendor:

There's no way for a end-user to file a bug report with the flash vendor
on a device bought from an OEM and even if they would accept the bug
report they wouldn't re-provision the flash in an shipped device.

So you will have to work around this in the driver.

Regards,
Bjorn

> The device reports that it supports wd, but returns inalid idn for flag 0xe...
> 
> Thanks,
> Avri
