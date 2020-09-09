Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C326268E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 06:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIIE7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 00:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgIIE7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:59:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D9C061757
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:59:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so1080603pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=aMuaqipRQnYeqRzhZrGBU6gZzBaakoxqT2EsHc4LAkw=;
        b=tpgF9Rnjs582RVO60tHFuThNeDv8r1D7N4z/7UTKHgifa+meHjtSqF6MmXDAlaZiRY
         nqqGXLS2Xx7cWbQmv2Tsmxav1QwUJevwRHbW/8KUyfLigIRgRiFxMOMkdVqiiwNzxsYx
         HZv8VX4R32LJJljOL4S9tDoE7X7QugRVxE6gWmn/rNX4xGHSm34XkIKVGyFUcnqj/rVJ
         MZCqNIjU3Xb7c67+Vd+6NMkgv0My+pdYPoAV1fN2XSlFAnJcs7acyWbru7ghUBDihK+n
         HA3KkD9a8MMJ3mptyenmxRBX4VAJkBNGBzhWly1gBbZAze1ERi77A0PrZNZBUWYQavE1
         4llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=aMuaqipRQnYeqRzhZrGBU6gZzBaakoxqT2EsHc4LAkw=;
        b=mYZU8YDrBmVgL0vCMiYLXWrQ/Iav7I6HXKkRKeBMZzBITjULPn30SEsYP4a4sJSO4/
         6j+LNBYTfGkxtMTVET2ctwu/wFngOrxWaFwzcnIIUAZRqYGzD+/+I0f3u78rYo/X1/pc
         L5uu45Tsf1Mbedc8qwRIJpXxZjxjMJ31n3yFMCVcpYFEEtZwtzexvOd7ojeom/kaV+6o
         dPauWloPR7oLIMEvEG80QhpiFqtXGCp+p/FGa8AlB2/xZYgzHOIi2opiQ2pN9Aw85QJX
         5t18W8CK+nsIP6OmG0cQaCn7NOSV3F7puyoAsk09vWDiSsvRB0T1+MwTd33jnt8KRzbR
         R/0w==
X-Gm-Message-State: AOAM532hHmxbMQL3Db8LdjuyGhkUnhsgoZntujVZP4HEImYckszw3NCB
        lO0rn+RWPGFmlZznZyrOVWlynQ==
X-Google-Smtp-Source: ABdhPJxDDE5ivT8UmvibDFe7q7gQD1F1no9tzfg8hTFhxtCkA6fy7IjVUDNFMcPuNzrxEIhllR0ZfQ==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr1997808pfr.96.1599627570285;
        Tue, 08 Sep 2020 21:59:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id e17sm1043445pff.6.2020.09.08.21.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:59:29 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:59:29 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 21:58:57 PDT (-0700)
Subject:     Re: remove set_fs for riscv v2
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-5fa86587-c404-420e-a4c0-43d197d1cd27@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Sep 2020 22:58:17 PDT (-0700), Christoph Hellwig wrote:
> Hi all,
>
> this series converts riscv to the new set_fs less world and is on top of this
> branch:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs
>
> The first four patches are general improvements and enablement for all nommu
> ports, and might make sense to merge through the above base branch.

Seems like it to me.  These won't work without the SET_FS code so I'm OK if you
guys want to keep them all together.  Otherwise I think I'd need to wait until
the SET_FS stuff gets merged before taking any of these, which would be a bit
of a headache.

Thanks!

> Changes since v1:
>  - implement __get_user_fn and __put_user_fn for the UACCESS_MEMCPY case
>    and remove the small constant size optimizations in raw_copy_from_user
>    and raw_copy_to_user
>  - reshuffle the patch order a little
>
> Diffstat
>  arch/riscv/Kconfig                   |    2
>  arch/riscv/include/asm/thread_info.h |    6 -
>  arch/riscv/include/asm/uaccess.h     |  177 +++++++++++++++++------------------
>  arch/riscv/kernel/process.c          |    1
>  arch/riscv/lib/Makefile              |    2
>  include/asm-generic/uaccess.h        |  109 +++++++++++++--------
>  include/linux/uaccess.h              |    4
>  7 files changed, 166 insertions(+), 135 deletions(-)
