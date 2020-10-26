Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C01299A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395418AbgJZXF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395408AbgJZXF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:05:57 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D50220708;
        Mon, 26 Oct 2020 23:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603753557;
        bh=buPKfI0LODfxV6G8Mb2QH2W7D0RNdKWV1mnYWK+ZD4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLNQE8/FKDRMdQzhaiUWlC52n2l8ThNOlkegMMRY42bQUEvvJ0hTKCP08XYrNdylM
         0ftsXqtUj0lAvQpmVR+57fCNCeEsgEP7CqOb/PilPdVGmJNSSnz6irn+ca8Z9cEVDk
         S5SpcdaF0dOtnh0u5xXdRV2b3W1yC6eznWIoxRyg=
Date:   Mon, 26 Oct 2020 16:05:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Message-ID: <20201026230555.GB1947033@gmail.com>
References: <20201026041656.2785980-1-daeho43@gmail.com>
 <20201026190406.GL858@sol.localdomain>
 <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xFijZOokM4R1XYKoFvRthk-ZfC+hNz0c-HqQuurjp87g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:02:18AM +0900, Daeho Jeong wrote:
> I thought I gave the information about that in the commit message. Is
> this not enough for you?
> Actually, there is no space for F2FS ioctl documentation now. :(
> 

The commit message doesn't really matter.  What I am asking for are actual
documentation and tests.

The fscrypt ioctls, for example, are all documented in
Documentation/filesystems/fscrypt.rst, and they have tests in xfstests.

- Eric
