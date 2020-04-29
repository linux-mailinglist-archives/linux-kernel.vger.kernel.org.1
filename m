Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3331BD1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 03:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgD2BrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 21:47:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3373 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgD2BrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:47:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6E644CFB0050CEB9D614;
        Wed, 29 Apr 2020 09:46:54 +0800 (CST)
Received: from [10.166.212.221] (10.166.212.221) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 29 Apr
 2020 09:46:49 +0800
Subject: Re: [PATCH] soc: imx8m: Make imx8m_dsp_ops static
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Shawn Guo <shawnguo@kernel.org>,
        "Takashi Iwai" <tiwai@suse.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.co>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, Fabio Estevam <festevam@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20200425080026.143127-1-chentao107@huawei.com>
 <CAEnQRZA3g-AE-PE7yiKn0XpfWURV9wm=ztbtvyCoYnNv8G9O0Q@mail.gmail.com>
From:   "chentao (AS)" <chentao107@huawei.com>
Message-ID: <1c04916b-ed58-bdbb-6472-2998c27d9d50@huawei.com>
Date:   Wed, 29 Apr 2020 09:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAEnQRZA3g-AE-PE7yiKn0XpfWURV9wm=ztbtvyCoYnNv8G9O0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.212.221]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, i will resend v2 and add  Mark Brown broonie@kernel.org  
alsa-devel@alsa-project.org

On 2020/4/29 0:42, Daniel Baluta wrote:
> On Sat, Apr 25, 2020 at 11:03 AM ChenTao <chentao107@huawei.com> wrote:
>> Fix the following warning:
>>
>> sound/soc/sof/imx/imx8m.c:95:20: warning:
>> symbol 'imx8m_dsp_ops' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: ChenTao <chentao107@huawei.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
>
> Can you please resend (picking Acked-by/Reviewed-by tags) and
> as Kai said add:
>
> To: Mark Brown (broonie@kernel.org
> Cc: alsa-devel@alsa-project.org
> .
