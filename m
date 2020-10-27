Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD72C29A9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898425AbgJ0Kfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:35:50 -0400
Received: from foss.arm.com ([217.140.110.172]:37794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436853AbgJ0Kfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:35:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67CBE30E;
        Tue, 27 Oct 2020 03:35:30 -0700 (PDT)
Received: from [10.57.18.142] (unknown [10.57.18.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0053F66E;
        Tue, 27 Oct 2020 03:35:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] hwtracing: coresight: add missing MODULE_LICENSE()
To:     balbi@kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201027085157.1964906-1-balbi@kernel.org>
 <20201027085157.1964906-2-balbi@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7d865833-facf-3856-aefe-4e22c3b11a6b@arm.com>
Date:   Tue, 27 Oct 2020 10:35:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027085157.1964906-2-balbi@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/20 8:51 AM, balbi@kernel.org wrote:
> From: Felipe Balbi <balbi@kernel.org>
> 
> Fix the following build warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/hwtracing/coresight/coresight.o
> 
> Signed-off-by: Felipe Balbi <balbi@kernel.org>

Acked-by: Suzuki K Poulose <suzuki.poulos@arm.com>

