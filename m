Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90F02D0B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgLGH3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGH3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:29:21 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A58FC0613D1
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:28:40 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id t22so13921214ljk.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xssgPHeMTAo4K6R4jN7ETP4Q6QWs4ur+getv3Nc7VYo=;
        b=RVBYcnQxwT/pyLzbrXk4X8TqpF8sst1fcXHN1zeAh9yFuAOusAum/OOyqoIeeiblxe
         99g3ymYK0jfqG1541u3I2AuHqe6NeWXjSJt2YjTQj+NohRfnxu76dySCvHEhMR2SWEIr
         74WHfOZq+r4b+EWTe4P0DAQ3K/OHVXwXTyMypif/XzYCBV+Te3d3vSeY7ulCBq1jVvuM
         Zridh148X/G2RFMuinQndxF9GmFKYXcpSbqfb7EttjNDirTWBN+ZMdJj49PbHBRrzyBa
         zRspjgpEihHTPm9OgU9RZVpWV3aojQfAJHIKFvcEqT/8kGaGkDEE/FvtGXvVrwUhPN16
         03JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xssgPHeMTAo4K6R4jN7ETP4Q6QWs4ur+getv3Nc7VYo=;
        b=QKbrmy32vuw9APRC7yDpWAiSfJi13EZU1TFyWZpvGk/ID7tc/PIjwKaKNwjO2rpHDm
         NPuiGdxH0jjhyAyDrHu5ugSWEvajShi8nDVSVj3t7NrmNtfGTFVnPeMYBHXcm9J6XLFH
         O06QR0hfdcAprIn+IFbu5AyP9kMxvn28tJgmmcxAPcSBt32qQbPbgUx25gtKGIQVoVxP
         CoOB6beORtZn/8Qv2E9XsTVVDWfMs5r9GERCOLM3zqEPEY5yvOmCni850Vv+O/3ZQkdq
         cPR4OuLVK/+UN+C/bjm1fM1TPhHMcPN6YuDsNcDHiU2oVQ9eMf0z14yh6TVdGKimF7oT
         YVaQ==
X-Gm-Message-State: AOAM531qdyfSP4LFre4GqEGSnLghg643tkDcSzBcAfdy5YbRhuw+4AWs
        3sS5VsyEivBNqwaCFqAMJsLsgke3u2ycrwkSs+vA4o1Cm6w=
X-Google-Smtp-Source: ABdhPJxzPJi4K7+p3JPjqKY/jWGalH0s5b2CuMKAaiB334oGPBo/t+1qeWzUEJPowrS0ap4PYOUUh5lEWBFsJOGaVrQ=
X-Received: by 2002:a2e:bc16:: with SMTP id b22mr8595524ljf.166.1607326119032;
 Sun, 06 Dec 2020 23:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20201205042626.1113600-1-daeho43@gmail.com> <c3c41d53-2a99-17a2-223a-3d674613a417@huawei.com>
In-Reply-To: <c3c41d53-2a99-17a2-223a-3d674613a417@huawei.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 7 Dec 2020 16:28:28 +0900
Message-ID: <CACOAw_zwbmYHbUVUmzGMci9SaSVSrP8NXXavHBSSLxbAEOrMcw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in decompression
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like it will be better to move this into merge condition?
>
>                 if (bio && (!page_is_mergeable(sbi, bio,
>                                         *last_block_in_bio, blkaddr) ||
>                     !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL) ||
>                         f2fs_verify_mergeable_bio())) {
>

I tried this for the first time, but it requires unnecessary checks
within the compression cluster.
I wanted to just check one time in the beginning of the cluster.
What do you think?
