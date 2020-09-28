Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA1D27A9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1Irg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:47:36 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:49905 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1Irg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:47:36 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5f71a31f2bb-f1168; Mon, 28 Sep 2020 16:47:29 +0800 (CST)
X-RM-TRANSID: 2eeb5f71a31f2bb-f1168
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85f71a31f8be-57d56;
        Mon, 28 Sep 2020 16:47:29 +0800 (CST)
X-RM-TRANSID: 2ee85f71a31f8be-57d56
Subject: Re: [PATCH] usb: phy: tegra: Use IS_ERR() to check and simplify code
To:     Felipe Balbi <balbi@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200910115607.11392-1-tangbin@cmss.chinamobile.com>
 <87imc3eiug.fsf@kernel.org> <20200924102139.GF2483160@ulmo>
 <87pn6bcvfm.fsf@kernel.org>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <ae9e3c71-9532-ad13-2109-a278121cf76e@cmss.chinamobile.com>
Date:   Mon, 28 Sep 2020 16:47:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87pn6bcvfm.fsf@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

ÔÚ 2020/9/24 18:37, Felipe Balbi Ð´µÀ:
> Thierry Reding <thierry.reding@gmail.com> writes:
>
>> On Thu, Sep 24, 2020 at 10:26:15AM +0300, Felipe Balbi wrote:
>>> Tang Bin <tangbin@cmss.chinamobile.com> writes:
>>>
>>>> Use IS_ERR() and PTR_ERR() instead of PTR_ERR_OR_ZERO() to
>>>> simplify code, avoid redundant judgements.
>>>>
>>>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>>>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>>> Applied for next merge window. Make sure to get this driver out of
>>> drivers/usb/phy and moved into drivers/phy ASAP.
>> Sergei had commented on this patch with valid concerns, see here in case
>> you don't have his reply in your inbox:
>>
>>      http://patchwork.ozlabs.org/project/linux-tegra/patch/20200910115607.11392-1-tangbin@cmss.chinamobile.com/#2526208
>>
>> I agree with those concerns. This patch is broken because it will output
>> the wrong error code on failure. I don't fully agree with Sergei's point
>> that this patch isn't worth redoing. I do like the idiomatic error
>> handling better, but I think we shouldn't be breaking the error messages
>> like this.
> Sure thing, dropped for now.

Sorry, it's my fault.

Thanks

Tang Bin

>


