Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065BA2E93C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbhADKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:55:24 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49010 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbhADKzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:55:24 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 104AmOjj027438;
        Mon, 4 Jan 2021 04:54:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=rIAbe0Jjmcjbx92aWb/vQZbVIa87rMdJCoAHcZSLa9Q=;
 b=fpXi588JBFSESd2ZmxUOStrmceX/gfIae/USlZvnwWhehbVgdis8BYc79KYgpyaPDBSy
 pH257Sd4j7FFPfF2woLxr9y0FxYvvA4kfNCe8F/0+FJNC8VqO5tGjCp6/PkS954YwodX
 JBuLPI1SGTHg9bKlGVsUL656hSSEYi9G5iTLrOEQirWM8tV85bLW+oYmFIs5xhn4Uc+H
 MQ/0qaLKVzyVQd99LeAEveOL2MEFRgNQTkPNwp7gxChM3ljTHcuwKjYmpBctzhD71LZM
 B7vyf4svn95c4b7T2Kei4P28fTMGxa3pWQ5WHnfqwslOETNyMLQp/mK7qJmH3TdBOU+X wg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35tp4thbnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 Jan 2021 04:54:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 Jan 2021
 10:54:31 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 4 Jan 2021 10:54:31 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C1BC811CB;
        Mon,  4 Jan 2021 10:54:31 +0000 (UTC)
Date:   Mon, 4 Jan 2021 10:54:31 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Adam Ford <aford173@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
Message-ID: <20210104105431.GR9673@ediswmail.ad.cirrus.com>
References: <20201217162740.1452000-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201217162740.1452000-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=930
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:27:40AM -0600, Adam Ford wrote:
> The driver can request an optional clock for mclk.
> Update the txt file to reflect this.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
