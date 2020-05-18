Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67A1D7C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 17:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgERPCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 11:02:31 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40135 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:02:30 -0400
X-Originating-IP: 84.210.220.251
Received: from [192.168.1.123] (cm-84.210.220.251.getinternet.no [84.210.220.251])
        (Authenticated sender: fredrik@strupe.net)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 38FBCC000F;
        Mon, 18 May 2020 15:02:27 +0000 (UTC)
Subject: Re: [PING] [PATCH v2] arm: ptrace: Fix mask for thumb breakpoint hook
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
References: <20200413173841.29651-1-fredrik@strupe.net>
 <d7381f90-f597-2a9c-4387-5714b41e02e6@strupe.net>
 <20200518141858.GV1551@shell.armlinux.org.uk>
From:   Fredrik Strupe <fredrik@strupe.net>
Message-ID: <0afefde9-f121-c88c-2ceb-7c02f7561979@strupe.net>
Date:   Mon, 18 May 2020 17:02:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518141858.GV1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2020 16:18, Russell King - ARM Linux admin wrote:
> On Mon, May 18, 2020 at 03:12:06PM +0200, Fredrik Strupe wrote:
>> call_undef_hook() in traps.c applies the same instr_mask for both 16-bit
>> and 32-bit thumb instructions. If instr_mask then is only 16 bits wide
>> (0xffff as opposed to 0xffffffff), the first half-word of 32-bit thumb
>> instructions will be masked out. This makes the function match 32-bit
>> thumb instructions where the second half-word is equal to instr_val,
>> regardless of the first half-word.
>>
>> The result in this case is that all undefined 32-bit thumb instructions
>> with the second half-word equal to de01 (udf #1) work as breakpoints
>> and will raise a SIGTRAP instead of a SIGILL, instead of just the one
>> intended 16-bit instruction. An example of such an instruction is
>> eaa0b650, which is unallocated according to Arm ARM and should raise a
>> SIGILL, but instead raises a SIGTRAP.
>
> How can 0xeaa0b650 match 0xde01 when masked with 0xffff ?
>

Sorry, that is a typo; it should say 0xeaa0de01.

For reference, this is similar to the problem with SETEND emulation that
was fixed in commit fc2266011acc in the mainline kernel
(or as discussed here: https://lkml.org/lkml/2020/4/8/274).

Fredrik

