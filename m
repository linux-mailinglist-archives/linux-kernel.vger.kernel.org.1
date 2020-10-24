Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A7297C9F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761777AbgJXNiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 09:38:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34175 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761768AbgJXNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 09:38:50 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kWJku-0000rb-Et
        for linux-kernel@vger.kernel.org; Sat, 24 Oct 2020 13:38:48 +0000
Received: by mail-wr1-f70.google.com with SMTP id h8so2307379wrt.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 06:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RDRwq8+3VpThffYJtXt/v2rYH+3Mm1/lRXG8WvQsfX8=;
        b=XWP0/7VyrFdcUKnIYR/l6rilqluKG2nkx4XSperaskI79QtW99/3A7l3UU+gp0z3Lb
         dCQh/lGyistlQSvCkNMLLVIeczze7EcdNdfTY1Exv33ZJoD46squjEDij3RL4ure/Shg
         Psl47LFt6NbJ5yi7Rh2ZfW9BsE1B2QyghZayYPapoMZ1T41HsOQh8sKal1HJo5ZN1csp
         UaChT04TOVsFvKrKQNb32TjoW9/AYcspfSunhAfx6/3grFQ0HfSBc69YXhvj3RwDnDb5
         BEi4Zw2YNYZ2BFeGvBiqh0+MCwylu7FX8bSWtbkvHY/7izQ9oGrcBOW5oQbFCY7AjUX5
         8wSA==
X-Gm-Message-State: AOAM531+fnGNPkx7ixBOqQF3qw2kNADnJG7DxSMIybuCt7NHyAMfSuyV
        knq2nZeVH8vJmLKWJTFKVmhapv4jKsAMfoyFmE41mNZ8csFXo033oDamqC+AoK6+xR54A201Tf6
        O+mkjN6ISsQDo54wMQZ4DXLoJ+5YQLcFURx7/LtgDeg==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr6623605wmd.146.1603546728000;
        Sat, 24 Oct 2020 06:38:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2E7LrJHN/ax9a42WqsByu0neKeFDFF22hpeLgIQ06+1FEVSmOr//XRtzNPnWYirII/z/lgw==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr6623590wmd.146.1603546727785;
        Sat, 24 Oct 2020 06:38:47 -0700 (PDT)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id m12sm9937844wmi.33.2020.10.24.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 06:38:47 -0700 (PDT)
Date:   Sat, 24 Oct 2020 15:38:46 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: swap file broken with ext4 fast-commit
Message-ID: <20201024133846.GA33750@xps-13-7390>
References: <20201024131333.GA32124@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024131333.GA32124@xps-13-7390>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 03:13:37PM +0200, Andrea Righi wrote:
> I'm getting the following error if I try to create and activate a swap
> file defined on an ext4 filesystem:
> 
>  [   34.406479] swapon: file is not committed
> 
> The swap file is created in the root filesystem (ext4 mounted with the
> following options):
> 
> $ grep " / " /proc/mounts
> /dev/vda1 / ext4 rw,relatime 0 0
> 
> No matter how long I wait or how many times I run sync, I'm still
> getting the same error and the swap file is never activated.
> 
> A git bisect shows that this issue has been introduced by the following
> commit:
> 
>  aa75f4d3daae ("ext4: main fast-commit commit path")
> 
> Simple test case to reproduce the problem:
> 
>  # fallocate -l 8G /swapfile
>  # chmod 0600 /swapfile
>  # mkswap /swapfile
>  # swapon /swapfile
> 
> Maybe we're missing to mark the inode as clean somewhere, even if the
> transation is committed to the journal?

I think I see the problem. There's something wrong in
ext4_inode_datasync_dirty(), it looks like the logic to check if the
inode is dirty is quite the opposite.

I'll test and send a patch soon.

-Andrea
