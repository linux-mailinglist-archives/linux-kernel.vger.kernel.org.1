Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7EA2B5CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgKQKJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:09:58 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D64C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:09:58 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 51D0B39B; Tue, 17 Nov 2020 11:09:55 +0100 (CET)
Date:   Tue, 17 Nov 2020 11:09:53 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: IOMMU Maintainership
Message-ID: <20201117100953.GR22888@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

last week I spent in the hospital and had an unplanned surgery from
which I am recovering now. The recovery will take a few weeks, which
unfortunatly does not allow me to fulfill my IOMMU maintainer duties or
do any other serious work in front of a computer.

Luckily Will Deacon volunteered to handle incoming IOMMU patches and
send them upstream. So please Cc him on any patches that you want to
have merged upstream for the next release and on important fixes for
v5.10. The patches will go through another tree for the time being, Will
can share the details on that.

I hope to return to my duties when the next merge window is over.

Thanks a lot for your help, Will! Also thank you to the others on Cc
which will help Will handling the patch flow.

Regards,

	Joerg
