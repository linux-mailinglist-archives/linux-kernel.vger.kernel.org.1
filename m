Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DF1262774
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 08:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIIGzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 02:55:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35069 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIIGzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:55:51 -0400
Received: by mail-ed1-f68.google.com with SMTP id i1so1529668edv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 23:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqwH27y1ChtDAXzcbsrMnm82EyGy+11jZMEIO/gA30w=;
        b=HHtRMB+nYpoc9cm9xsejHbR9WQbIeXtTVwcMJrnYSiljRa2xjzka6rTjGXpsdI4IGR
         QauX/QLogFlHGbvLkTi9KgsPy+eJ7VUmLSRsif5pG48jjL9JJV0WstUMGhgtbiSVcyyU
         e9EyrMEseoXgGlhKWzx+2EKx8Sg25HuoJzsLLvpFc7Ihqb5/bWdt4deXaxEwUrTOuIyM
         bELxdmrIh/6CO8kYa1/A0FL8zp3EC1bEhCp4hmSkqxUeq8pUFC6m5yn4J0HpxLRI9vMz
         iuGg6Sk+PIkPWO81u+HEdvKfX7dQCNrekuhXb5hT1JCjNJWd1OTbQs7+0Zil802edb1l
         Tz7Q==
X-Gm-Message-State: AOAM531B1GGrOELTc0Y0NqxhzzlsVGN7A6wXArV+HIAUYKzuxbiZDwvf
        dZXKYHmUFfuG61Tz791Et2ImCXb857w=
X-Google-Smtp-Source: ABdhPJwXn2VsBXxqHss1d4iB2G/qX1Fbcud1W5ELgYJdlpOJ8kk2GG50ddQ5nLxV1DwgczbC/XRtsw==
X-Received: by 2002:a50:dec9:: with SMTP id d9mr2660869edl.145.1599634549487;
        Tue, 08 Sep 2020 23:55:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id be2sm1159926edb.0.2020.09.08.23.55.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 23:55:48 -0700 (PDT)
Date:   Wed, 9 Sep 2020 08:55:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ye Bin <yebin10@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Delete duplicated argument to '|' in
 function tegra210_emc_r21021_periodic_compensation
Message-ID: <20200909065546.GA5538@kozik-lap>
References: <20200903021542.315195-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903021542.315195-1-yebin10@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 10:15:42AM +0800, Ye Bin wrote:
> In funtion tegra210_emc_r21021_periodic_compensation when calculate emc_cfg
> EMC_CFG_DRAM_CLKSTOP_PD is duplicated
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/memory/tegra/tegra210-emc-cc-r21021.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

