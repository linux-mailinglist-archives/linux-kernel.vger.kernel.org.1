Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4C28CBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgJMKut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:50:49 -0400
Received: from foss.arm.com ([217.140.110.172]:54730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgJMKut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:50:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31FA631B;
        Tue, 13 Oct 2020 03:50:48 -0700 (PDT)
Received: from bogus (unknown [10.57.16.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E3A13F719;
        Tue, 13 Oct 2020 03:50:46 -0700 (PDT)
Date:   Tue, 13 Oct 2020 11:50:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        vincent.guittot@linaro.org, Souvik.Chakravarty@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Add missing Rx size re-initialisation
Message-ID: <20201013105043.GB7040@bogus>
References: <20201008143722.21888-2-etienne.carriere@linaro.org>
 <20201012141746.32575-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012141746.32575-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 03:17:46PM +0100, Sudeep Holla wrote:
> Few commands provide the list of description partially and require
> to be called consecutively until all the descriptors are fetched
> completely. In such cases, we don't release the buffers and reuse
> them for consecutive transmits.
> 
> However, currently we don't reset the Rx size which will be set as
> per the response for the last transmit. This may result in incorrect
> response size being interpretted as the firmware may repond with size
> greater than the one set but we read only upto the size set by previous
> response.
> 
> Let us reset the receive buffer size to max possible in such cases as
> we don't know the exact size of the response.
>

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[PATCH] firmware: arm_scmi: Add missing Rx size re-initialisation
	https://git.kernel.org/sudeep.holla/c/9724722fde

--
Regards,
Sudeep
