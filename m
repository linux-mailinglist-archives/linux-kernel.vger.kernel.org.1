Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED75E21D673
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgGMNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 09:00:42 -0400
Received: from foss.arm.com ([217.140.110.172]:33072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMNAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:00:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A921631B;
        Mon, 13 Jul 2020 06:00:41 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16DED3F887;
        Mon, 13 Jul 2020 06:00:40 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Provide a missing function param description
Date:   Mon, 13 Jul 2020 14:00:38 +0100
Message-Id: <159464497507.50199.10992969316233541197.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200709153155.22573-1-sudeep.holla@arm.com>
References: <20200709153155.22573-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 16:31:55 +0100, Sudeep Holla wrote:
> gcc as well as clang now produce warnings for missing kerneldoc function
> parameter.
>
> Fix the following W=1 kernel build warning:
>
> drivers/firmware/arm_scmi/smc.c:32:
>  warning: Function parameter or member 'shmem_lock' not described in 'scmi_smc'

Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Provide a missing function param description
      https://git.kernel.org/sudeep.holla/c/a4ee9d0194

--
Regards,
Sudeep

