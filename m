Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26382922A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgJSGsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:48:19 -0400
Received: from foss.arm.com ([217.140.110.172]:50424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgJSGsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:48:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04839D6E;
        Sun, 18 Oct 2020 23:48:18 -0700 (PDT)
Received: from [10.163.77.151] (unknown [10.163.77.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9A153F66E;
        Sun, 18 Oct 2020 23:48:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] mm/memory_hotplug, arm64: allow certain bootmem
 sections to be offlinable
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1602899443.git.sudaraja@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <840bfb6e-931e-baf6-a685-a74da73d4cc3@arm.com>
Date:   Mon, 19 Oct 2020 12:17:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1602899443.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudarshan,

On 10/17/2020 07:32 AM, Sudarshan Rajagopalan wrote:
> In the patch that enables memory hot-remove (commit bbd6ec605c0f ("arm64/mm: Enable memory hot remove")) for arm64, there’s a notifier put in place that prevents boot memory from being offlined and removed. The commit text mentions that boot memory on arm64 cannot be removed. But x86 and other archs doesn’t seem to do this prevention.
> 
> The current logic is that only “new” memory blocks which are hot-added can later be offlined and removed. The memory that system booted up with cannot be offlined and removed. But there could be many usercases such as inter-VM memory sharing where a primary VM could offline and hot-remove a block/section of memory and lend it to secondary VM where it could hot-add it. And after usecase is done, the reverse happens where secondary VM hot-removes and gives it back to primary which can hot-add it back. In such cases, the present logic for arm64 doesn’t allow this hot-remove in primary to happen.
> 
> Also, on systems with movable zone that sort of guarantees pages to be migrated and isolated so that blocks can be offlined, this logic also defeats the purpose of having a movable zone which system can rely on memory hot-plugging, which say virt-io mem also relies on for fully plugged memory blocks.
> 
> This patch tries to solve by introducing a new section mem map sit 'SECTION_MARK_HOTPLUGGABLE' which allows the concerned module drivers be able
> to mark requried sections as "hotpluggable" by setting this bit. Also this marking is only allowed for sections which are in movable zone and have unmovable pages. The arm64 mmu code on receiving the MEM_GOING_OFFLINE notification, we disallow offlining of any boot memory by checking if section_early or not. With the introduction of SECTION_MARK_HOTPLUGGABLE, we allow boot mem sections that are marked as hotpluggable with this bit set to be offlined and removed. Thereby allowing required bootmem sections to be offlinable.

This series was posted right after another thread you initiated in this regard
but without even waiting for it to conclude in any manner.

https://lore.kernel.org/linux-arm-kernel/de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org/ 

Inter-VM memory migration could be solved in other methods as David has mentioned.
Boot memory cannot be removed and hence offlined on arm64 due to multiple reasons
including making kexec non-functional afterwards. Besides these intrusive core MM
changes are not really required.

- Anshuman
