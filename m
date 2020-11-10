Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0432ADFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgKJTny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJTnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:43:53 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B1820639;
        Tue, 10 Nov 2020 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605037433;
        bh=sMQ7Ir3OPkhZYJuV4Vzpb2qOUY0DKBK15rYzfrGaIEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4i/Zs5pUHFxZ6aXo3zBSFYOCrWlbTbhTYXg06U8G4o34yFowsuqfCPkDD8uj7cES
         KZ1XWZ73fsaFBvVFFxe79GmHJc+gbPyubV4PcxjkOrAXWdz+6eO7Szf1hCbTIHqBbL
         FLwG3W1c+4OTeafCBxRjtksIalZ6ge/OZgcM/QVs=
Date:   Tue, 10 Nov 2020 11:43:51 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: avoid unneeded data copy in
 f2fs_ioc_move_range()
Message-ID: <X6rtd//vuPbStYdh@sol.localdomain>
References: <20201110012437.26482-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110012437.26482-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:24:36AM +0800, Chao Yu wrote:
> Fields in struct f2fs_move_range won't change in f2fs_ioc_move_range(),
> let's avoid copying this structure's data to userspace.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---

Reviewed-by: Eric Biggers <ebiggers@google.com>
