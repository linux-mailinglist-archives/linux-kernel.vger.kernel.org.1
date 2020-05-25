Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C701E107B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403951AbgEYO2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 10:28:04 -0400
Received: from 8bytes.org ([81.169.241.247]:44600 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390879AbgEYO2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:28:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F2A51189; Mon, 25 May 2020 16:28:02 +0200 (CEST)
Date:   Mon, 25 May 2020 16:28:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Prakash Gupta <guptap@codeaurora.org>, mhocko@suse.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
Message-ID: <20200525142801.GF5221@8bytes.org>
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <20200521114906.2f38fc04d3600d41f3409bd9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521114906.2f38fc04d3600d41f3409bd9@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:49:06AM -0700, Andrew Morton wrote:
> I'll assume that Joerg will handle this fix?

Yes, I will when it turns out necessary.


Regards,

	Joerg
