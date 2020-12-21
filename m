Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0042DFB1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgLUKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:39:25 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:64838 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgLUKjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:39:25 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLAa20H005340;
        Mon, 21 Dec 2020 04:38:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=kqdrZOb2FKOv/PPkSfWW8gDUQTDnYAioyzgCwgZ6rwY=;
 b=RslDdVW4u3AMhMt7KVd3LndOMuy6lI0ypiM37Wos/JYCG4/lYBStcpHtTV6axoHpcM9g
 G41mDGnT1FZ2ujzc6HhKQl3AFdaLi92NAaTmzg6ffHLz9+4GmE2Mx5dtu8Z9qt7Qeu8h
 wn0Tcdhp9tUgZsH6kZvih8o3MysFxaiwjY/9latiAvzt7gnnSUXU5eW+nr5lpwcTWu6o
 kLB9mN0l7qscO4LIPyUyFirqZs3KA9OAx8A+aDtKgwHGs/rQ1Yad3/vQ502isCWBRL+t
 I61dqUImyjrtlQwR6caRUFi4rEcD1AscnQDcsDlOg8K2fEb7ywLdgFfWd/uL4cM0JedS DQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35hetuhqqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Dec 2020 04:38:25 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Dec
 2020 10:38:23 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 21 Dec 2020 10:38:23 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.186])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0B45511CB;
        Mon, 21 Dec 2020 10:38:22 +0000 (UTC)
Subject: Re: [PATCH v3 3/6] ASoC: audio-graph-card: Support setting component
 plls and sysclks
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <nsaenzjulienne@suse.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201217154142.24301-1-rf@opensource.cirrus.com>
 <20201217154142.24301-4-rf@opensource.cirrus.com>
 <873604gf45.wl-kuninori.morimoto.gx@renesas.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <35430e71-5718-de7f-9587-73d15ed6507a@opensource.cirrus.com>
Date:   Mon, 21 Dec 2020 10:38:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <873604gf45.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=876 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2020 00:03, Kuninori Morimoto wrote:
> 
> Hi Richard
> 
> Thank you for your patch.
> This is v3 patch, but I think this is the first time for me
> to receive patch...

Yes sorry.
Somehow I missed you off V1 and V2 emails.

> 
>> Some codecs need plls and/or sysclks to be configured using the
>> snd_soc_component_set_[sysclk|pll] functions. These drivers cannot
>> necessarily be converted to use the clock framework. If the codec is on
>> a I2C/SPI bus, a nested clk_get would be needed to enable the bus clock.
>> But the clock framework does not support nested operations and this would
>> deadlock.
>>
>> This patch adds new dt properties that list phandles of components with
>> the pll/sysclk settings to be applied. Multiple settings can be given for
>> the same phandle to allow for components with multiple clocks and plls.
>> The plls and sysclks are enabled when the card bias level moves to STANDBY
>> and disabled when it moves to OFF.
>>
>> The implementation does not attempt to handle specifying complex clock
>> ordering interdependencies between components. The plls and sysclks are
>> applied to a component as it is passed to the card set_bias_level/
>> set_bias_level_post callbacks. It follows from this that the order
>> components are configured is the order that they are passed to those
>> callbacks.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   include/sound/simple_card_utils.h     |  25 +++
>>   sound/soc/generic/audio-graph-card.c  |  16 +-
>>   sound/soc/generic/simple-card-utils.c | 236 ++++++++++++++++++++++++++
>>   3 files changed, 275 insertions(+), 2 deletions(-)
> 
> I understand that you need sysclk/pll and .set_bias_level_xxx().
> But I guess makes it generic code is difficult (?).
> Thus, as Sameer doing on Tegra, creating custom audio-graph-card is better
> idea for you ?
> 
> # Now I'm creating new audio-graph-card2 which also supports
> # overwriting/customizing each/all functions.
> # It is not full compatible with audio-graph-card, but almost same if you
> # uses normal connection.
> # I hope I can post it next year
> 
> Thank you for your help !!
> 
> Best regards
> ---
> Kuninori Morimoto
> 
