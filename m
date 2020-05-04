Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10691C41E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgEDROu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 13:14:50 -0400
Received: from foss.arm.com ([217.140.110.172]:49736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730571AbgEDROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:14:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D0D1045;
        Mon,  4 May 2020 10:14:43 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A5753F68F;
        Mon,  4 May 2020 10:14:42 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_sdei: Drop check for /firmware/ node and
 always register driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "will@kernel.org" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20200422122823.1390-1-sudeep.holla@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <bcadd00b-cd76-8321-e1c9-0a076fe64deb@arm.com>
Date:   Mon, 4 May 2020 18:14:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200422122823.1390-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

(CC: +Will and +Catalin)

On 22/04/2020 13:28, Sudeep Holla wrote:
> As with most of the drivers, let us register this driver unconditionally
> by dropping the checks for presence of firmware nodes(DT) or entries(ACPI).
> 
> Further, as mentioned in the commit acafce48b07b ("firmware: arm_sdei:
> Fix DT platform device creation"), the core takes care of creation of
> platform device when the appropriate device node is found and probe
> is called accordingly.
> 
> Let us check only for the presence of ACPI firmware entry before creating
> the platform device and flag warning if we fail.

Reviewed-by: James Morse <james.morse@arm.com>


Will/Catalin, any chance you could pick this up for v5.8?

Original message:
https://lore.kernel.org/linux-arm-kernel/20200422122823.1390-1-sudeep.holla@arm.com/


Thanks!

James
