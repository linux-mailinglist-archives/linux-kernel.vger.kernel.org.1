Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD02EB9BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAFGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAFGA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:00:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21CCE22C9F;
        Wed,  6 Jan 2021 06:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609912817;
        bh=fObodAHzwrfdYZJUy7CZgmuObr2ATtvdMz6LejNX7hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atPYTl72rFHiFlYk0ddBoauPNAC0EOVeIUi2LdhtDl+qV9QlgR6b1GRiDgvxJYs6a
         NjtjdSwTlW0JZh24CLakCgah+l9hH3ihhAnkYXiGKf3bgA4X4rj8+kBtPwV9PBJetC
         8pGo6mHR6VG/XVBTZ3kRApx+Ko+8cQs/bG/UYbWfANUEZ9IAGlMi1a5TAMuEQUT8U8
         lsX/+vhuOFLGqYhZ6TKBlfdOHHY/tYk3ebaKgQt8meUd2yRPwXPPATYZiSdKNx423n
         T8O5JLVp9jm0SxoRVWRirN6nonLUfyKiAF/9wFeISPoAqTL23zUhsmHJM8RfyqVUJ5
         jcOzNm2b+b/jg==
Date:   Wed, 6 Jan 2021 11:30:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     linux-kernel@vger.kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com
Subject: Re: [PATCH -next] soundwire: intel: Use kzalloc for allocating only
 one thing
Message-ID: <20210106060013.GM2771@vkoul-mobl>
References: <20201229135012.23472-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229135012.23472-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-12-20, 21:50, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> @@
> 
> - kcalloc(1,
> + kzalloc(
>           ...)
> // </smpl>

Applied, thanks

-- 
~Vinod
