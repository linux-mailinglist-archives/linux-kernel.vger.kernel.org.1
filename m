Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2A28AA6C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgJKUcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbgJKUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:31:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A4C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 13:31:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRi0V-00FaRp-PU; Sun, 11 Oct 2020 20:31:51 +0000
Date:   Sun, 11 Oct 2020 21:31:51 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [question] What happens when dd writes data to a missing device?
Message-ID: <20201011203151.GD3576660@ZenIV.linux.org.uk>
References: <CABXGCsOVXh89h2e4EuNbDKiCNwKm8599UE-h0GN-jPhpfyoCVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsOVXh89h2e4EuNbDKiCNwKm8599UE-h0GN-jPhpfyoCVA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:46:03AM +0500, Mikhail Gavrilov wrote:
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
> Where the data was written

Into a file called "/dev/adb", of course.

> and could it damage the stored data in
> memory or on disk?

Why would it?  There's nothing magical about /dev - the same thing happened
as if you said
dd if=/home/mikhail/Downloads/whatever.iso of=/tmp/adb
or, for that matter, of=/home/mikhail/copy-of-that-damn-iso - it had been
asked to write into file with that name if it already existed or to create it
and write into it if it didn't exist...  So it had created a file in /dev
with name adb and stored a copy into it.  You might run out of space if the
file had been large enough, but that's about it...

Try ls -l /dev/adb /dev/sdb and compare these two - sdb will be something
like
brw-rw---- 1 root disk 8, 16 ....
and adb -
-rw-rw---- 1 root <some group> <size of that sucker> ...

Block device and regular file respectively...  man mknod if you are
curious about device nodes and creating them manually - usually that's
done by scripts called by udev when it discovers devices, but that's
what they boil down to in the end.

Again, there's nothing magical about /dev or the names of specific
device nodes created in it - it's just the usual place to put that
stuff into, but that's it; you could call mknod(2) to create such
device nodes in any directory, using any names.
