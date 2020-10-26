Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85931299A63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406084AbgJZX1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406056AbgJZX1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:27:14 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F7120809;
        Mon, 26 Oct 2020 23:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603754834;
        bh=7R6MsrFar+nmsUiiC6n6KOo/0FDbgQKAEj1UliSyDmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqMbf+cjR7kx1wnbJkfENG701riA0xCpQYOaDs2AOvIcuZGMbXFTZWa0ASd/BTFjp
         G2Jdy91akh+rfCm7qSr/U1JvBrR5PLTwTwLwy4Io1/ZkQQ0py8at5H4VdHyWeZRXDu
         iHjdCgxdiWb9ckqiX76UUOwiPdPhJEmlrewOZ+E0=
Date:   Mon, 26 Oct 2020 16:27:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Message-ID: <20201026232712.GC1947033@gmail.com>
References: <20201026041656.2785980-1-daeho43@gmail.com>
 <20201026190406.GL858@sol.localdomain>
 <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
 <20201026230555.GB1947033@gmail.com>
 <CACOAw_wLE_om3YChs_jsBTORrOsp2M6SZ+t2arP9tHQeojsgKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_wLE_om3YChs_jsBTORrOsp2M6SZ+t2arP9tHQeojsgKQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:18:44AM +0900, Daeho Jeong wrote:
> I checked that. We seem to need to complement missing parts including
> other ioctls in Documentation/filesystems/fscrypt.rst.
> 
> Thanks~
> 

Well, the f2fs-specific ioctls should probably be documented in
Documentation/filesystems/f2fs.rst.

- Eric
