Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAD928AA08
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgJKUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:00:58 -0400
Received: from hydra.sdinet.de ([136.243.3.21]:43646 "EHLO mail.sdinet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgJKUA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:00:57 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2020 16:00:57 EDT
Received: from aurora.sdinet.de (aurora.sdinet.de [193.103.159.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: haegar)
        by mail.sdinet.de (bofa-smtpd) with ESMTPSA id 9C3DE34028F;
        Sun, 11 Oct 2020 21:52:21 +0200 (CEST)
Date:   Sun, 11 Oct 2020 21:52:20 +0200 (CEST)
From:   Sven-Haegar Koch <haegar@sdinet.de>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [question] What happens when dd writes data to a missing
 device?
In-Reply-To: <CABXGCsOVXh89h2e4EuNbDKiCNwKm8599UE-h0GN-jPhpfyoCVA@mail.gmail.com>
Message-ID: <alpine.DEB.2.23.453.2010112150070.3140856@aurora.sdinet.de>
References: <CABXGCsOVXh89h2e4EuNbDKiCNwKm8599UE-h0GN-jPhpfyoCVA@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020, Mikhail Gavrilov wrote:

> I have a question.
> What happens when dd writes data to a missing device?
> 
> For example:
> # dd if=/home/mikhail/Downloads/Fedora-Workstation-Live-x86_64-Rawhide-20201010.n.0.iso
> of=/dev/adb
> 
> Today I and wrongly entered /dev/adb instead of /dev/sdb,
> and what my surprise was when the data began to be written to the
> /dev/adb device without errors.
> 
> But my surprise was even greater when cat /dev/adb started to display
> the written data.
> 
> I have a question:
> Where the data was written and could it damage the stored data in
> memory or on disk?

If the device node /dev/adb does not exist (most likely udev case when 
you don't have the device/no module loaded for it) then dd as root will 
just create a normal file inside the /dev ramdisk.

Only if the device node exists but is not handled then something else 
like an open error will happen.

c'ya
sven-haegar

-- 
Three may keep a secret, if two of them are dead.
- Ben F.
