Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3A2F47FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbhAMJtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:49:52 -0500
Received: from foss.arm.com ([217.140.110.172]:33376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbhAMJtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:49:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 983D4101E;
        Wed, 13 Jan 2021 01:49:05 -0800 (PST)
Received: from [10.57.56.97] (unknown [10.57.56.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26FAA3F66E;
        Wed, 13 Jan 2021 01:49:03 -0800 (PST)
Subject: Re: [PATCH V2 09/11] coresight: etm-perf: Truncate the perf record if
 handle has no space
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-10-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <70925374-15c7-538a-321e-9af15aa3bd61@arm.com>
Date:   Wed, 13 Jan 2021 09:48:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1610511498-4058-10-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 4:18 AM, Anshuman Khandual wrote:
> While starting off the etm event, just abort and truncate the perf record
> if the perf handle as no space left. This avoids configuring both source
> and sink devices in case the data cannot be consumed in perf.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
