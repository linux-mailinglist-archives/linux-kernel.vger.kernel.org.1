Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0222CDDAE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgLCSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbgLCSb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:31:58 -0500
Date:   Thu, 3 Dec 2020 19:32:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607020272;
        bh=ooOaTQVTWODxjzPcn11n7fZSJANiXkVMAWaIlK7pTZY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxRgUcXk6SIi5v94rKZmgeeoN4ml7+qC96MjLr/CW22p/Jua1cK3pQI3Ye3J37zVe
         0SG0FFw/ZAGT1zFVb91ZnRAmDht/V0eMirkKUurk+bYTHtKl96pzvXL3igbqJnHtHm
         qDQuw8sqsIKuZ3J9tIU/7vPAlGXLxajMy5uaojf0=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, systemd-devel@lists.freedesktop.org,
        Franck Bui <fbui@suse.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [systemd-devel] [PATCH RFC 1/1] module: delay kobject uevent
 until after module init call
Message-ID: <X8kvM8hl6abbfg8W@kroah.com>
References: <20201203135124.16695-1-jeyu@kernel.org>
 <20201203135124.16695-2-jeyu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203135124.16695-2-jeyu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 02:51:24PM +0100, Jessica Yu wrote:
> Apparently there has been a longstanding race between udev/systemd and
> the module loader. Currently, the module loader sends a uevent right
> after sysfs initialization, but before the module calls its init
> function. However, some udev rules expect that the module has
> initialized already upon receiving the uevent.
> 
> This race has been triggered recently (see link in references) in some
> systemd mount unit files. For instance, the configfs module creates the
> /sys/kernel/config mount point in its init function, however the module
> loader issues the uevent before this happens. sys-kernel-config.mount
> expects to be able to mount /sys/kernel/config upon receipt of the
> module loading uevent, but if the configfs module has not called its
> init function yet, then this directory will not exist and the mount unit
> fails. A similar situation exists for sys-fs-fuse-connections.mount, as
> the fuse sysfs mount point is created during the fuse module's init
> function. If udev is faster than module initialization then the mount
> unit would fail in a similar fashion.
> 
> To fix this race, delay the module KOBJ_ADD uevent until after the
> module has finished calling its init routine.
> 
> References: https://github.com/systemd/systemd/issues/17586
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Nice fix:
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
