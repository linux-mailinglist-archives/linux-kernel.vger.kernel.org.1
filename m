Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188E227D157
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgI2Oh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbgI2Oh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:37:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEFCC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:37:26 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so5661592wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4thglTsU672R6183seyBnljqOq4ywCJEfxOVEmyHhBc=;
        b=YdyLS5EenXDRxghn69b9SpbqPtIfctAotTCVJYuhsSJwzn3N555MgFY53pQxvCS7cj
         KQQxQ1IbPkCt+yiN2OZbuHK/9RsG5qndjhi8InnjMRI6SuJ3dD37R9XXPUut1F9gU9+S
         KPaCAJXubIHsmVFCfo+br3kfyP4dDEcp5NvDbM9LydE0n5UOohb2cyYrdY3irscF8Bzk
         slySsHDAnBPEo7oh+7revV68LyXhlZBpg6dr5TdANFp9syC7WZWHlncy12r25pdu91Xx
         IuZyHSP86XnZ8b7CoxfPcEWUcrD3Peu3hxSYf3GzGhqu4lFfJjY2UnHMOOwn0MxzdlwX
         5d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4thglTsU672R6183seyBnljqOq4ywCJEfxOVEmyHhBc=;
        b=oLbd4KCzZ8DXzZKiBarfUGlcYgB7UuU74Yw/lBfEp0pUvOUxELsfVPl10vkGgTGQpH
         4rC2cY8d+RBBVW2SOYRrfUeucf+6lQ3GZT0S/lF/0wIuSpe2h1YfrM7G3GhSie8Ty/0T
         JVfCsTgmx1me5aVSTBFztJv2LmrF5k3Iql5V7xKnU0nbiZG4gp4Bs165H7zZQnTLkj38
         4wbYMfK2pEn0k1+9Mynz4J7t9V+84XwivlEEFJMT8Wf+CwT+2Xydf06cH9+w2+d2PmsT
         81iPnHKjBg912StXGCwAxPaKzhW+u50EbTyN/KMzZabUYDrrxdM4kWPknrswDASr3Pjq
         FWfQ==
X-Gm-Message-State: AOAM532BX9qVEsdtcBDLzn9ye3lVASS8bes2Tyd5g7dIxNROAUmRQnmK
        YSMH+WFmBt4eU5up09LDXVVaNA==
X-Google-Smtp-Source: ABdhPJwTnLt9PJBcyxeHBl/hpr0rDd9CLDdBUt1LQth6Z+obyqx4rWDWAJnjil4yI+hg9W2jV1TMPA==
X-Received: by 2002:adf:c404:: with SMTP id v4mr4640623wrf.17.1601390244674;
        Tue, 29 Sep 2020 07:37:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id 11sm5418223wmi.14.2020.09.29.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:37:24 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:37:22 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 1/4] fuse: Definitions and ioctl() for passthrough
Message-ID: <20200929143722.GB1680101@google.com>
References: <20200924131318.2654747-1-balsini@android.com>
 <20200924131318.2654747-2-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924131318.2654747-2-balsini@android.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed the following fixup suggested by Amir slipped from this
submission.

Thanks,
Alessio

---8<---
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index b7d1a5517ffd..eba26196be92 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -185,7 +185,7 @@ int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
        passthrough_inode = file_inode(passthrough_filp);
        passthrough_sb = passthrough_inode->i_sb;
        fs_stack_depth = passthrough_sb->s_stack_depth + 1;
-       ret = -EEXIST;
+       ret = -EINVAL;
        if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
                pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
                goto out;
