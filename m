Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06441276CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgIXJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIXJXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:23:51 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0251C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:23:51 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 25EE7401; Thu, 24 Sep 2020 11:23:50 +0200 (CEST)
Date:   Thu, 24 Sep 2020 11:23:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: kdump boot failing with IVRS checksum failure
Message-ID: <20200924092348.GI27174@8bytes.org>
References: <87o8lzvtzp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8lzvtzp.fsf@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerry,

On Mon, Sep 21, 2020 at 11:56:42AM -0700, Jerry Snitselaar wrote:
> We are seeing a kdump kernel boot failure in test on an HP DL325 Gen10
> and it was tracked down to 387caf0b759a ("iommu/amd: Treat per-device
> exclusion ranges as r/w unity-mapped regions"). Reproduced on 5.9-rc5
> and goes away with revert of the commit. There is a follow on commit
> that depends on this that was reverted as well 2ca6b6dc8512 ("iommu/amd:
> Remove unused variable"). I'm working on getting system access and want
> to see what the IVRS table looks like, but thought I'd give you heads
> up.

Thanks for looking into this, we really need to find the root-cause to
avoid the revert.

Thanks,

	Joerg
