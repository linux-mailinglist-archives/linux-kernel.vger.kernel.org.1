Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5D2DE09A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgLRJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 04:50:59 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51806 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgLRJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:50:58 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BI9l2Cm002296;
        Fri, 18 Dec 2020 03:50:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=+DbrQ5Y3H2OWg91wM1nYGA5xHFRnNWJLC9gVxMqCU70=;
 b=N7Js67CAOucvCreWgbF/qAg+ik8I0kux7RC4G7mtn+OxX+s8EZHviirgi7CIAO3GZYnb
 aXgYhiOxs8MOqIo9/T+Y2J4pN8KrI2nPyBa6QZ8mQPMPBaLAqqYg/aFXOKwtBt0CK2kZ
 3vlchgCw5zJBiXSDQQjqaMM/6uB15VW0v62BCVLA8ak4dW+Y/zafRbdZYBtjBmX00fC6
 ASTkF6ACIw2oyEga9UpqwPEMufBWj3vIavPZi0M0NnqhR7fnCXf8uL1nxbUVO/6rbYs9
 GJ0r6lKxsuPC9cILnVdkWI+aG/dGwxipeUCXo+0VqRcwGiy7BSk2aXOQ3BZncJGZP+R2 EQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5ryxh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Dec 2020 03:50:03 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Dec
 2020 09:50:01 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 18 Dec 2020 09:50:01 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6BCC711CA;
        Fri, 18 Dec 2020 09:50:01 +0000 (UTC)
Date:   Fri, 18 Dec 2020 09:50:01 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-tdm-interface: fix loopback
Message-ID: <20201218095001.GF9673@ediswmail.ad.cirrus.com>
References: <20201217150812.3247405-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201217150812.3247405-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=968 suspectscore=0 spamscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 04:08:12PM +0100, Jerome Brunet wrote:
> When the axg-tdm-interface was introduced, the backend DAI was marked as an
> endpoint when DPCM was walking the DAPM graph to find a its BE.
> 
> It is no longer the case since this
> commit 8dd26dff00c0 ("ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks")
> Because of this, when DPCM finds a BE it does everything it needs on the
> DAIs but it won't power up the widgets between the FE and the BE if there
> is no actual endpoint after the BE.
> 
> On meson-axg HWs, the loopback is a special DAI of the tdm-interface BE.
> It is only linked to the dummy codec since there no actual HW after it.
> >From the DAPM perspective, the DAI has no endpoint. Because of this, the TDM
> decoder, which is a widget between the FE and BE is not powered up.
> 
> >From the user perspective, everything seems fine but no data is produced.
> 
> Connecting the Loopback DAI to a dummy DAPM endpoint solves the problem.
> 
> Fixes: 8dd26dff00c0 ("ASoC: dapm: Fix handling of custom_stop_condition on DAPM graph walks")
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
