Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894712709E7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgISCDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgISCDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:03:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B0EC0613CE;
        Fri, 18 Sep 2020 19:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f/YzrMVS/+6EGG57fwOsw36jtmyBI4RY3lourFt19Ms=; b=Q6VfzcZe0nG0zjl01WjfCTsYd9
        kk/Ls2jbyYsrtxe1xBwimrdWUvMf3My8M5M5JqFsHYCdmHEiJBpKppylmULvvYVv+M2TLZairYjNY
        I8AEDHvwOIlJsePUMDb++ZjPHWOjgJPjbfFU42E5YJYdMsCbjhAxLXlfGqY/Lu06MaAo8lSv27UZy
        T4r5qAXhyHa6H7/FRIn7mByl2P1fIK9BPWzG+bpX54FB56US1CaV2XCU7FUG4NbMT8D2PrFYAtq8A
        nT7bkA72ymrcH23zBhVmO0hg9YgI6ac9LxNCocWV1CtHBUK5sB5yG7wDlruB0avLQhCSUBs8vLQF9
        Fvx3Odcw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJSDa-0007QP-0r; Sat, 19 Sep 2020 02:03:14 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: filesystems: mount_api: fix headings
Message-ID: <adaf123c-b394-f78c-53c0-671d7fda45e7@infradead.org>
Date:   Fri, 18 Sep 2020 19:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix capitalization in two headings, correct one verb, and
demote one heading to a section heading.

Fixes: 791a17ee1973 ("docs: filesystems: convert mount_api.txt to ReST")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/mount_api.rst |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-next-20200917.orig/Documentation/filesystems/mount_api.rst
+++ linux-next-20200917/Documentation/filesystems/mount_api.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 ====================
-fILESYSTEM Mount API
+Filesystem Mount API
 ====================
 
 .. CONTENTS
@@ -479,7 +479,7 @@ returned.
         int vfs_parse_fs_param(struct fs_context *fc,
 			       struct fs_parameter *param);
 
-     Supply a single mount parameter to the filesystem context.  This include
+     Supply a single mount parameter to the filesystem context.  This includes
      the specification of the source/device which is specified as the "source"
      parameter (which may be specified multiple times if the filesystem
      supports that).
@@ -592,8 +592,7 @@ The following helpers all wrap sget_fc()
 	    one.
 
 
-=====================
-PARAMETER DESCRIPTION
+Parameter Description
 =====================
 
 Parameters are described using structures defined in linux/fs_parser.h.

