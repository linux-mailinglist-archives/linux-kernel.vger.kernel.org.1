Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A45287DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgJHVLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 17:11:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51164 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgJHVLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 17:11:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10CB51063;
        Thu,  8 Oct 2020 14:11:21 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF893F66B;
        Thu,  8 Oct 2020 14:11:19 -0700 (PDT)
Date:   Thu, 8 Oct 2020 22:11:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/5] firmware: arm_scmi: smc transport supports
 multi-message pool
Message-ID: <20201008211116.l6gbym2ypb6lzlo7@bogus>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-4-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008143722.21888-4-etienne.carriere@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:37:21PM +0200, Etienne Carriere wrote:
> There is no reason for the smc transport to restrict itself to a 1
> message pool. More can be allocated, messages are copied from/to the
> shared memory only on SMC exit/entry hence SCMI driver can play with
> several messages.
> 
> Use value of 20 to mimic mailbox transport implementation.

What is the need to mimic ?

> Any high value could fit. This should be something configurable.

Why not 10 or 100 ? I see any value other than 1 is useless as we lock
the channel in send_message and we don't maintain a queue like mailbox.

-- 
Regards,
Sudeep
