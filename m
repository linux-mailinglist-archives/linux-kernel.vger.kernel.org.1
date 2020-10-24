Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FFB297C91
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761724AbgJXNNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 09:13:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33955 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761716AbgJXNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 09:13:41 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kWJMZ-0007mZ-Ix
        for linux-kernel@vger.kernel.org; Sat, 24 Oct 2020 13:13:39 +0000
Received: by mail-wm1-f69.google.com with SMTP id z62so1214062wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 06:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eVttoSXvi/+R5QaLq4CVVO/8VY2PkGXsswXQjE147KQ=;
        b=JMB9NpDqE/57GyEwsGCFEFI5BfwCFdoM29Tbz7AUk5iqr/EZnj1qK0NUdkzi39jizp
         OFI9HTtY/LmqCkabpfx6By1gUXqUtG9qXOjrXVIeKJVmxRVVeBH3hYGKpNg85/lhjSP0
         ytdo69kgYvvC374HvgEEDj1jBV/IEfEPe2sL3myY7f7t+C0v7hSvF8sE53m3FPUMI+tb
         1QgxraNWpNBl190oAt/rQ6eqC5z1QwU3O8bRvp50qY+55yFXuZJe7Mk/ck6ZeVRv5ATE
         /JOmAbApCd9b56oVMgysZR6lvCMswO6uDC9SsJ53n20Ze7+UPXaAg0ceQlK0ZrBXP0r9
         Fgvw==
X-Gm-Message-State: AOAM533I6LylOayFDCxCftgL+FmFzgqLHfVzPEOrQo6NyBUGoUQCcyWP
        7Mp4P2VDoTxrvealYN4k0xP+SlW1QF8JqyQVYgc68mviC6q9b22kAPWiWC4ozAEYvsGsDOeGXfy
        BfVpX75C8Uq1cvJ4ewZc+qEVwWhk1Dp+pO2nYG31QbA==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr6919189wmh.186.1603545219174;
        Sat, 24 Oct 2020 06:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxb4Q7HPONqIXu6KDJ5bPFCRZSabTgLRKzN7DRjvCNRHQmmn9cL4hmqjKPxKsOk91n35/bpIQ==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr6919021wmh.186.1603545216681;
        Sat, 24 Oct 2020 06:13:36 -0700 (PDT)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id c185sm10661303wma.44.2020.10.24.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 06:13:36 -0700 (PDT)
Date:   Sat, 24 Oct 2020 15:13:33 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: swap file broken with ext4 fast-commit
Message-ID: <20201024131333.GA32124@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following error if I try to create and activate a swap
file defined on an ext4 filesystem:

 [   34.406479] swapon: file is not committed

The swap file is created in the root filesystem (ext4 mounted with the
following options):

$ grep " / " /proc/mounts
/dev/vda1 / ext4 rw,relatime 0 0

No matter how long I wait or how many times I run sync, I'm still
getting the same error and the swap file is never activated.

A git bisect shows that this issue has been introduced by the following
commit:

 aa75f4d3daae ("ext4: main fast-commit commit path")

Simple test case to reproduce the problem:

 # fallocate -l 8G /swapfile
 # chmod 0600 /swapfile
 # mkswap /swapfile
 # swapon /swapfile

Maybe we're missing to mark the inode as clean somewhere, even if the
transation is committed to the journal?

Thanks,
-Andrea
