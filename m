Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25E82B0917
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgKLP5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:57:30 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:55682 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728414AbgKLP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:57:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ACFWFgg029153;
        Thu, 12 Nov 2020 09:57:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=UeXYzGmFwiLtzZ9xz/VaILsxlUxjm1QVfMronrsYKxQ=;
 b=kXhXeEFKx4RDAOz6NlgCXjBr3JZ58PJcanFqWQSslH0BNpd3Y3x3xzPsQYx/oxcS0lJ0
 S/0HjitDsRc439yniSi9kpfsCsArg37N/JcEdqeyBKNZV4TD5yVbX4zt0eZQ9HCEKQet
 tFWwK3n3IJLmiSwpN+GiAl8VCzIQJ9XBGRQ2gwbCf1l7TEN+CLgz8ExM8MwdGAYOGY45
 dfTNALnpKWbfkOngE9AxJMZJu+XLTOnoPobdCMsHGpeyfQrnFlSAqP3uxI86puscP2TL
 S9paVEq66O8MOWYSsir2T548y7yoCE9DpYddkYpAkJrfQ+ypYDhUN9LYIsDM90+qqaKr 6g== 
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 34rn2yhkwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 09:57:26 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 12 Nov
 2020 15:57:24 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 12 Nov 2020 15:57:24 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 995307C;
        Thu, 12 Nov 2020 15:57:24 +0000 (UTC)
Date:   Thu, 12 Nov 2020 15:57:24 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: Fix order of regmap write log
Message-ID: <20201112155724.GF10899@ediswmail.ad.cirrus.com>
References: <20201112150217.459844-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201112150217.459844-1-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=936 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:02:17PM +0000, Lucas Tanure wrote:
> _regmap_write can trigger a _regmap_select_page, which will call
> another _regmap_write that will be executed first, but the log shows
> the inverse order
> 
> Also, keep consistency with _regmap_read which only logs in case of
> success
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
