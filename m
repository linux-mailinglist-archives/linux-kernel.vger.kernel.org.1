Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBAB2F8C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 09:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbhAPIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 03:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAPIEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 03:04:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC733C061757
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 00:03:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g15so2266150pjd.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 00:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:subject:from:to:cc:date
         :message-id;
        bh=9muHTujHAHMZmzbI2YDra9AnH8YPz6lEA0N9mwBfFEM=;
        b=t3bZOSG44ANooPgB0/O9avyrfD+eEDse82PBf1rvOtElin8E97mTo1fOM4kX+EqxIW
         NbJrLMEQEpM0/8Eb/6ea9fMTxmajcAcy5wrU5t2QCnIgA1OwgtkOxUwzaNAwODq7k1e4
         MXRyhGoeINaGzGCDjBNEIrzyHW/1SBT1PveRK6IGiCSBDXEm3uWSLq08Me5dB1DRUolw
         s3RVeBT48AUTbfbNwdOQMyA9aHdTBRlnYF6iYtPhK6n/SSCbL1GiyFFUfW1o/H0vG/BU
         adz5hN8P6GPe/kiMmumpM/7T7y/kTZgqm8FtjoNoMycya3yAnUvVwTJ/WqAD/ZXlzSZd
         Qw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:to:cc:date:message-id;
        bh=9muHTujHAHMZmzbI2YDra9AnH8YPz6lEA0N9mwBfFEM=;
        b=sSHN7MDmywIFvC9mhqbBHJE+dBVslE8wQfQ5cJY0NvqaDMWRkdPb1+I/WJI07xjx10
         YIljEHejTsbFWrq+wkvuJkubAZEIF/nh7lSbUHpXx+wHWLTGwrG3lGn6shE9klrF9hKQ
         xvHDet9E7KG6qF3/7VhN68LMWms/tfo5v5vqfhAQS+qq+yVblEAV8/3k1+npJT1CYt90
         JfUktbdt6Th3MiSCMa4sqMDt3z+YY0gQcIIJlOpLZONWxWTbq346UZsUIWcg77H4znc+
         j5SImmOTQSx83RyGpUci729ZV9yrkEqmH8zUrkX80ri38e2XzF3GQFbp8qBDfm34IcFb
         t53Q==
X-Gm-Message-State: AOAM533g9nVMy7S/zJvfpzxCiezAS+5tCZk/pS+wJRbc3AFCpmZq7Vki
        OAxqzYXkM95l1eb4sf8eyTtBEG0LWmI=
X-Google-Smtp-Source: ABdhPJy+CAz3dCrBy1F94JMtgDKyOiTyZ0mrQq20HKB7mni4jmRde6X84t4ZhI3ICpeSVvvm5PwS6g==
X-Received: by 2002:a17:902:7007:b029:dc:e89:50f1 with SMTP id y7-20020a1709027007b02900dc0e8950f1mr16677517plk.72.1610784237320;
        Sat, 16 Jan 2021 00:03:57 -0800 (PST)
Received: from localhost ([116.12.58.169])
        by smtp.gmail.com with ESMTPSA id nk11sm9995446pjb.26.2021.01.16.00.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 00:03:56 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Splicing to/from a tty
From:   "Oliver Giles" <ohw.giles@gmail.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Christoph Hellwig" <hch@lst.de>
Date:   Sat, 16 Jan 2021 20:35:41 +1300
Message-Id: <C8KER7U60WXE.25UFD8RE6QZQK@oguc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 36e2c7421f02 (fs: don't allow splice read/write without explicit ops=
) broke my userspace application which talks to an SSL VPN by splice()ing b=
etween "openssl s_client" and "pppd". The latter operates over a pty, and s=
ince that commit there is no fallback for splice()ing between a pipe and a =
pty, or any tty for that matter.

The above commit mentions switching them to the iter ops and using generic_=
file_splice_read. IIUC, this would require implementing iter ops also on th=
e line disciplines, which sounds pretty disruptive.

For my case, I attempted to instead implement splice_write and splice_read =
in tty_fops; I managed to get splice_write working calling ld->ops->write, =
but splice_read is not so simple because the tty_ldisc_ops read method expe=
cts a userspace buffer. So I cannot see how to implement this without eithe=
r (a) using set_fs, or (b) implementing iter ops on all line disciplines.

Is splice()ing between a tty and a pipe worth supporting at all? Not a big =
deal for my use case at least, but it used to work.
