Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF611CF927
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgELP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 11:29:44 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:44804 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgELP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:29:44 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CFIgm8000977;
        Tue, 12 May 2020 10:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=eHJfT1MWX4xSQro+aagNAch/LHPwF75iGKAQv5HLG80=;
 b=Ro3Un3etve/t07nGyLxvxTBucmDOAIjBOOWkMWxKBV+Jk9j0UtmceFkwaXWEdY5WsGf8
 rGmdXJqQl26uZETP0Ekb+sDIV9jrxHsHNUCDluVF8lW/jQ8HImLBSj0naSIMfHwdkkus
 H362wirFcfjzeHVw8R08NFt+381+c/ybS/fGewo79bmP6itNMevx9qdgo2pdLZwAqVtn
 eTkQMKUg2OfYCkGq+xP5iUjlPgPvKV209Eq8n/QVdsWWYZu3UJbETlfFa30SdgLZTNOs
 RdIzuDg+q6cLbPdS3J6pqkxZFsFt7MmgzdB8s0QyDdAF0CmNOPeDIxK23J04YFLX9L6u lg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 30wsx3msur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 10:29:39 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 12 May
 2020 16:29:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 12 May 2020 16:29:37 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 185F42C5;
        Tue, 12 May 2020 15:29:37 +0000 (UTC)
Date:   Tue, 12 May 2020 15:29:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>
CC:     <myungjoo.ham@samsung.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/7] regulator: arizona-regulator: Move binding over
 to dtschema
Message-ID: <20200512152937.GE71940@ediswmail.ad.cirrus.com>
References: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200506155758.14643-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 mlxlogscore=696 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 04:57:52PM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Will update this series to match comments on my Lochnagar series
as well.

Thanks,
Charles
