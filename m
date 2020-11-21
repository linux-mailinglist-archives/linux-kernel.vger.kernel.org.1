Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689B62BC1C6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgKUTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:38:13 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53591 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgKUTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:38:13 -0500
Received: from grover.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0ALJawZB029948;
        Sun, 22 Nov 2020 04:36:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0ALJawZB029948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1605987419;
        bh=GqoLNdoBKH71HuPfIdb3wMMQhGxLSlKNiwT62cmDdxc=;
        h=From:To:Cc:Subject:Date:From;
        b=wOH9ZHxBUKlGAnVCDOwBKig6qJ69ARviC7/Hx/GJyiQD70QEQ+6ntuoP9pWCPgtVJ
         XuETkrYRxd1Fy8tK9vnHpTVUN4DBG1xugCxQvhrTYHOWuRcRUfD26q49eN7CsD/Qy5
         PIH+bfqjQCru1/XM1z0k2h3Yc11wWkmqXVDAGlrDAhsSKwnT+5Htn2qvhdn53GIZUx
         dA9WQBh2G4KM92yKDAYaIpDyeimgRCKGm2AES78kFolyVYitGERsfgYrcnvorvmdQl
         PMW5YtZDktYFKiVaTfVUxkiwwPXVNMPpedS+X3J+TGKEdSVN6Xy1ij7Y8MsaEqWyiv
         z7AeOfVk4jfmQ==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] ARC: build: fix various issues in arc boot Makefile
Date:   Sun, 22 Nov 2020 04:36:51 +0900
Message-Id: <20201121193657.51441-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (6):
  ARC: build: remove non-existing bootpImage from KBUILD_IMAGE
  ARC: build: add uImage.lzma to the top-level target
  ARC: build: add boot_targets to PHONY
  ARC: build: move symlink creation to arch/arc/Makefile to avoid race
  ARC: build: remove unneeded extra-y
  ARC: build: use $(READELF) instead of hard-coded readelf

 arch/arc/Makefile      | 20 +++++++++++++-------
 arch/arc/boot/Makefile | 18 ++++--------------
 2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.25.1

