Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA02A2F63
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKBQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgKBQJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:09:52 -0500
Received: from google.com (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE7122277;
        Mon,  2 Nov 2020 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604333392;
        bh=KjbbvUyNRfIy/F798a/hF/fB5rEyDicNk6ioLYZH98g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltfOBxu85u043HltVYcOv7N/cagykHReMo1d5xjIWgxmkAW1neFILugRAigchLKYy
         XiUB8T76w27vWSGkQocoKqm+sS/KJT7OONgPFxTkDLYgtxTujn+79cCnb3/KsPMmlm
         dg69SJDU8LH+QRkGaKC0rco7g0lSF+Sjj2BzdBiI=
Date:   Mon, 2 Nov 2020 08:09:50 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Robin Hsu <robinhsu@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs-toos:fsck.f2fs Fix bad return value
Message-ID: <20201102160950.GB529594@google.com>
References: <20201026094000.1500425-1-robinhsu@google.com>
 <299c9027-e137-83ff-b2ba-8af07144a488@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299c9027-e137-83ff-b2ba-8af07144a488@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28, Chao Yu wrote:
> On 2020/10/26 17:40, Robin Hsu via Linux-f2fs-devel wrote:
> > 'ret' should not have been used here: otherwise, it would be wrongly used
> > as the error code and then be returned from main().
> > 
> > Signed-off-by: Robin Hsu <robinhsu@google.com>
> 
> BTW, how about changing 'ret = EXIT_ERR_CODE' to
> 'ret = FSCK_ERRORS_LEFT_UNCORRECTED', it's not critical though.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

I think it'd be good to go as is for now. :)

> 
> Thanks,
