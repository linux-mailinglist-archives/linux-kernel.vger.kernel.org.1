Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83660290651
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408026AbgJPNaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:30:23 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:37922 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407834AbgJPNaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:30:23 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09GDKuI8031555;
        Fri, 16 Oct 2020 08:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=EIFdycrd2ap6D7qPrimuZQwoebezAFOPU6dKTD7N7RY=;
 b=jLPerM7HmVGBq0QyY8rZARuxbCIh18RcB6tih9Ep0hzLcDCOyiZzOUW6Er3dmUVw9eNT
 owe5oejeZrBeHmgXhaTocEsaQDdeYSChGFDkAGWuF8MtlNA7GafLeV62kGi+eLmeUYr8
 rAKS7h6wws6PnJw6vJS3PDxkZxrivhA+r6/gz3hPy6qbh/ME4O3EfPaSrk36b4H0UWy2
 vIvs9luwrnSpeOkNbHbGSclu4ykAlTVCmMhEZhCcZRuh+vOEjItmY+7HTyhqn9T81bQY
 CINAZRPc9DqnuYst8YMFoQJB9xl2+8vTLYc1NDFFkZ6UbuuMm9BTKfth0BxwT8QGtH/K EQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3439cng6gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Oct 2020 08:30:11 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 16 Oct
 2020 14:30:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 16 Oct 2020 14:30:09 +0100
Received: from [10.0.2.15] (ausnpc0lsnw1.ad.cirrus.com [198.61.64.143])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C87345;
        Fri, 16 Oct 2020 13:30:09 +0000 (UTC)
Subject: Re: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
To:     Mark Brown <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <nsaenzjulienne@suse.de>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014185632.GD4580@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
Date:   Fri, 16 Oct 2020 14:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014185632.GD4580@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=809 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010160100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 19:56, Mark Brown wrote:
> On Wed, Oct 14, 2020 at 03:54:11PM +0100, Richard Fitzgerald wrote:
>> This set of patches provides support for using the Cirrus Logic
>> Lochnagar audio development platform plus Cirrus Logic Madera/Arizona
>> codecs with the simple-card machine driver and a Raspberry Pi4. The
>> ultimate aim is to provide the dts file but some updates are needed to
>> the simple-card machine driver.
> 
> Why extend simple-card and not the more modern and flexible
> audio-graph-card?
> 

I'm struggling to understand how to use audio-graph-card where there are
multiple alternative codecs. The host I2S endpoint has to point back to
the codec endpoint, like this:

	cpu_i2s_ep_cs47l15: endpoint {
		remote-endpoint = <&cs47l15_aif1>;
	};

But obviously that depends on which codec node was enabled. Listing
multiple endpoints makes the whole port node disabled if any remote
endpoint is in a disabled node. I've tried adding status="disabled"
to endpoints or multiple port definitions with status="disabled" but
I haven't figured out a solution.
