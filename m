Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86AA2A3764
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKBX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgKBX7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:59:20 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84406C0617A6;
        Mon,  2 Nov 2020 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kq5zl3zxK4YCSEMFuwsnwaP6L+NpwyRjMkpocdwcKhE=; b=CZilSElbfGYe4hk/zbGuQ9hUp6
        27s3aXWr9fwyvkpavFiHVMXX7NN8mG9b8LDbhCNRgZouzdgNK6OezF3GArzsV6L3j/RyrFO+CBptQ
        TSjuJFZyHlyBbz/UBZ5sBfrzum4D5Y8ISf8kmOt2VtLwFs7TukVoIJfsdqXZK/m/zNTfj+NffC2po
        1sN/AsHbDecArg5JxYqqWnVP6OjsEbme31c5onfFuitLAVf1krpes/P3HYVXacQGzNhOwx/wAL71e
        +HAt+837kddLHTxzLc0MqMEv9SCu55eNlFxx5BC4nwf46dv+/7TdTkC3nM2lLwM1QcVDgYsgnYGhK
        Hgc3onQQ==;
Received: from [2601:1c0:6280:3f0::60d5]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZjjI-0006Zj-V6; Mon, 02 Nov 2020 23:59:17 +0000
Subject: Re: [PATCH] clk: imx: scu: Fix compile error with module build of
 clk-scu.o
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <208469.1604318525@turing-police>
 <6e5a8fdb-0a02-5eae-ca1f-37df8a454e34@infradead.org>
 <238534.1604350899@turing-police>
 <0b61c4f4-b389-c853-6e09-ee603455e583@infradead.org>
 <20201102235218.GY31601@dragon>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fa030692-ec91-93c6-559a-77d82ef54928@infradead.org>
Date:   Mon, 2 Nov 2020 15:59:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102235218.GY31601@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 3:52 PM, Shawn Guo wrote:
> On Mon, Nov 02, 2020 at 01:31:59PM -0800, Randy Dunlap wrote:
>> On 11/2/20 1:01 PM, Valdis Klētnieks wrote:
>>> On Mon, 02 Nov 2020 09:15:20 -0800, Randy Dunlap said:
>>>
>>>> also
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> However, this driver does not directly use <linux/module.h>.
>>>
>>> Just my luck - I looked at 3 or 4 other things that include of_platform.h
>>> and they all *did* include module.h.
>>>
>>>> platform_device.h #includes <linux/device.h>, which is where the
>>>> problem lies:
>>>>
>>>> <linux/device.h> uses macros that are provided by <linux/module.h>
>>>> so <linux/device.h> should #include <linux/module.h>.
>>>>
>>>> and that fixes this commit:
>>>>
>>>> commit 4c002c978b7f2f2306d53de051c054504af920a9
>>>> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Date:   Mon Dec 9 20:33:03 2019 +0100
>>>>
>>>>     device.h: move 'struct driver' stuff out to device/driver.h
>>>
>>> OK.. who's going to do that? Me, or Randy, or Greg?
>>
>> You could go ahead... I began on it yesterday but didn't finish
>> testing, although I did see the same build error that the 0day
>> bot reported, so I don't know what it's going to take to fix that.
> 
> It's a driver problem which is being addressed by Dong's patch[1].
> 
> Shawn
> 
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201030153733.30160-1-aisheng.dong@nxp.com/
> 

Thanks for the info & link.

-- 
~Randy

