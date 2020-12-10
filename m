Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C726B2D5AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgLJMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgLJMjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:39:46 -0500
Date:   Thu, 10 Dec 2020 13:39:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607603946;
        bh=R9vT9hSkc8LlAqDMjrVSGcwbTBiWyWa5JZCctWQYf1w=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKmPXu5lyubf303FVqVLcnV5tIyyw2CcBliYXxaHfvniGSPohah2U7LmT4lR1j7+6
         Xw6FrdBsmvay5T0wsIoswzIdhAniI7Ah0DRTd4iDak/1R4eIaaDeeieTU7uRKQ0CeL
         zaM0W6yL4z73NAUXn4SCl0Jx8S9jJdeIOBJGJ7PlfNO7i37jDCyz+3fNOFvU02vuYT
         dv9N6pB79bT1FeEOwBDVIQyipItOn5VJCyjLVlafEQIQMiV1MVGuzY3qtLU5dylycq
         NQQ8us7sh91Dt8gGr8KLG/BYn99WcrdlYDOmgMUxdYsDaoZzV5NYYluG11yVfp3Li+
         fqGm25RXE1s+Q==
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org, systemd-devel@lists.freedesktop.org
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Franck Bui <fbui@suse.com>
Subject: Re: [PATCH RFC 1/1] module: delay kobject uevent until after module
 init call
Message-ID: <20201210123900.GA28117@linux-8ccs>
References: <20201203135124.16695-1-jeyu@kernel.org>
 <20201203135124.16695-2-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201203135124.16695-2-jeyu@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [03/12/20 14:51 +0100]:
>Apparently there has been a longstanding race between udev/systemd and
>the module loader. Currently, the module loader sends a uevent right
>after sysfs initialization, but before the module calls its init
>function. However, some udev rules expect that the module has
>initialized already upon receiving the uevent.
>
>This race has been triggered recently (see link in references) in some
>systemd mount unit files. For instance, the configfs module creates the
>/sys/kernel/config mount point in its init function, however the module
>loader issues the uevent before this happens. sys-kernel-config.mount
>expects to be able to mount /sys/kernel/config upon receipt of the
>module loading uevent, but if the configfs module has not called its
>init function yet, then this directory will not exist and the mount unit
>fails. A similar situation exists for sys-fs-fuse-connections.mount, as
>the fuse sysfs mount point is created during the fuse module's init
>function. If udev is faster than module initialization then the mount
>unit would fail in a similar fashion.
>
>To fix this race, delay the module KOBJ_ADD uevent until after the
>module has finished calling its init routine.
>
>References: https://github.com/systemd/systemd/issues/17586
>Signed-off-by: Jessica Yu <jeyu@kernel.org>

Thanks all, this has been applied to modules-next to try to get as
much -next time as possible before the upcoming merge window.

Jessica

