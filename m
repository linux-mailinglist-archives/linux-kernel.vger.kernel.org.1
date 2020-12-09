Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC62D3EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgLIJYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:24:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34393 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgLIJYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:24:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id y16so1467259ljk.1;
        Wed, 09 Dec 2020 01:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VSXjX30nb95ylXg0DHjuSrt5F+lxLssDOMiUFiRthM=;
        b=ktq1dO8jTyyXPs9cxg3NYPOp4Y+U5XA3gSJMle84cS/+Yz57D9aCH9LMoUuUD8+vx7
         fL9lHKd/wzc7/h1qT6ItDtB5h60zXv+IkDBwMsGMzjMD4wa/tgpnST8iVvPftf2clnO4
         evXTKVPn/uW1EkGuMJ9kaMldi/hxJt6dCXNXkoZHq7d9to8Gzmp8vsK6PCFb4OenfgWA
         wdqoAmGeqdmLamRLHthDtc+zffasLb5AY9TM2tZf9/68gQ/mhdT/riM1hgTGy9jFknrO
         OzYJ0E/SUk1GWDDRT+MWvNFESHLv4MHSCFaPk97bnnxXM8aN3c0l3zZrA2i+mhSC4ZMH
         2nHg==
X-Gm-Message-State: AOAM532J3uMC8gpSCu+HDPvsioBPfuv91cEc12izHIZJxQPkkH8jxOKn
        kMmfTcifzH78ZT5l8YOBMirugSkckZTUdg==
X-Google-Smtp-Source: ABdhPJzQXUCJL4iz+RheE62r4Bw2gHqbsScJaBTtQ5DIiyNT+X4ywrUYxEFiRv/rTct+8TpS4Owpyw==
X-Received: by 2002:a2e:b4da:: with SMTP id r26mr679324ljm.486.1607505837962;
        Wed, 09 Dec 2020 01:23:57 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id i15sm107954lfc.128.2020.12.09.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:23:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmvi9-0006uR-6d; Wed, 09 Dec 2020 10:24:37 +0100
Date:   Wed, 9 Dec 2020 10:24:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+8881b478dad0a7971f79@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: UBSAN: shift-out-of-bounds in option_probe
Message-ID: <X9CX1X6o5ufiIBtO@localhost>
References: <0000000000004c471e05b60312f9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004c471e05b60312f9@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:33:11PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    15ac8fdb Add linux-next specific files for 20201207
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17dc6adf500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3696b8138207d24d
> dashboard link: https://syzkaller.appspot.com/bug?extid=8881b478dad0a7971f79
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e89613500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17993623500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8881b478dad0a7971f79@syzkaller.appspotmail.com
> 
> usb 1-1: config 0 interface 109 has no altsetting 0
> usb 1-1: New USB device found, idVendor=12d1, idProduct=02cb, bcdDevice= 1.fb
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> ================================================================================
> UBSAN: shift-out-of-bounds in drivers/usb/serial/option.c:2120:21
> shift exponent 109 is too large for 64-bit type 'long unsigned int'

Ok, we need to add a sanity check against large interface numbers before
the device-flag tests. I'll cook something up.

Johan
