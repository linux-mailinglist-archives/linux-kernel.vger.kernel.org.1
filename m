Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574FE2E8C26
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhACMih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 07:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbhACMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 07:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609677430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxdY5ocqcwDXMcWxyyfbMa+hKNGU2Zi10xyvQjqxw7U=;
        b=Iwa8JBXW7OCvRF5L+KH4kVAg0F5GSiJMMpABJB6zrjiLjaXhFsol6z9fw6jM4hu1cTt1Gb
        /f4gsDdkspWhDPG+2+PMfXwTpBgGTprbhu7aNn06UfyW6gsBbBz6ssYcCJmVjHMmz16B/k
        L5Ba0fWfyzEys6cdS5CalsDBOkiRWJI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-MPAjF10oN0yiAfeHAKzoJw-1; Sun, 03 Jan 2021 07:37:08 -0500
X-MC-Unique: MPAjF10oN0yiAfeHAKzoJw-1
Received: by mail-wm1-f71.google.com with SMTP id h21so8537248wmq.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 04:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QxdY5ocqcwDXMcWxyyfbMa+hKNGU2Zi10xyvQjqxw7U=;
        b=AweNa7HW+bPk5d830JVQN5w36d2QBYdsb01tDcrm6++GhEN+8dHrjpkiuxSsYAsLt6
         +Djg7YV4Ds2yMTM22xeRzK+Ar84/IBPobHKXS2OwwWmkjOA64gPKXJaxLGOg62nPcKIG
         urpTYex/FfL7MjVpuG/cHVjgs3e+c/r6pdgms2XkY47rif0jYJAQ8+2x6QiOt5k2oZ02
         IsfiFvFvEzMNPcjmuUIfbVUAWMq/N8hZeWu+HxEkjzEiAMzcGbtQpdPvJVVcyvd01Xth
         xj5Cy+72nivd91IwdjKmcfARhEVZszTgf1cLmKvv3S9D+Mrf9fzI1VhPOcfsvee8ZbdC
         pqDQ==
X-Gm-Message-State: AOAM531JLvM8cJ+RjucM0Be4SbndmWCfYaigHUjzIqiTIGmnOnU9LjvE
        JYIfl9qv5/XbTWzxLTv3IF4eJwdDp6Lh2cFSIxR+NnL/sPezZmIk7SA2dqSeOdFPamp/stZOnAn
        w9pMby8gFhi07XxfJDuXTdYlT
X-Received: by 2002:a1c:6689:: with SMTP id a131mr22858988wmc.33.1609677426760;
        Sun, 03 Jan 2021 04:37:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2rN+sNM5f2IdvomcUNGysJYX2pHs14Av12FmnC39k+PwITABTuPqJ7gBxvMFumZmxKXYMtg==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr22858976wmc.33.1609677426627;
        Sun, 03 Jan 2021 04:37:06 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
        by smtp.gmail.com with ESMTPSA id e16sm94661103wra.94.2021.01.03.04.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 04:37:05 -0800 (PST)
Date:   Sun, 3 Jan 2021 07:37:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com
Subject: Re: [PATCH V2 00/19] vDPA driver for virtio-pci device
Message-ID: <20210103073629-mutt-send-email-mst@kernel.org>
References: <20201204040353.21679-1-jasowang@redhat.com>
 <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a3fa2f5-d5d8-e8dd-71d1-cb81a3276658@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 11:52:14AM +0800, Jason Wang wrote:
> 
> On 2020/12/4 下午12:03, Jason Wang wrote:
> > Hi all:
> > 
> > This series tries to implement a vDPA driver for virtio-pci device
> > which will bridge between vDPA bus and virtio-pci device.
> > 
> > This could be used for future feature prototyping and testing.
> > 
> > Please review
> > 
> > Changes from V2:
> > 
> > - don't try to use devres for virtio-pci core
> > - tweak the commit log
> > - split the patches furtherly to ease the reviewing
> > 
> > Changes from V1:
> > 
> > - Split common codes from virito-pci and share it with vDPA driver
> > - Use dynamic id in order to be less confusing with virtio-pci driver
> > - No feature whitelist, supporting any features (mq, config etc)
> > 
> > Thanks
> 
> 
> Michael, any comment for this series?
> 
> It's needed for testing doorbell mapping and config interrupt support.
> 
> Thanks

I saw you got some comments back in december so was expecting another
version. If you'd rather I reviewed this one, let me know.

-- 
MST

