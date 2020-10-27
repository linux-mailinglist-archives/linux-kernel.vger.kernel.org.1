Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDB29A5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508504AbgJ0H6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:58:54 -0400
Received: from verein.lst.de ([213.95.11.211]:37685 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgJ0H6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:58:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 463BD67373; Tue, 27 Oct 2020 08:58:51 +0100 (CET)
Date:   Tue, 27 Oct 2020 08:58:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, konrad.wilk@oracle.com, hch@lst.de
Subject: Re: [PATCH] fix swiotlb panic on Xen
Message-ID: <20201027075851.GD22487@lst.de>
References: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010261653320.12247@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But we really need to clean up the mess with all these magic variables
eventually.
