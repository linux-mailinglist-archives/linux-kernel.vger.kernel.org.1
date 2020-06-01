Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA01EA039
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 10:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgFAInj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 04:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgFAInj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:43:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC7C206E2;
        Mon,  1 Jun 2020 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591001017;
        bh=YagICseskD/MQ9NyjY8gqaD0BIKAvzeNKznfKrkmz1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0hLucYicv7L1jtVOhOW9BPFE0jHKDPqH9z+k7vG1k0dqNCj2mhipECCRb7oehPba
         KJcMHxStlJv33OqWxujbODDwZt8rfr2j/5Adlb6KFJKJQBbr50PHPOvNcjRh6A5O/N
         3Mle6HL3B98nae0//YJq3L3MVb3pyZUatOSVINQg=
Date:   Mon, 1 Jun 2020 10:43:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, balbi@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in snd_usbmidi_submit_urb/usb_submit_urb
Message-ID: <20200601084335.GA1667318@kroah.com>
References: <000000000000bbd09005a6fdc6cc@google.com>
 <000000000000f0261a05a700adf5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f0261a05a700adf5@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:24:03AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
> Author: Andrey Konovalov <andreyknvl@google.com>
> Date:   Mon Feb 24 16:13:03 2020 +0000
> 
>     usb: gadget: add raw-gadget interface
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164afcf2100000
> start commit:   bdc48fa1 checkpatch/coding-style: deprecate 80-column warn..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=154afcf2100000
> console output: https://syzkaller.appspot.com/x/log.txt?x=114afcf2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=129ea1e5950835e5
> dashboard link: https://syzkaller.appspot.com/bug?extid=5f1d24c49c1d2c427497
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d70cf2100000
> 
> Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

So the tool that was used to create the bug has bisected the problem to
the patch that adds the tool to the kernel to test for the issue?

This feels wrong...

greg k-h
