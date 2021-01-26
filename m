Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6E3045E6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393975AbhAZSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:03:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11193 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390804AbhAZJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:08:37 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQ17F5MMJzl9y1;
        Tue, 26 Jan 2021 17:06:17 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 17:07:26 +0800
Message-ID: <600FDBCE.8000405@hisilicon.com>
Date:   Tue, 26 Jan 2021 17:07:26 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Added some missing DT settings for Hikey 970
References: <cover.1610710288.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1610710288.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/1/15 19:53, Mauro Carvalho Chehab wrote:
> The Hikey 970 device tree has a few missing pieces that are required
> in order for it to be able to support USB and DRM drivers upstream.
> 
> Besides PM, USB and DRM specific bits, the hardware's binding
> for I2C buses and pinctrl are missing.
> 
> Those DT bindings come from the official Linaro Hikey 970 tree:
> 
> 	https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> 
> Changed in order to apply cleanly upstream.
> 
> PS.: The changes from this series were submitted initially on this
> patch series:
> 	Move Hikey 970 USB support out of staging and add DT
> 	https://lore.kernel.org/lkml/cover.1605530560.git.mchehab+huawei@kernel.org/
> 
> I'm opting to split such series into separate patch series, in order to 
> make easier for review and upstream merge, as the original series
> was mixing patches for different subsystems.
> 
> Mauro Carvalho Chehab (3):
>   arm64: dts: hisilicon: hi3670.dtsi: add iomcu_rst
>   arm64: dts: hikey970-pinctrl.dtsi: add missing pinctrl settings
>   arm64: dts: hisilicon: hi3670.dtsi: add I2C settings
> 
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  77 +++
>  .../boot/dts/hisilicon/hikey970-pinctrl.dtsi  | 548 +++++++++++++++++-
>  2 files changed, 614 insertions(+), 11 deletions(-)
> 

Thanks!
Series applied to the hisilicon arm64 dt tree with minor changes to align with
the dtschema.

Best Regards,
Wei
