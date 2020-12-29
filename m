Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A12E70C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgL2M6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:58:42 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:5938 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgL2M6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:58:41 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTCvjWU025022;
        Tue, 29 Dec 2020 06:57:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=E+LLn2lciRVI6aTOT3XvuKQAoEO/c5/A1kLV+3X0f5A=;
 b=Xu1LMv/8j9TsOFqyDDIXTQTXVVqeddtAxplQnhRqbXZsu8GTLbnDM2J0781ZI1r41Azx
 j+V9qBi4DC7aw6Ax8eA7rWueN0yNEg93vsgcThEw/BBA0zPFvFsaaXYg67TMvAGs3L+y
 qSmXs+2PJLRhm4AQGW0UfhAfKs9x1PCnx6aQgOCukkfhJSfsVWw5+H+Dme82WYNdEVKv
 rvD6yxkV8diW75f0iB+/5COKyPanAfxHiVoFp6d7gIW05OplQIgoAlVi8z2t+084Cvff
 gsyifXt24HKYjFnrYpqK1mSwVo/fOqa2NVUQge7Q4vk42MvMzWfGIY2vDiQLRzD9oQZE zA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35p2fs2b86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 06:57:45 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 29 Dec
 2020 12:57:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 29 Dec 2020 12:57:43 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7F7952AB;
        Tue, 29 Dec 2020 12:57:43 +0000 (UTC)
Date:   Tue, 29 Dec 2020 12:57:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 09/14] extcon: arizona: Add arizona_set_extcon_state()
 helper
Message-ID: <20201229125743.GM9673@ediswmail.ad.cirrus.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201227211232.117801-10-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 10:12:27PM +0100, Hans de Goede wrote:
> All the callers of extcon_set_state_sync() log an error on failure,
> without doing any further error-handling (as there is nothing they
> can do about the error).
> 
> Factor this out into a helper to remove some duplicate code.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-arizona.c | 47 ++++++++++++---------------------
>  1 file changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index 145ca5cd40d5..d5b3231744f9 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -595,6 +595,16 @@ static int arizona_hpdet_do_id(struct arizona_extcon_info *info, int *reading,
>  	return 0;
>  }
>  
> +static void arizona_set_extcon_state(struct arizona_extcon_info *info,
> +				     unsigned int id, bool state)
> +{
> +	int ret;
> +
> +	ret = extcon_set_state_sync(info->edev, id, state);
> +	if (ret)
> +		dev_err(info->arizona->dev, "Failed to set extcon state: %d\n", ret);
> +}

Would be nice to also print which ID it is that is failing,
would help to narrow things down since we lose the customer error
messages for each case.

Thanks,
Charles
