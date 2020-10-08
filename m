Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797CB287DA3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgJHVIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:08:44 -0400
Received: from foss.arm.com ([217.140.110.172]:51034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJHVIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:08:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71CB71063;
        Thu,  8 Oct 2020 14:08:43 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF7263F66B;
        Thu,  8 Oct 2020 14:08:41 -0700 (PDT)
Date:   Thu, 8 Oct 2020 22:08:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: add config dependency for smc
 transport
Message-ID: <20201008210839.6nnl2tvm2re2ckvu@bogus>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-3-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008143722.21888-3-etienne.carriere@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:37:20PM +0200, Etienne Carriere wrote:
> Fix dependencies for configuration switch ARM_SCMI_PROTOCOL that
> is not exclusively dependent on MAILBOX since the alternate
> smc transport that is depends on HAVE_ARM_SMCCC_DISCOVERY since [1].
>

Do you need any build issues ? I don't see why this is needed.

-- 
Regards,
Sudeep
