Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4457F1A61C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 05:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgDMDkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 23:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgDMDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 23:40:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30619C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 20:40:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB47630E;
        Sun, 12 Apr 2020 20:40:03 -0700 (PDT)
Received: from [10.163.1.49] (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DFCC3F6C4;
        Sun, 12 Apr 2020 20:40:00 -0700 (PDT)
Subject: Re: [PATCH 5/6] arm64/cpufeature: Drop TraceFilt feature exposure
 from ID_DFR0 register
To:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        james.morse@arm.com, maz@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <1580215149-21492-6-git-send-email-anshuman.khandual@arm.com>
 <bb4d5175-1c72-a1a6-1e79-116991717fdf@arm.com>
 <20200409125255.GA13078@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <42122aa6-9cce-c45e-d67f-f672badce675@arm.com>
Date:   Mon, 13 Apr 2020 09:09:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200409125255.GA13078@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/09/2020 06:23 PM, Will Deacon wrote:
> On Fri, Mar 20, 2020 at 06:19:21PM +0000, Suzuki K Poulose wrote:
>> On 01/28/2020 12:39 PM, Anshuman Khandual wrote:
>>> ID_DFR0 based TraceFilt feature should not be exposed.
>>
>> ... to guests.
>>
>>  Hence lets drop it.
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Hmm, doesn't dropping cause it to become NONSTRICT? In general, I'd prefer
> that we list all fields in these tables, rather than have implicit behaviour
> in their absence.

Just trying to understand, so we should just leave it unchanged.

ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0)

> 
> Will
> 
