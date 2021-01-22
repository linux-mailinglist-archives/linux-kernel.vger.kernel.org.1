Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA530015A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbhAVLUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:20:19 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:22118 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727550AbhAVLNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:13:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MB60N9025222;
        Fri, 22 Jan 2021 05:12:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=XfQohL+LZa22lvuloS7/zOse5A1Cl83bdJ700YgAjFY=;
 b=FwHCuPvc4B8/imLlbvZK0gh8/+fRCC9PM8ZZfWYbxZ5ld0sbBvLxl+l/a0v77uVkTnu+
 kjqjj6085GSnAOWNnp+GqOU1C45UfmeLQTTcqzbewqHge8TWbIT0IgvkAYVHUaVwIvWM
 DPZX2yd6EYwUCkSgyPZRPA0o6+gxRmbrWZ4Lyh5oxXoGmbmXatFhrd8R1gKFu/ogYYqx
 D3UM6it1vpybizFBpNm2Vwqx4lkiV0LOVbtyoJOo7sYCSpooFL6wS5kcsYjhCZ0NW9Sj
 Y56gFXovRK9o4qBvFvJAlmAyKya5OyfNNqyKjnV5BPgpe427Ic4T1z6gaMgaNymmBYi2 Dg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36692rbjar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Jan 2021 05:12:45 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 22 Jan
 2021 11:12:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 22 Jan 2021 11:12:43 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 29E5445;
        Fri, 22 Jan 2021 11:12:43 +0000 (UTC)
Date:   Fri, 22 Jan 2021 11:12:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 06/12] ASoC: arizona-jack: Move jack-detect variables
 to struct arizona_priv
Message-ID: <20210122111243.GG106851@ediswmail.ad.cirrus.com>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210117160555.78376-7-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=835 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 05:05:49PM +0100, Hans de Goede wrote:
> Move all the jack-detect variables from struct arizona_extcon_info to
> struct arizona_priv.
> 
> This is part of a patch series converting the arizona extcon driver into
> a helper library for letting the arizona codec-drivers directly report jack
> state through the standard sound/soc/soc-jack.c functions.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
