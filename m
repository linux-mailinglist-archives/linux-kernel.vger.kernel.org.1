Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7542FCF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbhATLkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388574AbhATK7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:59:04 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4921C21744;
        Wed, 20 Jan 2021 10:58:24 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l2BBu-008vIz-4y; Wed, 20 Jan 2021 10:58:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 20 Jan 2021 10:58:22 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Justin He <Justin.He@arm.com>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <Cristian.Marussi@arm.com>
Subject: Re: [RFC PATCH 0/2] Avoid booting stall caused by
 idmap_kpti_install_ng_mappings
In-Reply-To: <AM6PR08MB43763910418580E3A470BF27F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <AM6PR08MB43763910418580E3A470BF27F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <e8a45079ae30232eaa889f026439da9e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Justin.He@arm.com, Catalin.Marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com, Suzuki.Poulose@arm.com, Mark.Rutland@arm.com, gustavoars@kernel.org, richard.henderson@linaro.org, Dave.Martin@arm.com, Steven.Price@arm.com, akpm@linux-foundation.org, rppt@kernel.org, ardb@kernel.org, gshan@redhat.com, wangkefeng.wang@huawei.com, broonie@kernel.org, Cristian.Marussi@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

On 2021-01-20 04:51, Justin He wrote:
> Hi,
> Kindly ping 😊
> 
>> -----Original Message-----
>> From: Jia He <justin.he@arm.com>
>> Sent: Wednesday, January 13, 2021 9:41 AM
>> To: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
>> <will@kernel.org>; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Cc: Anshuman Khandual <Anshuman.Khandual@arm.com>; Suzuki Poulose
>> <Suzuki.Poulose@arm.com>; Justin He <Justin.He@arm.com>; Mark Rutland
>> <Mark.Rutland@arm.com>; Gustavo A. R. Silva <gustavoars@kernel.org>;
>> Richard Henderson <richard.henderson@linaro.org>; Dave P Martin
>> <Dave.Martin@arm.com>; Steven Price <Steven.Price@arm.com>; Andrew 
>> Morton
>> <akpm@linux-foundation.org>; Mike Rapoport <rppt@kernel.org>; Ard
>> Biesheuvel <ardb@kernel.org>; Gavin Shan <gshan@redhat.com>; Kefeng 
>> Wang
>> <wangkefeng.wang@huawei.com>; Mark Brown <broonie@kernel.org>; Marc 
>> Zyngier
>> <maz@kernel.org>; Cristian Marussi <Cristian.Marussi@arm.com>
>> Subject: [RFC PATCH 0/2] Avoid booting stall caused by
>> 
>> There is a 10s stall in idmap_kpti_install_ng_mappings when kernel 
>> boots
>> on a Ampere EMAG server.
>> 
>> Commit f992b4dfd58b ("arm64: kpti: Add ->enable callback to remap
>> swapper using nG mappings") updates the nG bit runtime if kpti is
>> required.
>> 
>> But things get worse if rodata=full in map_mem(). NO_BLOCK_MAPPINGS |
>> NO_CONT_MAPPINGS is required when creating pagetable mapping. Hence 
>> all
>> ptes are fully mapped in this case. On a Ampere EMAG server with 256G
>> memory(pagesize=4k), it causes the 10s stall.
>> 
>> After moving init_cpu_features() ahead of early_fixmap_init(), we can 
>> use
>> cpu_have_const_cap earlier than before. Hence we can avoid this stall
>> by updating arm64_use_ng_mappings.
>> 
>> After this patch series, it reduces the kernel boot time from 14.7s to
>> 4.1s:
>> Before:
>> [   14.757569] Freeing initrd memory: 60752K
>> After:
>> [    4.138819] Freeing initrd memory: 60752K
>> 
>> Set it as RFC because I want to resolve any other points which I have
>> misconerned.

But you don't really explain *why* having the CPU Feature discovery
early helps at all. Is that so that you can bypass the idmap mapping?
I'd expect something that explain the problem instead of paraphrasing
the patches.

Another thing is whether you have tested this on some ThunderX HW
(the first version, not TX2), as this is the whole reason for this
code...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
