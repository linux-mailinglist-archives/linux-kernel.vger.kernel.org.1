Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B442CE717
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgLDEtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgLDEtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:49:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9255C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 20:48:36 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id q13so5951481lfr.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 20:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w5FwqvJ/2TbkgG2DOxuzIJIYSm5j8vEtl6T3++ATpdc=;
        b=jB0EDdD5538iWidqdjfnmAOKeJPsYGv13SGqZaDzAI7gQstu3EzEZJJg/d/MrFdK4p
         dfHSudm9uELbTVor9xqDCEIHmqecLsP/Sd6ETimLNKL/VL0gG5/dwK+hrHYw1S1X3+eO
         tPlZTLkBthEPI28jeXKgnOcwPrwlQMfk7ovXCh049oMFkNeFb1oBZHyn8W1r27727CHH
         t2fRQ3R4HxvBw1MA4dz37Vfm+wbTLUuPRr4zZaRrPUbXgIFLXw03TljSmoMh24gdmw6d
         grkHoJOREMR8HAnsPuSmfb/VoCe3DDZfS0R+d5YoUpMknphuoDhdX5ZVienl365CHbSF
         HDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w5FwqvJ/2TbkgG2DOxuzIJIYSm5j8vEtl6T3++ATpdc=;
        b=CteamJzmNV33pvdvdNqzsgTgaQ2n1bE+9bMDSTxCLpeJ+2iVI+FXBhilyGTxMQiXD9
         UG/aZUaUclTzpqhJMhW0xZsE8Ejtm08fnEAD0vPdnoWLM8Ypz7w3vQ768muaQI5Aoyxk
         FXHJmnnWa21ABvy37QGYD20CKsRLyTDDYLAGo1wrblH6wm1QCFbMD6Ebsn0UE8a4g1Dt
         WHaAQDCMrT2YLfQMTNtDakq9HectEIS1gkn+0vh3btChuS03OGG+eE6flu9NRVBGR65U
         nIstUAbd2VtoQaEuYPkp8dSq1MmjpdNDJkOtryhiAlHFMQtokkgcUTdS3QFPv0rX5M2+
         gZzg==
X-Gm-Message-State: AOAM531Q4cypxj0hJXJxnlh0DX5kmljQZVq8M8zsAghbb4EsjaXbVnzZ
        IE8yfQenfaKz7w+PmV6q3USZZSRU1EMy0miv2jU=
X-Google-Smtp-Source: ABdhPJxqT/2umaD4/aHu85/MWv3TrsuUpe9Hy8GaC1bYpsgxw0TUYbQq4oA0fCCEsLK/Ld61/NNH+k6Qq2uTq/6mSl0=
X-Received: by 2002:a05:6512:3a6:: with SMTP id v6mr2440496lfp.90.1607057315322;
 Thu, 03 Dec 2020 20:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20201204005847.654074-1-daeho43@gmail.com> <X8msy1T8uqZ4Z/iR@sol.localdomain>
 <CACOAw_wTFsfgLfrWKRoM1o_HQorJE-=2ztZftQTn+comcpmHxQ@mail.gmail.com>
 <X8m0qbd7rvQyiwOt@sol.localdomain> <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
In-Reply-To: <CACOAw_y2HRE8CDk-HAjA6w_HzGJpRpivPY5zKRMC4_SNYTnTGg@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 4 Dec 2020 13:48:24 +0900
Message-ID: <CACOAw_xzKjZcpVTo3aj5sJUQ_BjLr=5ZhnfuyFwYerpyzZu+aw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix race of pending_pages in decompression
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I have another question.
I understand enabling the verity can be possible in the middle of I/O.
Is the opposite way also possible? Actually, I couldn't find any
disabling function of it, though.

2020=EB=85=84 12=EC=9B=94 4=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 1:31, D=
aeho Jeong <daeho43@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > Are you sure?  I thought that compression (and encryption) apply to the=
 whole
> > file, including any Merkle tree blocks past i_size.
>
> This "dic" structure is only for "de"compression, so we don't need to
> worry about going beyond i_size case.
>
> > Also, even if you include the i_size check, it's still wrong to check
> > fsverity_active() in the middle of the I/O because FS_IOC_ENABLE_VERITY=
 can
> > execute concurrently, causing fsverity_active() to return false at the =
beginning
> > of the I/O and true later in the I/O.  It needs to be checked only once=
, at the
> > beginning...
>
> Got it. Our previous implementation didn't consider this case. Need to fi=
x this.
>
> Thanks,
