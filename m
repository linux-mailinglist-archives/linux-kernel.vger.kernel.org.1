Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119292775E8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgIXPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:54:54 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:2464 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgIXPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:54:54 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08OFWZfn028781;
        Thu, 24 Sep 2020 10:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=+V5ScHl8y00XCF6tNTYIzWEom6mPrtUUj1HFsN2ymvs=;
 b=SQ4BHcQG9fvuuH+5P2oGuyvzKelzXw3Jse0XYL5mmZoglLa0wsj88I/txzceCMg6Yg7F
 8ofxutNjf04qMhlCb+2A41zuORsGomDaD9je11ZjtnBJza8eiTBjRYVE+WN48+E/byB+
 bFdWSDAbBebzKYqNuR5ZueKdG0MUYybEfJuoC1p5qAisJDX0lKvyggj5YYz7dBUckjn1
 pvmAEmnRQMrts+wNOdEDJ0vwqZ9V4Cq8Ud+zCmNntB0JiwQBMajKECEqGJVQ/HUFDSit
 o1K7dmIWLURbR4415/jgsu8AbHsXPJAQEm3O5DjmA8dL+78wsVi8XHY++j45uKSb1fF7 Xw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 33nfd26wk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 10:54:46 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 24 Sep
 2020 16:54:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 24 Sep 2020 16:54:44 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B696D45;
        Thu, 24 Sep 2020 15:54:44 +0000 (UTC)
Date:   Thu, 24 Sep 2020 15:54:44 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 4/8] mfd: wm: Constify static struct resource
Message-ID: <20200924155444.GU10899@ediswmail.ad.cirrus.com>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-5-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200922192659.14535-5-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=930 adultscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:26:55PM +0200, Rikard Falkeborn wrote:
> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
