Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B8B2C5B25
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404537AbgKZRzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404262AbgKZRzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:55:22 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B4420665;
        Thu, 26 Nov 2020 17:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606413322;
        bh=JAgoZA3nJogzefKO2GKhKaCZwMcQOntnimDPGPW9vKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGPeDVKGxyAJUNpfcCMqrvpwHiq00QbykinOkr099+Y/RPNJCxRgDVOzuVWx9+R6L
         fC9tC7d1vdiHGqHLE0kW1kwxCkHFtGSkM200y+bmE9gmhdkn3dTXH9XAx/0uY4N6CT
         3JkIHs9ACcQ9nPWW66lNk7ikX6lcsvg2vmG1YEic=
Date:   Thu, 26 Nov 2020 09:55:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: add compress_inode to
 cache compressed blocks
Message-ID: <X7/sCLnVPOjkC9DI@sol.localdomain>
References: <20201126103709.80006-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126103709.80006-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 06:37:09PM +0800, Chao Yu wrote:
> Support to use address space of inner inode to cache compressed block,
> in order to improve cache hit ratio of random read.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

If the file is also encrypted, are the compressed pages that are cached still
encrypted, or are they decrypted?

- Eric
