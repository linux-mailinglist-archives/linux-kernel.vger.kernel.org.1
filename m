Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA062A3EFC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgKCIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgKCIdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:33:16 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58E822264;
        Tue,  3 Nov 2020 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604392395;
        bh=deF+fK72tiaXqpNY2MrAivUNgrfVThGfY/QMTaLUbEs=;
        h=Date:From:To:Cc:Subject:From;
        b=HaWItFiUHwtH0HLRS9x1z0XhNFDfclO7tBgO0EHEWynBVvbbevgYENVL5pCqWxjGq
         5Pfpbz5j1m4pZkyc6hj8hzYsF6iVQ5oh5CvXeiapVLK+dNNQDcQZOmLLezIeMP0nnt
         zqgIsdpld3QRkXA2fxuC1KT6TK50KFOGvcyYk4CI=
Date:   Tue, 3 Nov 2020 09:34:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sudeep Dutt <sudeep.dutt@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: remove mic/index from misc-devices/index.rst
Message-ID: <20201103083408.GA2511903@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent removal of the misc/mic/ directory, the documentation
build now warns because we forgot about this index file.

Fix that up so that there are no more warnings here.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---

I'll just take this in my tree as I have a bunch of other documentation
fixups to get to Linus soon, if no one objects, as the breakage came
from my tree in the first place.


diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 46072ce3d7ef..64420b3314fe 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -24,7 +24,6 @@ fit into other categories.
    isl29003
    lis3lv02d
    max6875
-   mic/index
    pci-endpoint-test
    spear-pcie-gadget
    uacce
