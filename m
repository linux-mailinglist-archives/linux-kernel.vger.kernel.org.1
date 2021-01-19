Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516F12FAEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404891AbhASCLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:11:39 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:49106 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404715AbhASCLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:11:34 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 10:10:51 +0800
Received: from [10.32.56.37] (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 19 Jan
 2021 10:10:49 +0800
Subject: Re: [PATCH] x86/cpu/zhaoxin: Fix wrong lowercase naming and indent
To:     Isaac Chen <tingyi364@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo-oc@zhaoxin.com>, <QiyuanWang@zhaoxin.com>,
        <HerryYang@zhaoxin.com>, <CooperYan@zhaoxin.com>
References: <20210118172558.19426-1-tingyi364@gmail.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <a0fe603b-098c-65d7-9d60-f0365b7302ce@zhaoxin.com>
Date:   Tue, 19 Jan 2021 10:10:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210118172558.19426-1-tingyi364@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.56.37]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2021 01:25, Isaac Chen wrote:
> This is printed during kernel boot, match it with other supported x86 cpus.
>     [    0.000000] KERNEL supported cpus:
>     [    0.000000]   Intel GenuineIntel
>     [    0.000000]   AMD AuthenticAMD
>     [    0.000000]   Hygon HygonGenuine
>     [    0.000000]   Centaur CentaurHauls
>     [    0.000000]   zhaoxin   Shanghai
> 
> Signed-off-by: Isaac Chen <tingyi364@gmail.com>
> ---
>  arch/x86/kernel/cpu/zhaoxin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
> index 05fa4ef63490..f155bbd2aa97 100644
> --- a/arch/x86/kernel/cpu/zhaoxin.c
> +++ b/arch/x86/kernel/cpu/zhaoxin.c
> @@ -120,8 +120,8 @@ zhaoxin_size_cache(struct cpuinfo_x86 *c, unsigned int size)
>  #endif
>  
>  static const struct cpu_dev zhaoxin_cpu_dev = {
> -	.c_vendor	= "zhaoxin",
> -	.c_ident	= { "  Shanghai  " },
> +	.c_vendor	= "Zhaoxin",

Thanks for this patch.

> +	.c_ident	= { "Shanghai" },

The Vendor Identification String from CPUID leaf 0x00000000 of Zhaoxin
CPUs is not "Shanghai", ".c_ident = { "Shanghai" }," will cause the
matching of Zhaoxin CPUs fail.
Please do not modify ".c_ident = { "  Shanghai  " },".

Sincerely,
Tonyw
