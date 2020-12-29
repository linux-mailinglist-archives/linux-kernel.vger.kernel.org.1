Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A842E70C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgL2NHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:07:53 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54386 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgL2NHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:07:52 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTCviBw002861;
        Tue, 29 Dec 2020 07:07:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=uU90DJMC7gOVeuziT4MtY3N83Bz0OgswiG8k+8q6tXM=;
 b=Ik8e7Jr+W2X4P2xZq97YXVi9lYDg5kNMlHYu08QQDfpsxhYOmx9xaCxSb9y0gqirD3j4
 BG9XiHTp3O5bQ+0HlSJ08M+Jm4M1SZz9xnaJfFlTPBsDxvzdCfl699YtCodxOxrZwWr3
 0rAQT7LMhOKdrg1NJ2jWMtgW91F8AxIU3+x1tklVyN+gpGVcm1GEBEFl1KfIAC+mQMkb
 Hf9XqTTljT/epI3KvMlBDAmRfkXYwmJCUI5tweuEAAM7f0uACRVzn2EGIPhc8hIH2eZp
 DjXdsvb5gvfZ9Ykt302+aukXE9EOShj/PMqDzi2TCtWk3WHp1UGY+PrOMnu55oFBofN2 Gw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 35p3f7aa01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 07:07:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 29 Dec
 2020 13:06:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 29 Dec 2020 13:06:57 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D391F2AB;
        Tue, 29 Dec 2020 13:06:57 +0000 (UTC)
Date:   Tue, 29 Dec 2020 13:06:57 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
Message-ID: <20201229130657.GN9673@ediswmail.ad.cirrus.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201228162807.GE5352@sirena.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=791
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 04:28:07PM +0000, Mark Brown wrote:
> On Mon, Dec 28, 2020 at 02:16:04PM +0100, Hans de Goede wrote:
> 
> > And more in general AFAIK extcon is sort of deprecated and it is
> > not advised to use it for new code. I would esp. not expect it to
> > be used for new jack-detection code since we already have standard
> > uAPI support for that through sound/core/jack.c .
> 
> Has Android been fixed to use the ALSA/input layer interfaces?  That's
> why that code is there, long term the goal was to have ALSA generate
> extcon events too so userspace could fall over to using that.  The basic
> thing at the time was that nobody liked any of the existing interfaces
> (the input layer thing is a total bodge stemming from it having been
> easy to hack in a key for GPIO detection and using ALSA controls means
> having to link against alsa-lib which is an awful faff for system level
> UI stuff) and there were three separate userspace interfaces used by
> different software stacks which needed to be joined together, extcon was
> felt to be a bit more designed and is a superset so that was the
> direction we were heading in.

Android has been updated to have the option to catch input events
for jack detection now.

I have always been slightly confused between extcon and the ALSA
jack reporting and have been unsure as to what is the longer term
plan here. I vaguely thought there was a gentle plan to move to
extcon, it is interesting to see Hans basically saying the
opposite that extcon is intended to be paritially deprecated. I
assume you just mean with respect to audio jacks, not other
connector types?

I would agree with Mark though that if extcon exists for external
connectors it seems odd that audio jacks would have their own
special way rather than just using the connector stuff.

Thanks,
Charles
