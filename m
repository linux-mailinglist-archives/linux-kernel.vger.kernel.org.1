Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446FB21EB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 10:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGNIcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 04:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgGNIcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:32:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9886B21BE5;
        Tue, 14 Jul 2020 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594715541;
        bh=0zlzzliEOItAVoYIhLD6J0k/s1+kEFpAEJbNA9bURqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Exc5Ivn9GWaIQh/pdsyxs9hU85cZFng5gjIoScR5HpV0r9ZrBhMfPbwhW3F0w5zxM
         1ZaOlF7hevYbG4PEyOPWgGl5YSO7mkXY69a8Yj9Ju5qMav0zc1NPptMnHGylH2xTwU
         twjln/jBfK2Q+zClosWpmM4wzNWeU3tGriS561tQ=
Date:   Tue, 14 Jul 2020 09:32:16 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     zhangshaokun@hisilicon.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, jolsa@redhat.com, linuxarm@huawei.com
Subject: Re: [PATCH] drivers/perf: hisi: Add identifier sysfs file
Message-ID: <20200714083216.GD4516@willie-the-truck>
References: <1592399111-134786-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592399111-134786-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Jun 17, 2020 at 09:05:11PM +0800, John Garry wrote:
> To allow userspace to identify the specific implementation of the device,
> add an "identifier" sysfs file.
> 
> Encoding is as follows:
> hi1620: 0x0	(aka hip08)
> hi1630: 0x30
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

I'm struggling a bit to track this. If you still think it's worth pursuing,
please could you post a series with a cover-letter describing what this is
for, a link to the userspace changes and then patches for all the PMU
drivers that need updating? There was an RFC from you for the SMMUv3 PMU as
well, and also some other "arm64" changes.

Cheers,

Will
