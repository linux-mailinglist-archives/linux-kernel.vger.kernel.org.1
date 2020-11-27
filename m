Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8742A2C6080
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405336AbgK0HbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:31:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8417 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgK0HbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:31:16 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cj5rq6ZfCz6wBk;
        Fri, 27 Nov 2020 15:30:51 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Nov
 2020 15:31:11 +0800
Subject: Re: [PATCH] usb: dwc3: meson-g12a: disable clk on error handling path
 in probe
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
        <linux-amlogic@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201111095256.10477-1-zhengzengkai@huawei.com>
 <CAFBinCANr3zC4VxeGFTXhz1ZmTiOJ44r7DX8EmPwOjezyFAmhQ@mail.gmail.com>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <7ea6de9c-f482-2f8e-1d54-b8c127d10f22@huawei.com>
Date:   Fri, 27 Nov 2020 15:31:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCANr3zC4VxeGFTXhz1ZmTiOJ44r7DX8EmPwOjezyFAmhQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

> On Wed, Nov 11, 2020 at 10:48 AM Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>> dwc3_meson_g12a_probe() does not invoke clk_bulk_disable_unprepare()
>> on one error handling path. This patch fixes that.
>>
>> Fixes: 347052e3bf1b ("usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> many thanks for this fix!
>
>
> Best regards
> Martin
> .
>
