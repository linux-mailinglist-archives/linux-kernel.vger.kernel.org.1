Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBAC22E119
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgGZQGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 12:06:14 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40373
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgGZQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:06:13 -0400
X-IronPort-AV: E=Sophos;i="5.75,399,1589234400"; 
   d="scan'208";a="355317427"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 18:06:12 +0200
Date:   Sun, 26 Jul 2020 18:06:11 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: question about sharedsubtree.rst
Message-ID: <alpine.DEB.2.22.394.2007261801150.13826@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Documentation/filesystems/sharedsubtree.rst contains the following:

        ->mnt_flags
	        takes two more flags to indicate the propagation status of
	        the vfsmount.  MNT_SHARE indicates that the vfsmount is a shared
	        vfsmount.  MNT_UNCLONABLE indicates that the vfsmount cannot be
		replicated.

I guess that MNT_SHARE should be MNT_SHARED.  More seriously,
MNT_UNCLONABLE seems to have never existed, except in a patch proposed in
2005: https://lists.linuxcoding.com/kernel/2005-q3/msg01881.html
Should there be a description of MNT_UNBINDABLE instead?  Or something
else?

thanks,
julia
