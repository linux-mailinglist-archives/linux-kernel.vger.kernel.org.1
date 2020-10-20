Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CED287A30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgJHQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:41:09 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48814 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbgJHQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tJSHvT1QhRVl+G04VHp6oB+MDJJauXzKMIhMmzCIDDM=; b=JDQckPsnqx2Oaw6HFTKEzUPn9U
        s0753/8WVoatgJv+xtmbAsF4c4zqOzUc/YqvUYMEFsTjEG1VcGwTEombW+H9WLoUGVZQpK52xdmlO
        +o4jcGqeeyVGWL+rjhx7d7EWr9V5aVoyaacHvA14HbwtCgKWt4mkA8A4E7VZoYkFPCmDSLUo6z1ul
        //9KTVPIh6V6PONtOq4b9NcnbJRMl+Vjv3WBZep0foEwsIYciktSqkR71Aa2cTHMVpqf8fP1szqWi
        2CDLVt4uQjmrpm2oOyyhyoFx17OG6dAUZ4RG39mopzNfUCodw9HDMFpBpNBDL3NKHXVVZTboHZ5Q1
        F+ih8EbA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxz-0000ig-Pu; Thu, 08 Oct 2020 10:40:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxy-0003HI-Pu; Thu, 08 Oct 2020 10:40:30 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Thu,  8 Oct 2020 10:40:14 -0600
Message-Id: <20201008164024.12546-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, sbates@raithlin.com, logang@deltatee.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Subject: [PATCH blktests v3 01/11] common/fio: Remove state file in common helper
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of each individual test removing this file, just do it
in the common helper.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 common/fio     | 1 +
 tests/nvme/010 | 1 -
 tests/nvme/011 | 1 -
 tests/nvme/012 | 1 -
 tests/nvme/013 | 1 -
 5 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/common/fio b/common/fio
index 8bfad4238dda..94c65c107a14 100644
--- a/common/fio
+++ b/common/fio
@@ -181,6 +181,7 @@ _run_fio_rand_io() {
 _run_fio_verify_io() {
 	_run_fio --name=verify --rw=randwrite --direct=1 --ioengine=libaio --bs=4k \
 		--iodepth=16 --verify=crc32c "$@"
+	rm -f local*verify*state
 }
 
 _fio_perf_report() {
diff --git a/tests/nvme/010 b/tests/nvme/010
index 9d96d7803be3..0188e842213e 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -52,7 +52,6 @@ test() {
 	losetup -d "${loop_dev}"
 
 	rm "${file_path}"
-	rm -f local*verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/011 b/tests/nvme/011
index 06dc568fb6ea..543dbe840874 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -48,7 +48,6 @@ test() {
 	_remove_nvmet_port "${port}"
 
 	rm "${file_path}"
-	rm -f local-write-and-verify*state
 
 	echo "Test complete"
 }
diff --git a/tests/nvme/012 b/tests/nvme/012
index 8110430e49d4..1dbd59804ed7 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -63,7 +63,6 @@ test() {
 
 	losetup -d "${loop_dev}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 176b11b9ccb5..df7f23e69252 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -58,7 +58,6 @@ test() {
 	_remove_nvmet_subsystem "${subsys_name}"
 	_remove_nvmet_port "${port}"
 
-	rm -f local*verify*state
 	rm "${file_path}"
 	rm -fr "${mount_dir}"
 
-- 
2.20.1

