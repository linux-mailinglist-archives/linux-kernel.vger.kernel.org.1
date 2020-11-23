Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4452C0398
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKWKoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:44:39 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:62447 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbgKWKoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:44:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606128278; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=n1KPZYW4+2Uj1IDF6dLB/iA8pfaPs58KbWyeO/376Jo=; b=MRTD4MNUvDF3uUewMPk8xYVQz/vyqNCENRLIyDkoGdf73HgqvEE4mkduNedTH9YupVY/JnRS
 eVIojZCAzo1KMgzMcdPHR6PIiZz2PTEzL4tECA3i+2Oonkv7L/U9z4gKNP7ZOuhQR2JU3+VO
 fWsoy6pEQpHGf6MIrMJvx1xvGJA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fbb92949e87e16352751457 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 10:44:36
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 600D1C43464; Mon, 23 Nov 2020 10:44:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D09EC433C6;
        Mon, 23 Nov 2020 10:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D09EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 23 Nov 2020 16:14:29 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] PM / EM: Micro optimization in em_pd_energy
Message-ID: <20201123104429.GA15351@codeaurora.org>
References: <1606126679-11799-1-git-send-email-pkondeti@codeaurora.org>
 <20201123102839.GB447993@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123102839.GB447993@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:28:39AM +0000, Quentin Perret wrote:
> Hi Pavan,
> 
> On Monday 23 Nov 2020 at 15:47:57 (+0530), Pavankumar Kondeti wrote:
> > When the sum of the utilization of CPUs in a power domain is zero,
> 
> s/power/performance
> 
> > return the energy as 0 without doing any computations.
> > 
> > Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> > ---
> >  include/linux/energy_model.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > index b67a51c..8810f1f 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -103,6 +103,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> >  	struct em_perf_state *ps;
> >  	int i, cpu;
> >  
> > +	if (!sum_util)
> > +		return 0;
> > +
> >  	/*
> >  	 * In order to predict the performance state, map the utilization of
> >  	 * the most utilized CPU of the performance domain to a requested
> 
> Makes sense to me, so with nit above:
> 
> Acked-by: Quentin Perret <qperret@google.com>
> 
Thanks Quentin. I have updated the patch as per your correction. 

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

