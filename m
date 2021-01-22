Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD0300411
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbhAVNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:23:20 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:52940 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727748AbhAVNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:22:25 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MDD3FR025324;
        Fri, 22 Jan 2021 07:21:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Fr/ADTXUXb7ofXRfa5Zu7AU+FL4k+Px8FrLcUcJg+54=;
 b=K77Mnw9x/nkLI+/QLfCNE/QbkVOr/aRnr2lYnkdyFAg43EVeY5SG4k6FGhB1uHGd7w+Q
 QdkbzgzSZjcEo0puhWTkz8/iOLTzUQlnKN74QRq9qXPRiOG2SYUj4lriM8EiHOYeAZnY
 EblRdqb3EuXl2fkvXykkaD3RmS/xFuPRQiq86+HC7xeniJag7LYbyhVTWu9tGkXLvtWf
 nZWeXlUGHzH/Xbg7rs/rqG3bfBhfdzrCohklg5EgEENyEWfhKRn7AEZc4JEJCh3IqKpU
 1BjWiTgQ/+LW+5SqqaTJCZrNiaRFJTkqPJLHHpWGNihcuf8hhc+YjKmPFTwcHkZfkuyA hw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36692rbp7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Jan 2021 07:21:29 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 22 Jan
 2021 13:21:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 22 Jan 2021 13:21:27 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8AD1A45;
        Fri, 22 Jan 2021 13:21:21 +0000 (UTC)
Date:   Fri, 22 Jan 2021 13:21:21 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 08/12] ASoC: arizona-jack: convert into a helper
 library for codec drivers
Message-ID: <20210122132121.GJ106851@ediswmail.ad.cirrus.com>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-9-hdegoede@redhat.com>
 <CAHp75VeSqVYWE9o-6JwY+pmjU7nfBJwZvaSk0v-ngjeGMMxQAQ@mail.gmail.com>
 <e902dc43-42d1-c90b-98df-d054a72a5558@opensource.cirrus.com>
 <5c1f181f-f074-397d-cdba-d37ab58f9a2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5c1f181f-f074-397d-cdba-d37ab58f9a2b@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 05:55:00PM +0100, Hans de Goede wrote:
> On 1/19/21 10:51 AM, Richard Fitzgerald wrote:
> > On 18/01/2021 17:24, Andy Shevchenko wrote:
> >> On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 1. Keep the code as is, live with the debugfs error. This might be
> best for now, as I don't want to grow the scope of this series too much.
> I will go with this for the next version of this series (unless
> I receive feedback otherwise before I get around to posting the next
> version).

Thinking about this more, I seem to remember this is something
that has been discussed before, having the need to have
situations where a driver and the framework are both managing the
regulator at once on the same device.

I wonder if this commit was related to that:

commit ff268b56ce8c ("regulator: core: Don't spew backtraces on duplicate sysfs")

Apologies I don't have as much time as I normally would to look
into such issues at the moment, due to various internal company
things going on.

I do suspect that this option is the way to go though and if
there are issues of duplicates being created by the regulator
core those probably need to be resolved in there. But that can
probably be done separate from this series.

Thanks,
Charles
