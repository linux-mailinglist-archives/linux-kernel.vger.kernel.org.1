Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED352D38EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgLICmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:42:01 -0500
Received: from foss.arm.com ([217.140.110.172]:56860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgLICmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:42:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F1C1042;
        Tue,  8 Dec 2020 18:41:15 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0AC43F66B;
        Tue,  8 Dec 2020 18:41:12 -0800 (PST)
Subject: Re: [PATCH V2 0/2] mm/debug_vm_pgtable: Some minor updates
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        steven.price@arm.com, christophe.leroy@csgroup.eu,
        gerald.schaefer@linux.ibm.com, vgupta@synopsys.com,
        paul.walmsley@sifive.com
References: <1606825169-5229-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5ac12290-536d-968c-1ca6-10918403bb8f@arm.com>
Date:   Wed, 9 Dec 2020 08:11:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606825169-5229-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/20 5:49 PM, Anshuman Khandual wrote:
> This series contains some cleanups and new test suggestions from Catalin
> from an earlier discussion.
> 
> https://lore.kernel.org/linux-mm/20201123142237.GF17833@gaia/
> 
> This series is based on v5.10-rc6 and has been tested on arm64 and x86 but
> has only been build tested on riscv, s390, arc etc. It would be great if
> folks could test this on these platforms as well. Thank you.
> 
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Hello Gerald/Christophe/Vineet/Paul,

Could you please give this series a quick test on s390, ppc, arc,
and riscv platforms. Thank you.

- Anshuman
