Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9BF272A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgIUPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:40:06 -0400
Received: from foss.arm.com ([217.140.110.172]:45594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgIUPkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:40:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38657147A;
        Mon, 21 Sep 2020 08:40:05 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305293F718;
        Mon, 21 Sep 2020 08:40:04 -0700 (PDT)
Subject: Re: [PATCH v6 0/7] arm_pmu: Use NMI for perf interrupt
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        swboyd@chromium.org, sumit.garg@linaro.org
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
 <20200921135951.GN2139@willie-the-truck>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <296304b8-aadd-817d-bb12-dc7524b6f0f5@arm.com>
Date:   Mon, 21 Sep 2020 16:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921135951.GN2139@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Thank you so much for reviewing the series!

On 9/21/20 2:59 PM, Will Deacon wrote:
> On Wed, Aug 19, 2020 at 02:34:12PM +0100, Alexandru Elisei wrote:
>> The series makes the arm_pmu driver use NMIs for the perf interrupt when
>> NMIs are available on the platform (currently, only arm64 + GICv3). To make
>> it easier to play with the patches, I've pushed a branch at [1]:
> This mostly looks good to me, but see some of the comments I left on the
> code. One other thing I'm not sure about is whether or not we should tell
> userspace that we're using an NMI for the sampling. Do any other
> architectures have a conditional NMI?

I'm not sure about other architectures being able to configure the perf interrupt
as NMI or a regular interrupt, I'll try to find out. Regardless of what the other
architecture do, I am of the opinion that we should spell out explicitly when the
PMU is using pseudo-NMIs, because it makes a huge difference in the accuracy of
the instrumentation and the overall usefulness of perf.

If I spin a v7 quickly, is it still time to merge the series for 5.10?

Thanks,
Alex
