Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A302E8883
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbhABUpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 15:45:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37841 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726659AbhABUpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 15:45:09 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 102KiJ66020836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 2 Jan 2021 15:44:20 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C0F1015C3516; Sat,  2 Jan 2021 15:44:19 -0500 (EST)
Date:   Sat, 2 Jan 2021 15:44:19 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Generate the config file for kernel compilation
 non-interactively in script.
Message-ID: <X/DbIyM2aUn+ZSCO@mit.edu>
References: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGP6POJ1pRgSP+FSC2ds9afx4rDxm0BkbKK-RAJQuwLUE_2WhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 01, 2021 at 12:51:13PM +0800, Hongyi Zhao wrote:
> 
> I want to build the realtime Linux for ROS 2 according to the
> guidelines here:
> <https://index.ros.org/doc/ros2/Tutorials/Building-Realtime-rt_preempt-kernel-for-ROS-2/>.
> 
> For this purpose, I must enable the rt_preempt relative options in the
> kernel withe the following method interactively:
> 
> But this is very inconvenient for doing the above job in script. Is
> there an alternative method to generate the above configurations for
> kernel compilation  non-interactively in script.

What I do for a slightly different use case is to use defconfigs.
After setting up a minimum kernel that has what I need for my use case
(in my case, to build a kernel that works for kvm-xfstests and
gce-xfststs), I save a defconfig: "make savedefconfig", and then stash
in a git repository:

https://github.com/tytso/xfstests-bld/tree/master/kernel-configs

Then when I need to build a kernel, I just copy a defconfig to
.config, and then run the command "make olddefconfig" to expand it
out.  The reason why I use defconfigs is that very often, at least for
my use cases, a defconfig generated for kernel version X.Y tends to
work for X.Y+1, X.Y+2, etc.  That's not always true, of course, which
is why there are a few extra lines added to:

https://github.com/tytso/xfstests-bld/blob/master/kernel-configs/x86_64-config-4.19

This was needed so that the this defconfig will work for 4.19.y
through 5.3.y.  The special cases were needed for 5.1 and 5.2, but I
haven't needed it for any other kernel versions in terms of making a
kernel that would correctly boot on KVM and GCE and correctly run
xfstests for ext4, xfs, btrfs, f2fs, etc.  So I just create a
defconfig for each LTS kernel version, and for the most part, it will
work for future kernel versions until the next LTS kerenl version gets
released, at which point I create a new defconfig for my test
appliance use case.

If your goal is to build newer kernel versions for RT_PREMPT kernels
for your use case, perhaps this technique will be helpful for you.

Hope this helps,

					- Ted
