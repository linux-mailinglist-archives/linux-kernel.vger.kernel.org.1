Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513FB29D716
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbgJ1WUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731713AbgJ1WRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA762476A;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895014;
        bh=vQy4Wj2/128w8VuNXvSDUT+Qmy5LUeiCcDIUos7b3f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zVfMYAjmSBc53Tsbh3NBmqK8JA2ZLm9p+EEme4M6SOGhFR1LSEhXTG8Z4uGDn53BW
         0Qs6ieDJ9SQxGIUtiISc7/1jjuP+0IVk676G98339S+IKcd9eNmddL1dnIvnNKudd4
         vm6Liq2Uvoe4NYqDpSOV/5GY6Jv9YiNfAz4tCVwU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hl6-EN; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 09/33] scripts: get_abi.pl: use bold font for ABI definitions
Date:   Wed, 28 Oct 2020 15:23:07 +0100
Message-Id: <504787aba47002194da1eab14da18ab507e3d5ea.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're using tables, let's distinguish the ones used by ABI
by using a bold font.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f2c8a888148b..b4868ee8e955 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -300,6 +300,7 @@ sub output_rest {
 			my $len = 0;
 
 			foreach my $name (@names) {
+				$name = "**$name**";
 				$len = length($name) if (length($name) > $len);
 			}
 
-- 
2.26.2

