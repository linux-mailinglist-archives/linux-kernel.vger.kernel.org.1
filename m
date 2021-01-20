Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7F2FCE34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbhATKTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:19:01 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:28380 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730929AbhATKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:03:46 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10K9voSf022653;
        Wed, 20 Jan 2021 04:02:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=3cMPXgGKn9KcSz1orpznqtODBy5qNer/ihVn8Z7C4bU=;
 b=eP2mmFyMdNKz+7w5BAOD6hIfBQ/4n08GaWSnkNEN5zoDKLurzm2xqv5+ZnJPAYaK1/3v
 8G8U+OdfOYTpI2lD7abf1aRFYyzjL/9s3YGRAYs3eBqf7To7RcEPjhpXxToe0f+YbWR1
 JC/qUUR71k3OdtnRczL5eIz4qb5kJqcm2LX9+WLO57HeR7/Vk1o3Pxw9vb2IOgzFznG9
 hEVq/O8qtrw8TXiRkda2hT2GR1NmKs1Eqd+fudWAz1+9IoXqfebAHCx5ao0d8Y3kIiOQ
 GpFruTEd3rKMapFPImUWZwQYA9Bb1KuSTB6MN44TUkqIo0uErOIEQ+6miATtlbgLQAnc rA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36692r8gfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Jan 2021 04:02:53 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 20 Jan
 2021 10:02:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 20 Jan 2021 10:02:51 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 907C045;
        Wed, 20 Jan 2021 10:02:51 +0000 (UTC)
Date:   Wed, 20 Jan 2021 10:02:51 +0000
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
Subject: Re: [PATCH v3 2/5] mfd: arizona: Replace arizona_of_get_type() with
 device_get_match_data()
Message-ID: <20210120100251.GC106851@ediswmail.ad.cirrus.com>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210117212252.206115-3-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=743 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 10:22:49PM +0100, Hans de Goede wrote:
> Replace the custom arizona_of_get_type() function with the generic
> device_get_match_data() helper. Besides being a nice cleanup this
> also makes it easier to add support for binding to ACPI enumerated
> devices.
> 
> While at it also fix a possible NULL pointer deref of the id
> argument to the probe functions (this could happen on e.g. manual
> driver binding through sysfs).
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
