Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56672C47E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgKYStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:49:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47928 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgKYStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:49:21 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1khzqx-00058N-FB; Wed, 25 Nov 2020 18:49:19 +0000
Subject: Re: [PATCH] dma-mapping: Fix sizeof() mismatch on tsk allocation
To:     Christoph Hellwig <hch@lst.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201125140523.1880669-1-colin.king@canonical.com>
 <a6c5e5ed9a66485da301c1e91b56ccc7@hisilicon.com>
 <20201125182941.GB10377@lst.de>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <cf79f1ba-aeba-6237-81c8-ca7efc1425e2@canonical.com>
Date:   Wed, 25 Nov 2020 18:49:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125182941.GB10377@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2020 18:29, Christoph Hellwig wrote:
> I'll fold this one in as well.
> 
OK, so two SoB's disappear?

