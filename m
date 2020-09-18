Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3868F26F7DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgIRISs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:18:47 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE63C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:18:47 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 550E4396; Fri, 18 Sep 2020 10:18:42 +0200 (CEST)
Date:   Fri, 18 Sep 2020 10:18:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Vijayanand Jitta <vjitta@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org, kernel-team@android.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 1/2] iommu/iova: Retry from last rb tree node if iova
 search fails
Message-ID: <20200918081836.GD31590@8bytes.org>
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <782f5dae-4ebc-02c8-5c83-4f7efda65c9d@codeaurora.org>
 <ef272a26-b1c2-f445-4e34-c87f1ce27a01@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef272a26-b1c2-f445-4e34-c87f1ce27a01@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:20:55AM +0530, Vijayanand Jitta wrote:
> ping ?

Robin needs to have a look first.

Regards,

	Joerg
