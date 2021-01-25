Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762D030232C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbhAYJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:16:35 -0500
Received: from foss.arm.com ([217.140.110.172]:44120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbhAYJPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86F61042;
        Mon, 25 Jan 2021 00:50:40 -0800 (PST)
Received: from [10.163.91.197] (unknown [10.163.91.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 957DD3F66B;
        Mon, 25 Jan 2021 00:50:38 -0800 (PST)
Subject: Re: [PATCH] mm/memory_hotplug: Rename all existing 'memhp' into 'mhp'
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1611554093-27316-1-git-send-email-anshuman.khandual@arm.com>
 <YA6AqupAWINtNckx@kroah.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3dc093e6-e037-c67c-f2f9-c534fdabdd99@arm.com>
Date:   Mon, 25 Jan 2021 14:21:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA6AqupAWINtNckx@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/21 1:56 PM, Greg Kroah-Hartman wrote:
> On Mon, Jan 25, 2021 at 11:24:53AM +0530, Anshuman Khandual wrote:
>> This renames all 'memhp' instances to 'mhp' except for memhp_default_state
>> for being a kernel command line option. This is just a clean up and should
>> not cause a functional change.
> 
> THat says _what_ you are doing, but I have no idea _why_ this is needed
> for anything...

There is a series [1] which adds some new hotplug functions starting
with mhp_ (after deciding in its favor rather than memhp_). We should
have a common naming scheme either memhp_ based or mhp_ based but not
mixed. As it was proposed [2] to go with mhp_ based names instead, all
the existing memhp_ needed renaming. Hence the this patch.

[1] https://lore.kernel.org/linux-mm/1611543532-18698-1-git-send-email-anshuman.khandual@arm.com/
[2] https://lore.kernel.org/linux-mm/c37de2d0-28a1-4f7d-f944-cfd7d81c334d@redhat.com/

- Anshuman
