Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167EF28AB96
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgJLCGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:06:15 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:53837 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgJLCGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:06:15 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2020 22:06:14 EDT
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 8FD462EA08E;
        Sun, 11 Oct 2020 21:57:05 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id kDROQ88fsnuA; Sun, 11 Oct 2020 21:50:07 -0400 (EDT)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 39D512EA02E;
        Sun, 11 Oct 2020 21:57:05 -0400 (EDT)
Reply-To: dgilbert@interlog.com
Subject: Re: [question] What happens when dd writes data to a missing device?
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsOVXh89h2e4EuNbDKiCNwKm8599UE-h0GN-jPhpfyoCVA@mail.gmail.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <b814a441-1f5c-682a-4621-abc3259b7409@interlog.com>
Date:   Sun, 11 Oct 2020 21:57:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsOVXh89h2e4EuNbDKiCNwKm8599UE-h0GN-jPhpfyoCVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-11 3:46 p.m., Mikhail Gavrilov wrote:
> Hi folks!
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

Others have answered your direct question.

You may find 'oflag=nocreat' helpful if you (or others) do _not_ want
a regular file created in /dev ; for example: if you have misspelt a
device name.
That flag may also be helpful in unstable systems (e.g. where device
nodes are disappearing and re-appearing) as it can be a real pain
if you manage to create a regular file with a name like /dev/sdc when
the disk usually occupying that node is temporarily offline. When
that disk comes back online then regular file '/dev/sdc' will stop
device node '/dev/sdc' from being created.

The solution is to remove the regular file /dev/sdc and you probably
need to power cycle that disk. If this becomes a regular event then
'oflag=nocreat' is your friend [see 'man dd' for a little more
information, it really should be expanded].

Doug Gilbert

