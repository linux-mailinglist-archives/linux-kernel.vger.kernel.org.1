Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359502DD482
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgLQPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgLQPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:44:57 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFE1C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:44:16 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c12so19246478pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YJBDB26f+rldjj+37sZsFkhqfX20jU8Ct5zIftBgtXU=;
        b=hhgQdzkn4X5+KE3TaD5QBQ1MyViUTs8nYplu8dVBPHSodPeadQRmtzi7/kzdtKtYaZ
         0wAJ8pgg49ZD77BJ9l1Ox3cSZORcPe3dtTBc93E4UcaIAgKtrhE4XyVs2TwCPazOThkf
         pxGK5Wn5t3y+kAtOKYcZWGDnQm6S+0Yepfe4ywYHDSy1bblhT/hVyLsE9LnijR/u1u7f
         /NzKEH1QZG+qwFp6mQe8zWs2chV4KT/8G2+EDYX8bVMGfYFH2hbnuxAjp97t2yJrcAeP
         WYm7+5/1TLeOkchXIT133Kpsn1Ocn5IZvbwfBX9cvdHEucf3aIzxT3xRH2LpBX1JzDn+
         /INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YJBDB26f+rldjj+37sZsFkhqfX20jU8Ct5zIftBgtXU=;
        b=q0YgkXbM/lmhfZhecc1zBRR2cGqIMe1r0PXgA2O3JfO8qhSHUXnB2DWSy2kfHrBok2
         9uBM8cq/C1aQiTmepUktGVs+a5HHKcej6tyY4BDDl3Q03osjK0bPApNxJhdliNWVzAwa
         ErTIr/2BY15XfzQym8DCb9jSZgjeW0Cr0qkL2e6Nq/9Ho3oMCx74hC0NcBZKpNvGP4p9
         6ie07q/Ca4JmRXXctTCUQBapU2dB38CA91Akj0a2eXnL4Xby0D0ijIit4gmvArZmWF06
         cxg9HgtaIUnZHHN1yGusQ/YzjJ0SZjxHmtO/0BjzttGRieY6Q+JcXxvlfqYoiwTLuoVi
         3dpA==
X-Gm-Message-State: AOAM531So9SzIqbfqpgcHvthHZ3yGF6fGzwWguG3r5POV88TslsoO7d5
        YGSG/VzWqmuLxHafZ+s0iLzGzw==
X-Google-Smtp-Source: ABdhPJwAh5eLMHrPai0VNx94cdnNrnhRTNrFKUwxQB4WkMTaZfdJFDFAoT2h4yBUrsqH2Gim34zjhA==
X-Received: by 2002:a65:6118:: with SMTP id z24mr8644793pgu.191.1608219856009;
        Thu, 17 Dec 2020 07:44:16 -0800 (PST)
Received: from google.com (139.60.82.34.bc.googleusercontent.com. [34.82.60.139])
        by smtp.gmail.com with ESMTPSA id na6sm4736607pjb.12.2020.12.17.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 07:44:15 -0800 (PST)
Date:   Thu, 17 Dec 2020 15:44:11 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] add support for metadata encryption to F2FS
Message-ID: <X9t8y3rElyAPCLoD@google.com>
References: <20201005073606.1949772-1-satyat@google.com>
 <471e0eb7-b035-03da-3ee3-35d5880a6748@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471e0eb7-b035-03da-3ee3-35d5880a6748@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 05:53:06PM +0800, Chao Yu wrote:
> On 2020/10/5 15:36, Satya Tangirala wrote:
> > This patch series adds support for metadata encryption to F2FS using
> > blk-crypto.
> 
> It looks this implementation is based on hardware crypto engine, could you
> please add this info into f2fs.rst as well like inlinecrypt...
> 
To be precise, the implementation requires either a hardware crypto
engine *or* blk-crypto-fallback. I tried to clarify this a little better
in the commit messages and in fscrypt.rst, but thinking about it again
now, I think I should add a section about metadata encryption at the end
of f2fs.rst. I'll do that when I send out v3 of this patch series (I
just sent out v2).
> > 
> > Patch 3 wires up F2FS with the functions introduced in Patch 2. F2FS
> > will encrypt every block (that's not being encrypted by some other
> > encryption key, e.g. a per-file key) with the metadata encryption key
> > except the superblock (and the redundant copy of the superblock). The DUN
> > of a block is the offset of the block from the start of the F2FS
> > filesystem.
> 
> Why not using nid as DUN, then GC could migrate encrypted node block directly via
> meta inode's address space like we do for encrypted data block, rather than
> decrypting node block to node page and then encrypting node page with DUN of new
> blkaddr it migrates to.
> 
The issue is, the bi_crypt_context in a bio holds a single DUN value,
which is the DUN for the first data unit in the bio. blk-crypto assumes
that the DUN of each subsequent data unit can be computed by simply
incrementing the DUN. So physically contiguous data units can only be put
into the same bio if they also have contiguous DUNs. I don't know much
about nids, but if the nid is invariant w.r.t the physical block location,
then there might be more fragmentation of bios in regular read/writes
(because physical contiguity may have no relation to DUN contiguity). So I
think we should continue using the fsblk number as the DUN.
