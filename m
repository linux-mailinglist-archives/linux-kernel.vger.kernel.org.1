Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756622C6769
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgK0OGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbgK0OGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:06:11 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 054B721D7A;
        Fri, 27 Nov 2020 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606485970;
        bh=ab8SJSugM+B2NTl6XNB4DaiPGIK3slWUOP5B/VhwJag=;
        h=From:To:Cc:Subject:Date:From;
        b=eox4lCjxI4A536S3pQxTdS4G6E95RJ2JwHegyYRoxAjHWvYb2A77sXZ93XqZCBRs5
         3xCfRsGYsXDTAgKRO57LqYjTGQVt85BWX0apQN/bSua+RTLjxUdPDQy+N8CAlId5RZ
         OoXMIzYFsfDVxgAWMMzLQGi4nP76EEvBFNaWHIwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     balbi@kernel.org
Cc:     peter.chen@nxp.com, willmcvicker@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/5] USB: Gadget SuperSpeed fixes and a cleanup
Date:   Fri, 27 Nov 2020 15:05:54 +0100
Message-Id: <20201127140559.381351-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some small USB gadget fixes, and one cleanup patch at the end.

The first 4 of these come from the Android kernel tree, where they fix
the gadget drivers to work properly as a SuperSpeed device, odd that no
one else has hit this before.

The last one is a cleanup patch removing the abuse of likely/unlikely
from the f_fs driver.

Changes from v2:
 - added reviewed-by from Peter
 - added additional whitespace to patch 3
 - added 4th patch
 - added this cover letter

Greg Kroah-Hartman (1):
  USB: gadget: f_fs: remove likely/unlikely

Will McVicker (2):
  USB: gadget: f_rndis: fix bitrate for SuperSpeed and above
  USB: gadget: f_midi: setup SuperSpeed Plus descriptors

taehyun.cho (2):
  USB: gadget: f_acm: add support for SuperSpeed Plus
  USB: gadget: f_fs: add SuperSpeed Plus support

 drivers/usb/gadget/function/f_acm.c   |   2 +-
 drivers/usb/gadget/function/f_fs.c    | 182 +++++++++++++-------------
 drivers/usb/gadget/function/f_midi.c  |   6 +
 drivers/usb/gadget/function/f_rndis.c |   4 +-
 4 files changed, 103 insertions(+), 91 deletions(-)

-- 
2.29.2

