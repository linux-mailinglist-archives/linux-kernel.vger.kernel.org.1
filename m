Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB50253B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 03:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgH0Big (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 21:38:36 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:23126 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgH0Bif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:38:35 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75f470e8b6d9-61641; Thu, 27 Aug 2020 09:38:20 +0800 (CST)
X-RM-TRANSID: 2ee75f470e8b6d9-61641
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55f470e8be69-26624;
        Thu, 27 Aug 2020 09:38:20 +0800 (CST)
X-RM-TRANSID: 2ee55f470e8be69-26624
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unnecessary check
 infsl_spdif_probe()
To:     Mark Brown <broonie@kernel.org>
Cc:     timur@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
 <20200826165308.GJ4965@sirena.org.uk>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <f2196e55-6458-4f55-96ac-bd18ecb461d1@cmss.chinamobile.com>
Date:   Thu, 27 Aug 2020 09:37:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200826165308.GJ4965@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

在 2020/8/27 0:53, Mark Brown 写道:
> On Wed, Aug 26, 2020 at 11:09:18PM +0800, Tang Bin wrote:
>> The function fsl_spdif_probe() is only called with an openfirmware
>> platform device. Therefore there is no need to check that the passed
>> in device is NULL.
> Why is this an issue - the check will make things more robust if someone
> manages to load the driver on a non-DT system and otherwise costs us a
> couple of instructions?
Thanks for your reply.

In this function,  function fsl_spdif_probe() can be triggered only if 
the platform_device and platform_driver matches,

so I think the judgement at the beginning is redundant.

Thanks

Tang Bin



