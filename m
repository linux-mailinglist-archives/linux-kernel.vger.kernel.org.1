Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA5026CC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIPUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:40:08 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:42388 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726806AbgIPRGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:06:13 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 08GH0fGb000642;
        Wed, 16 Sep 2020 12:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=tswE/o+nEuqnPz1L70KM6dGVyJ8R2GgfFb65mjn5ES4=;
 b=jUAiLNj89aXLxh9MBsyyd7LGs4Eqs8lDXcCpKtllxhsPGcLolOn9RI4UM00NAwG9dXF0
 Dx/V8nn1swCuGmr3Gts6zmV1J7y/VINOBU3RsEn6I7U6spaJ0q3j96aYBejtyoDtAYOm
 11ed0Cqbj/lVDSRE43/akYNdmXKUIOFjhW9nPIcBJORNBe9kUN2hSMcLn2DoKYEl0HMS
 fR4opOl3A1SODKPYg6rSvo3aUul9cBpgmxaRecwIRipqny0LGDXdIBw+KfYKON5NfOaC
 7SriU8CA+xTIVAkhr1rhULQoSOmb1G+y9DZJeT1ssD6i8ZzjVLsVOCRx0iW+exthLtws qA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 33k5prhhp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Sep 2020 12:06:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 16 Sep
 2020 18:06:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 16 Sep 2020 18:06:01 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 440AE45;
        Wed, 16 Sep 2020 17:06:01 +0000 (UTC)
Date:   Wed, 16 Sep 2020 17:06:01 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: debugfs: Duplicate name string if delaying
 debugfs init
Message-ID: <20200916170601.GM10899@ediswmail.ad.cirrus.com>
References: <20200916154433.7003-1-ckeepax@opensource.cirrus.com>
 <20200916161418.GB6374@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916161418.GB6374@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=891
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:14:18PM +0100, Mark Brown wrote:
> On Wed, Sep 16, 2020 at 04:44:33PM +0100, Charles Keepax wrote:
> 
> > -		node->name = name;
> > +		node->name = kstrdup(name, GFP_KERNEL);
> > +		if (!node->name) {
> 
> Two things here - one is that this should be kstrdup_const(), the other
> is that we already took a copy of the name in __regmap_init() so the
> thing to do here is to change the regmap_debugfs_init() call there to
> use the copy we just made rather than the copy in the config.

Thanks Mark, I will have a look and update.

Thanks,
Charles
