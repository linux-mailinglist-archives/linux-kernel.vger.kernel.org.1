Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F841DE4A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgEVKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 06:41:13 -0400
Received: from foss.arm.com ([217.140.110.172]:33040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbgEVKlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:41:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 289E7D6E;
        Fri, 22 May 2020 03:41:12 -0700 (PDT)
Received: from [10.37.8.86] (unknown [10.37.8.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26D6E3F305;
        Fri, 22 May 2020 03:41:09 -0700 (PDT)
Subject: Re: [PATCH v2] perf: arm_dsu: Support DSU ACPI devices.
To:     will@kernel.org, tuanphan@os.amperecomputing.com
Cc:     patches@amperecomputing.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1589229160-18558-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200518172132.GA2601@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5adeae2c-86be-6ee9-970b-aa891582c562@arm.com>
Date:   Fri, 22 May 2020 11:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200518172132.GA2601@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

Thanks for the Cc.

On 05/18/2020 06:21 PM, Will Deacon wrote:
> On Mon, May 11, 2020 at 01:32:40PM -0700, Tuan Phan wrote:
>> Add ACPI node probing device support. Each DSU ACPI node
>> defines a "cpus" package with a per cpu MPIDR element.

I think there is a bit of confusion around the affinity listing.
I am getting this clarified with the architects.

Cheers
Suzuki
