Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD31229F917
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 00:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgJ2X3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 19:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2X3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 19:29:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0E4C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XCYbtpSLlHZgR44uwQBH0C/NshtPrxHNB4Q4tPgyX/c=; b=kHSurv0NEi3qeoRT38E9TompLQ
        ViQMnQBzZ1BSg25wtATytDsDsZnycZcpQM/MsFgM57d7pKljW4FeuLy0tgdHddlgZVV06SF3uaN6+
        aesfc81VNOlgvyFqO06Ip11mYdbyQSQ2PBcb59wyVeEHn0kdrkqvIEGz41Li5SkQX52uRkEw6ioTn
        XA/poKyFsyNXHSfSWOyiVUc54w7qpExA08gOTr2LGTaZqXCcJ0KNzBvOo6Lkmd9hpsMbneOSwOtbw
        Y8MuuHYBwTvggL17yqGFOfTSuZVpZN5CQBOhyEg916ChbNf+KHMu5zVjXJ5/1DdnnhKEHkCbQJyNH
        tG0YfXpQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYHLn-00070n-S0; Thu, 29 Oct 2020 23:29:00 +0000
Subject: Re: [Build fail] i386 & nvdimm is unhappy
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Philip Li <philip.li@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
References: <87sg9wodp1.fsf@nanos.tec.linutronix.de>
 <CAPcyv4hBSwdDocpgFh2=qbVQN=Mc+15cW4cV5m_S-SxVCYY=mA@mail.gmail.com>
 <20201029230920.GA32559@intel.com>
 <d066788b-0f69-37e5-fd5c-12755f498677@infradead.org>
Message-ID: <8613f74e-b774-a544-60df-b8012cc4ee14@infradead.org>
Date:   Thu, 29 Oct 2020 16:28:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d066788b-0f69-37e5-fd5c-12755f498677@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 4:13 PM, Randy Dunlap wrote:
> On 10/29/20 4:09 PM, Philip Li wrote:
>> On Thu, Oct 29, 2020 at 03:52:42PM -0700, Dan Williams wrote:
>>> On Thu, Oct 29, 2020 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> Dan,
>>>>
>>>> x86 32bit build fails with the config below with this:
>>>>
>>>>   ERROR: modpost: "phys_to_target_node" [drivers/nvdimm/nd_e820.ko]
>>>>   undefined!
>>>
>>> Acknowledged, I'm on it.
>>>
>>> Wonder how 0-day missed this or I missed the 0-day report?
>> Sorry about this Dan. Can you share some info like which kconfig and bad commit?
>> We will investigate this to provide update in earliest time.
>>
>> Thanks
>>
>>>
> 
> I posted earlier today about the same failure on x86_64 & linux-next:
> 
> https://lore.kernel.org/linux-next/0faac4da-a7bc-3fc7-e278-ad4f72499224@infradead.org/T/#u
> 
> 
> Thomas and I both included kernel config files.
> 

Here is a patch that Dan was cc-ed on.

https://lore.kernel.org/linux-mm/aaae71a7-4846-f5cc-5acf-cf05fdb1f2dc@oracle.com/


-- 
~Randy

