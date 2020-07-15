Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866122202E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgGODWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:22:09 -0400
Received: from foss.arm.com ([217.140.110.172]:37648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgGODWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:22:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6600C1FB;
        Tue, 14 Jul 2020 20:22:08 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68C03F718;
        Tue, 14 Jul 2020 20:22:06 -0700 (PDT)
Subject: Re: [PATCH] riscv: Select ARCH_HAS_DEBUG_VM_PGTABLE
To:     Emil Renner Berthing <kernel@esmil.dk>,
        linux-riscv@lists.infradead.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
References: <20200714212611.19692-1-kernel@esmil.dk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0d7d0c38-5b67-1793-47d7-b8a7714838ee@arm.com>
Date:   Wed, 15 Jul 2020 08:50:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200714212611.19692-1-kernel@esmil.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/15/2020 02:56 AM, Emil Renner Berthing wrote:
> This allows the pgtable tests to be built.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
> 
> The tests seem to succeed both in Qemu and on the HiFive Unleashed
> 
> Both with and without the recent additions in
> https://lore.kernel.org/linux-riscv/1594610587-4172-1-git-send-email-anshuman.khandual@arm.com/

That's great, thanks for testing.
