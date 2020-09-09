Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEF26269F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 07:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgIIFOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 01:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIFOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:14:49 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E249221D43;
        Wed,  9 Sep 2020 05:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599628489;
        bh=EONsNBav4eRxYlNYFP1LXxj6M47uluI/f56SSBbZ0l4=;
        h=From:To:Cc:Subject:Date:From;
        b=TxavcDTMMDYy1W7yt+Z+2Bx1j5IsglpAdi6VtwDPKb/QJld9ieLQjFbpXAodG3VAO
         gwx+rNpg0xf3DV6pl3C5YTQ441dUP5FSnBiLOZClk+oXrwmAZOTT4ao8sUszr11aGN
         iCOCdn4DWG9igU68jVw6D38iEKLX6hdrPJgiXw/8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kFsRS-00BfBp-AL; Wed, 09 Sep 2020 07:14:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3 0/2] use SPDX also for GFDL documents
Date:   Wed,  9 Sep 2020 07:14:31 +0200
Message-Id: <cover.1599628249.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 438 document files that were licensed under the
free versions of GNU Free Document License.

The free versions are the one that doesn't contain invariant
parts.

The first patch adds the license files.  As newer documents
aren't supposed to use them without being dual-licensed
with GPLv2, add them under LICENSE/deprecated.

The second patch replaces a boilerplate text from 
ring-buffer-design.rst by the corresponding SPDX header.

The other documents are all under Documentation/uapi/media.

A separate patchset, to be merged via the linux-media tree
will cover those.

---

v3:
  - Added Valid-License-Identifier, SPDX_URL, Usage-Guide and License-Text 
    meta-tags.

Mauro Carvalho Chehab (2):
  LICENSE: add GFDL deprecated licenses
  docs: trace: ring-buffer-design.rst: use the new SPDX tag

 Documentation/trace/ring-buffer-design.rst |  26 +-
 LICENSES/deprecated/GFDL-1.1               | 377 +++++++++++++++++++
 LICENSES/deprecated/GFDL-1.2               | 417 +++++++++++++++++++++
 3 files changed, 795 insertions(+), 25 deletions(-)
 create mode 100644 LICENSES/deprecated/GFDL-1.1
 create mode 100644 LICENSES/deprecated/GFDL-1.2

-- 
2.26.2


