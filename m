Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C314273F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIVJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:59:00 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584C42388B;
        Tue, 22 Sep 2020 09:58:59 +0000 (UTC)
Date:   Tue, 22 Sep 2020 10:58:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Jun <chenjun102@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rui.xiang@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH -next 4/5] mm/kmemleak-test: use %px instead of %p in
 print
Message-ID: <20200922095856.GD15643@gaia>
References: <20200921020007.35803-1-chenjun102@huawei.com>
 <20200921020007.35803-5-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921020007.35803-5-chenjun102@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:00:06AM +0000, Chen Jun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Real addresses are used for diagnose issues.
> Convert %p with %px to print kernel addresses.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Signed-off-by: Chen Jun <chenjun102@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
