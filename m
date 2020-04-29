Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B061BDA78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 13:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgD2LUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 07:20:17 -0400
Received: from 8bytes.org ([81.169.241.247]:39468 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgD2LUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:20:17 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 55F392E2; Wed, 29 Apr 2020 13:20:16 +0200 (CEST)
Date:   Wed, 29 Apr 2020 13:20:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200429112014.GN21900@8bytes.org>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
 <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:26:12AM -0400, Qian Cai wrote:
> No dice. There could be some other races. For example,

Can you please test this branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=amd-iommu-fixes

It has the previous fix in it and a couple more to make sure the
device-table is updated and flushed before increase_address_space()
updates domain->pt_root.

Thanks,

	Joerg
