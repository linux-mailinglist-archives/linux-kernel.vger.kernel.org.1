Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE34D1B2AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgDUPKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 11:10:54 -0400
Received: from foss.arm.com ([217.140.110.172]:37030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUPKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:10:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D270A31B;
        Tue, 21 Apr 2020 08:10:53 -0700 (PDT)
Received: from [10.37.12.172] (unknown [10.37.12.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB6CD3F73D;
        Tue, 21 Apr 2020 08:10:21 -0700 (PDT)
Subject: Re: [PATCH v2 8/8] arm64: cpufeature: Add an overview comment for the
 cpufeature framework
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200421142922.18950-1-will@kernel.org>
 <20200421142922.18950-9-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <79835826-1b28-7616-834c-7b3779db4fac@arm.com>
Date:   Tue, 21 Apr 2020 16:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200421142922.18950-9-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21/2020 03:29 PM, Will Deacon wrote:
> Now that Suzuki isn't within throwing distance, I thought I'd better add
> a rough overview comment to cpufeature.c so that it doesn't take me days
> to remember how it works next time.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
