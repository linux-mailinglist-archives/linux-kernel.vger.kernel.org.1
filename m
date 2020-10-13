Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4528C88D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 08:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389185AbgJMGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 02:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388527AbgJMGNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 02:13:51 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61FB9208D5;
        Tue, 13 Oct 2020 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602569631;
        bh=IpkkmpBCZwNABqrCXMbFcvHPGltnuEdB0YXHUWKuSmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0dExeDduu1b6tHtJWHMG/NXNMcHvSpfh/No8es0XVqYjmY+4QJyBU4PP82QXB79iK
         W0SUMEJSF5VtAMbAjDKOJFN+VRkfhTa+2Nt8Pls8tb7NIQ81iQkI/dh4T9di3yQOzs
         GaWdE5RT0bPdKwhrwMRcg719Q0lgc51WED2e38bQ=
Date:   Mon, 12 Oct 2020 23:13:49 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION
 ioctl
Message-ID: <20201013061349.GD1062@sol.localdomain>
References: <20201013022429.454161-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013022429.454161-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 11:24:28AM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new F2FS_IOC_GET_COMPRESS_OPTION ioctl to get file compression
> option of a file.
> 

For new ioctls please mention the documentation, tests, and use cases.

- Eric
