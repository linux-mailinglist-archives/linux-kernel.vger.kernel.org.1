Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3712C27B8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgI2AFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgI2AFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:05:31 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9EF207F7;
        Mon, 28 Sep 2020 21:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601329768;
        bh=jnDF4UHlxQoCvPVJnbDA/TG60C4qyLgWp/wbtLXGwEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BbsRqdDGqXYX5Y4oP3LAjd7J6XF2TOj/cDIcCDrxxkHP/dS8eh0ax2zGyoN2g1FPJ
         hSaUc7xsneh+qQEeALopJZfPSbYEnc4tLQjVLFjCsoLwKxSbp2R69bk7ZWhxIILaa6
         bZgvrIwr+ChLLQQ7C4Y3vgOdrLKtioq98VbaKO0M=
Date:   Mon, 28 Sep 2020 14:49:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix uninit-value in f2fs_lookup
Message-ID: <20200928214926.GB1340@sol.localdomain>
References: <20200925233819.5359-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925233819.5359-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 07:38:19AM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> As syzbot reported:

Please include the Reported-by line that the syzbot report said to include.

- Eric
