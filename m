Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5F52CE704
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgLDEbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgLDEbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:31:55 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40068C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 20:31:15 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id r18so5131176ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 20:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktrYpX+PX9gYP19cphCNlBkQ//YDNX4xO30NBDFiHic=;
        b=G+K4k+QRVIcqBpiniR98E2i04SzytSueXbyUbePP/tzHYCXScQCtfOpD3FDqFJIiNa
         PaoWl/uOeCcNnk0pzfJvb3Gp9mILali+q4Od8QR+b4sPnbNOfFY03zgZWy8UN04Ll8Gs
         7kAoYZcrP7ADjMszw1JNB8nmnPbO7MXNqXanNDVaN3QGHseaeVPnPu0d8070o3xxLA0B
         Ekf8dIiwINEAir7R6QWCPpPvI19pXTfaCOLC1OmUWASv6vUBTBZ6JoitLkgObFdHYx5u
         NHeNrOm/d9nyXA3+CY2Q4cw/AG4FaDj0Cwt8kT2wt79a+Dd/ZQZFSqlgTzWMEVZTn1Nm
         7Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktrYpX+PX9gYP19cphCNlBkQ//YDNX4xO30NBDFiHic=;
        b=KOO8nQJXRORGJzOB5RC+fockMVfnshaNBG6sS2vqhSqrgisuwEwnVG5KUXmn0UiKM4
         +PvERZxv6RKN31z9KEfJNyqJ4xbqT1oaIEfgtnihheJBGo9MEoR+eglcIohA608maLWx
         KLP4xIwTPP4KpXiua97Jm3/OtjamB86WhLAwOBoAsukqK7VQ8nO/sForvuQr+F1s3Q+U
         n37236aKyl+TXQCIgeq5J1O+32fxVyeE8awD+Yl3CwqC6vlNhF79c0J2lXkzvlJWSMXx
         0TSWSiZODeuno9vQww8mKGZK169j/k/ExWvVlTmsQp0dQXXbaf+S3LS6iqYnLoN1t4Yc
         SYzw==
X-Gm-Message-State: AOAM533Sje37BaQRapkbU4CkJP11eke90Trxgo9/IYmfNBTNLp58Hz4r
        ypwqB74MUVIfO30s2MTjDz1FMrn1zycXOGcyH0M=
X-Google-Smtp-Source: ABdhPJw0FeImudjdeH5qfoDpOQfWxMjQ4PsUd97gtFUlbztvcwa8aphO0i7QnrxdlIge7kWnZlhCFnApVq4xoHTNbw8=
X-Received: by 2002:a2e:9654:: with SMTP id z20mr2505992ljh.335.1607056273762;
 Thu, 03 Dec 2020 20:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com> <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com> <X8m0qbd7rvQyiwOt@sol.localdomain>
In-Reply-To: <X8m0qbd7rvQyiwOt@sol.localdomain>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 4 Dec 2020 13:31:02 +0900
Message-ID: <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in decompression
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure?  I thought that compression (and encryption) apply to the whole
> file, including any Merkle tree blocks past i_size.

This "dic" structure is only for "de"compression, so we don't need to
worry about going beyond i_size case.

> Also, even if you include the i_size check, it's still wrong to check
> fsverity_active() in the middle of the I/O because FS_IOC_ENABLE_VERITY can
> execute concurrently, causing fsverity_active() to return false at the beginning
> of the I/O and true later in the I/O.  It needs to be checked only once, at the
> beginning...

Got it. Our previous implementation didn't consider this case. Need to fix this.

Thanks,
