Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5C287C56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgJHTRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:17:32 -0400
Received: from foss.arm.com ([217.140.110.172]:45488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgJHTRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:17:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D892C1063;
        Thu,  8 Oct 2020 12:17:30 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94C0C3F70D;
        Thu,  8 Oct 2020 12:17:29 -0700 (PDT)
Date:   Thu, 8 Oct 2020 20:17:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 1/5] firmware: arm_scmi: always initialize protocols
Message-ID: <20201008191727.ht26r5dnh3iwqj5n@bogus>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008143722.21888-1-etienne.carriere@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:37:18PM +0200, Etienne Carriere wrote:
> Remove the IDR replacement that prevent initializing an SCMI protocol
> when it has already been initialized. This is needed when there are
> several SCMI agents that do implement a given SCMI protocol unless
> what only the related SCMI protocol communication is initialized only
> for first probed agent.
> 

Can you please elaborate on your usecase please. What do you mean by several
SCMI agents here. OSPM is the only agent we are interested here. What
other agents is this driver supposed to handle here. We allocate memory
in init and calling init multiple times messes up the allocated and
initialised structures.

So NACK for this patch as it needs more work if we need this at all.

-- 
Regards,
Sudeep
