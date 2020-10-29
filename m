Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1229E667
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgJ2I3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:29:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45158 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgJ2I3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:29:11 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201029060024epoutp015eee03c8faa35811f01dac8beb35cb55~CYSPh3SkS2347623476epoutp01A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:00:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201029060024epoutp015eee03c8faa35811f01dac8beb35cb55~CYSPh3SkS2347623476epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603951224;
        bh=AVFZ41yfoGJbnrF61ttA9c/mV4Q/PKwj+c27fsfdASE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=r9Y+CQ8QRebs78FCk4N1E1RZmZyXHMrHEqVW0cAPXZ7tOQgBCZpJ6mVfHxrAODNXw
         t3SwZKiuqvVJWut18zHr6blbpyI5KXPlShuWSP5FaiX+g3PnefQQBpGq4h9hMb1PeO
         vHvkPBqMLt/6QdmbYV3aLMFyPwpyT6LKJieKDoKo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20201029060020epcas2p17917ddaa6b3d46c2fdb8eafcd458a7a1~CYSMLJtg82079020790epcas2p1f;
        Thu, 29 Oct 2020 06:00:20 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.189]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CMFCl0qGzzMqYkt; Thu, 29 Oct
        2020 06:00:19 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.CA.09588.27A5A9F5; Thu, 29 Oct 2020 15:00:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20201029060015epcas2p2c9969a6782d8214bcbefa36ffad8e10c~CYSHLaUsa2442124421epcas2p2t;
        Thu, 29 Oct 2020 06:00:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201029060015epsmtrp2983d382bc5b3f180d10195aa89260701~CYSHKvgg30868108681epsmtrp2B;
        Thu, 29 Oct 2020 06:00:15 +0000 (GMT)
X-AuditID: b6c32a45-355ff70000002574-a4-5f9a5a727641
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.C9.13470.E6A5A9F5; Thu, 29 Oct 2020 15:00:15 +0900 (KST)
Received: from Dabang.dsn.sec.samsung.com (unknown [12.36.155.59]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201029060014epsmtip1fcd80ef6f576e5445f2a7410441b50d2~CYSHAVrT93091130911epsmtip1S;
        Thu, 29 Oct 2020 06:00:14 +0000 (GMT)
From:   Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     janghyuck.kim@samsung.com, hyesoo.yu@samsung.com,
        pullip.cho@samsung.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: arm64: Kconfig: support for nodes spanning other nodes
Date:   Thu, 29 Oct 2020 15:19:50 +0900
Message-Id: <20201029061950.4217-1-janghyuck.kim@samsung.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmuW5R1Kx4gzuPRC3eL+thtPjbeYHV
        YvOcYotNj6+xWlzeNYfN4l/vQUaLljumDuwea+atYfTYtKqTzWPzknqPvi2rGD0+b5ILYI3K
        sclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBukFJoSwx
        pxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoWKBXnJhbXJqXrpecn2tlaGBgZApUmZCT
        ce/MBvaC12wVs/umsTcwnmftYuTkkBAwkfh7dweQzcUhJLCDUeLq1CMsIAkhgU+MEvOfOUEk
        vjFKvJ2ylBmm43xnK1THXkaJSzMWQjnfGSW6Nh5mAqliE9CXaJ96mR3EFhFgkVj5/TsLSBGz
        wANGibW3f4IlhAXsJX5dmMUGYrMIqEr0rnzICGLzCthKLNl0DupAeYmnvcuZIeKCEidnPgG7
        jxko3rx1NjPIUAmBY+wS71t3MkI0uEj87HoAdauwxKvjW9ghbCmJz+/2skHY9RL3l7xgh2ie
        wChxYMkyqAZjiVnP2oEGcQBt0JRYv0sfxJQQUJY4cgtqL59Ex+G/7BBhXomONiGIRnWJdzM3
        MUGEZSWu/zGHCHtIfJp+mgkSorESB1/MZ5vAKD8LyTOzkDwzC2HtAkbmVYxiqQXFuempxUYF
        hsiRuokRnA61XHcwTn77Qe8QIxMH4yFGCQ5mJRHeF4Iz44V4UxIrq1KL8uOLSnNSiw8xmgKD
        dyKzlGhyPjAh55XEG5oamZkZWJpamJoZWSiJ84au7IsXEkhPLEnNTk0tSC2C6WPi4JRqYJpa
        7PTy+Spr4eQAk7nntnTdMqz/YPNn6p3qgqMeS153PBRkV//eLbKmZuWaqrY5X/UrpJa2dX63
        CZ98qfFaTuDvyRNYl7Csvzb/x+pdkxLMntvsXG9mk3mKp2Ptb0nltU9d3A9al7x69SI8eD9z
        ourDNZOW1yrwbS5J+hrN6njD/HKf0xnD6hcTZNJPyC1Uu6/bxn6Q4fCpMywvDy2Wvyn1Oz34
        beypwrwP+1y171XsLrIwXr30Vv/RayYLVO+GK/rcXfS6YV5OrkXbng+/wiap2/3drbKwan6a
        xfEvGsFLs6fE3RNped31z/xuxrXco7uOdFVqrXt2zHNRCJtlvs7jiQqND4uaL4sybLq1wiJI
        iaU4I9FQi7moOBEAQODS0hAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnG5+1Kx4g9YZjBbvl/UwWvztvMBq
        sXlOscWmx9dYLS7vmsNm8a/3IKNFyx1TB3aPNfPWMHpsWtXJ5rF5Sb1H35ZVjB6fN8kFsEZx
        2aSk5mSWpRbp2yVwZdw7s4G94DVbxey+aewNjOdZuxg5OSQETCTOd7YC2VwcQgK7GSUOdm1j
        h0jISvSs2MQMYQtL3G85AlX0lVFi5pHFYAk2AX2J9qmXwRpEBFgkVn7/zgJSxCzwjFFi1a5f
        YCuEBewlfl2YxQZiswioSvSufMgIYvMK2Eos2XQO6gx5iae9y5kh4oISJ2c+YQGxmYHizVtn
        M09g5JuFJDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgENXS3MG4fdUH
        vUOMTByMhxglOJiVRHhfCM6MF+JNSaysSi3Kjy8qzUktPsQozcGiJM57o3BhnJBAemJJanZq
        akFqEUyWiYNTqoFpkTXL0adPXJJrDs3uWvUv0H+dm6/qdMPuRy1bRZOuToqyzA3brLpsgkHQ
        VfmKxbNMmRLWcX+5LqtyqVJAW21tjmKTd/TpBfdn1xzWePFi7uINMcpbb1hU8olMz+bd8HPj
        3c0ajWFmllxxMR81b/tW9G4vizl4iSf2qhDrm2O9HaL7qy/Mt3JS5E1l2G7ltz6q1a62y1Bh
        x4xmuTs31m7//WnZ3mU7X1Wyudhf1Vyhx3G9yvagXnztXo6Oo93Wt4XqHibIiubn70w4IMS+
        ur6+/Oa/fx+Z63M2PmtdqhJXt/uxgfTvDb7RJqqeG5afiPhpYLG43t1++6XuWZoPk1+61ybp
        NbEYTuBeX7io9akSS3FGoqEWc1FxIgAYTo0FwAIAAA==
X-CMS-MailID: 20201029060015epcas2p2c9969a6782d8214bcbefa36ffad8e10c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201029060015epcas2p2c9969a6782d8214bcbefa36ffad8e10c
References: <CGME20201029060015epcas2p2c9969a6782d8214bcbefa36ffad8e10c@epcas2p2.samsung.com>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support NUMA systems whose physical address layout is not continuous
on one node, nodes spanning other nodes feature is required.

Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>
---
 arch/arm64/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 49b8d017cba6..18ff7ce9dd60 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1004,6 +1004,14 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 config HOLES_IN_ZONE
 	def_bool y
 
+# Some NUMA nodes have memory ranges that span
+# other nodes.  Even though a pfn is valid and
+# between a node's start and end pfns, it may not
+# reside on that node.  See memmap_init_zone()
+# for details.
+config NODES_SPAN_OTHER_NODES
+	depends on NUMA
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
-- 
2.28.0

