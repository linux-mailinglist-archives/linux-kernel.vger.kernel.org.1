Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909A92D3328
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgLHUQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34163 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731012AbgLHUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:51 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B8Ir8wQ007362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Dec 2020 13:53:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F289B420136; Tue,  8 Dec 2020 13:53:07 -0500 (EST)
Date:   Tue, 8 Dec 2020 13:53:07 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Pass modules to Linux kernel without initrd
Message-ID: <20201208185307.GE52960@mit.edu>
References: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 10:24:08AM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> Trying to reduce the boot time of standard distributions, I would like to
> get rid of the initrd. The initrd is for mounting the root file system and
> on most end user systems with standard distributions that means loading the
> bus driver for the drive and the file system driver. Everyone could build
> their own Linux kernel and build the drivers into the Linux kernel, but most
> users enjoy using the distribution Linux kernel, which build the drivers as
> modules to support a lot of systems. (I think Fedora builds the default file
> system driver (of the installer) into the Linux kernel.)

It's unclear what you are trying to speed up by replacing the initrd
with "appending the required modules to the Linux kernel image".  Why
do you think this will speed things up?  What do you think is
currently slow with using an initrd?

If what you are concerned about is the speed to load an initrd which
has all of the kernel modules shipped by the distribution, including
those not needed by a particular hardware platform, there are
distributions which can be configured to automatically include only
those kernel modules needed for a particular system.

There are also some shell scripts which some people have written that
will automatically create a kernel config file which only has the
device drivers needed for a particular system.  Creating a system
which used such a script, and then compiled a custom kernel image
would also not be hard.

You seem to be assuming that building a custom kernel image ish
hard(tm), and so no user would want to do this.  If this were 
automated, what is your objection to such an approach?

Without a clear understanding what part of the boot process you think
is slow, and which you are trying to optimize, and what precisely your
constraints are, or at least, what you *think* your constraints are,
and why you think things have to be that way, it's going to be hard to
comment further.

Cheers,

					- Ted
