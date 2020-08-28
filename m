Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13122255E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH1QET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 12:04:19 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:61280 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725911AbgH1QES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:04:18 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SFi0Uq021999;
        Fri, 28 Aug 2020 10:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=qhUw5EM9tqAPaoYo4GOoztPzC9zw8DfW3LO1+A6Y+28=;
 b=bRuLBMoIsUU2RjJIR8qts3Oo4Pv64klBTiafZz/oeRXu54YUvre3T6GR6XdO8NoY+wS9
 H5LwBEmr8suz459X5hNyVLco6Er/QBsFs+uznnC5bK/pJ8dLewQQe/qqxNgyYShjnoGR
 3lj7BD1rKeyh+qIDgYHZ81wjltNgPX473U311KTEyoyMRLU10rgyopFs0seCy33pg3Mw
 JQ/qNZsjxEmbeuQXvXAenGsdaz+eQpjdx7Be+HfNgESXNmghb14L9Ekjdvo9rzSR+wfM
 d4SvcU9Ye8tzJQNtn07/GYi1iRT/QcMdi2NZOdfztWa0ttHtp8k/C4FTV7Aghf4jimVF +w== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3330s3h7e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Aug 2020 10:53:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 28 Aug
 2020 16:53:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 28 Aug 2020 16:53:49 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 40F7A2C4;
        Fri, 28 Aug 2020 15:53:49 +0000 (UTC)
Date:   Fri, 28 Aug 2020 15:53:49 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] ASoC: wm8994: Ensure the device is resumed in
 wm89xx_mic_detect functions
Message-ID: <20200828155349.GK10899@ediswmail.ad.cirrus.com>
References: <20200827173357.31891-1-s.nawrocki@samsung.com>
 <CGME20200827173426eucas1p13f9f7d358dfcc440db160de3dc658ddf@eucas1p1.samsung.com>
 <20200827173357.31891-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200827173357.31891-2-s.nawrocki@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=766 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:33:57PM +0200, Sylwester Nawrocki wrote:
> When the wm8958_mic_detect, wm8994_mic_detect functions get called from
> the machine driver, e.g. from the card's late_probe() callback, the CODEC
> device may be PM runtime suspended and any regmap writes have no effect.
> Add PM runtime calls to these functions to ensure the device registers
> are updated as expected.
> This suppresses an error during boot
> "wm8994-codec: ASoC: error at snd_soc_component_update_bits on wm8994-codec"
> caused by the regmap access error due to the cache_only flag being set.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
