Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D261B5F10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgDWPYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 11:24:19 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:16379 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgDWPYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:24:19 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 11:24:18 EDT
IronPort-SDR: /hbHqgLehMC96EACJ5+drsFQvhIzNXnKAAQ0mbktBYTREh6QIV+38FPynIL4nsUVuXSf2gVoiF
 5Hn7zN/jDjJ3uZMRdwgWhPR1nyYLHjqvCB7zBXgdum7wX2RAMAdcg9QtEIveY1lqED6BcExdqt
 RzUrKGVzXPYsepX41zjMuOj4o85W/0L++Q7sXNLhF1nyISmFrRak0J4zj0CLwqzLej+O6RRjiS
 qRNFvfdryFDhkkxQ5TU0eXqjUWUIbOitHCDzy/+eUueLsT2jFdPBdNICSGiwUe7ETePX13aTKh
 gic=
X-IronPort-AV: E=Sophos;i="5.73,307,1583186400"; 
   d="scan'208";a="277228178"
From:   =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
To:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
Subject: [PATCH 0/3] tee: add support for session's client UUID generation
Date:   Thu, 23 Apr 2020 18:16:58 +0300
Message-Id: <20200423151701.111231-1-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Apr 2020 15:17:07.0183 (UTC) FILETIME=[407487F0:01D61982]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEE Client API defines that from user space only information needed for
specified login operations is group identifier for group based logins.

REE kernel is expected to formulate trustworthy client UUID and pass that
to TEE environment. REE kernel is required to verify that provided group
identifier for group based logins matches calling processes group
memberships.

TEE specification only defines that the information passed from REE
environment to TEE environment is encoded into on UUID.

In order to guarantee trustworthiness of client UUID user space is not
allowed to freely pass client UUID.

Vesa Jääskeläinen (3):
  tee: add support for session's client UUID generation
  tee: optee: Add support for session login client UUID generation
  [RFC] tee: add support for app id for client UUID generation

 drivers/tee/Kconfig      |   1 +
 drivers/tee/optee/call.c |   6 +-
 drivers/tee/tee_core.c   | 188 +++++++++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  16 ++++
 4 files changed, 210 insertions(+), 1 deletion(-)

-- 
2.17.1

Notes:

This patcheset has been designed so that it can be iteratively intergrated
meaning that the application ID (RFC patch) part can be left for later when
there is agreed solution for that.

TEE specification leaves Linux behavior undefined. It does not define any
UUID value for name space. UUID in here is randomly generated with uuidgen
tool.

I have also include amdtee people as this method probably should also be
applied in there.

Using op-tee@lists.trustedfirmware.org instead of tee-dev@lists.linaro.org as
latter is deprecated old list.

Original issue in OP-TEE OS tracker:
https://github.com/OP-TEE/optee_os/issues/3642

Related reviews and demonstration for the concept:
https://github.com/linaro-swg/linux/pull/74
https://github.com/OP-TEE/optee_client/pull/195
https://github.com/OP-TEE/optee_test/pull/406
