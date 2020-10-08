Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735A5287DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgJHVQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:16:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgJHVQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:16:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353E81063;
        Thu,  8 Oct 2020 14:16:23 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7F1A3F66B;
        Thu,  8 Oct 2020 14:16:21 -0700 (PDT)
Date:   Thu, 8 Oct 2020 22:16:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 5/5] firmware: arm_scmi: fix ARCH_COLD_RESET
Message-ID: <20201008211618.djx4flopp6w76p43@bogus>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-5-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008143722.21888-5-etienne.carriere@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:37:22PM +0200, Etienne Carriere wrote:
> Fix ARCH_COLD_RESET according to SCMI specification.
>

Thanks, nice catch.
I will send this as fix after v5.10-rc1 with fixes tag

Fixes: 95a15d80aa0d ("firmware: arm_scmi: Add RESET protocol in SCMI v2.0")

-- 
Regards,
Sudeep
