Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8472964D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369595AbgJVStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:49:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39370 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369574AbgJVStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:49:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201022184931euoutp02c941c58846d594b6b937fac07f38b65c~AZQx_fmkZ1741317413euoutp02u
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 18:49:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201022184931euoutp02c941c58846d594b6b937fac07f38b65c~AZQx_fmkZ1741317413euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603392571;
        bh=ulSXh/cd3CvLln4/0VsmhicH5c/hH1gjsOOblkY+T6c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=cJNBLrq/2P8F80hPm5WBv6D8lPM/jQ/ofS4wju6aFFpv1ZNA5Zj2tFZKqbPkIYegS
         gHaHbtt1HyJrAszCu1BsAtPcUBISDIIw5RIV1vv1uZ9rSb2vrArbEiFi+dhjCJlull
         UYQvCE/w9HikOUBlfzEpTOJn289JO7R8q4Xmcm+0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201022184920eucas1p1f056dff42a322d11d4a69d61a51a9174~AZQn3qmXB1498014980eucas1p1t;
        Thu, 22 Oct 2020 18:49:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.C9.06318.034D19F5; Thu, 22
        Oct 2020 19:49:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201022184920eucas1p11fbcddc199309d9de8b57d9636d7f6fb~AZQnaqZnf1485314853eucas1p1o;
        Thu, 22 Oct 2020 18:49:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201022184920eusmtrp2c66fb2f1cdc9330a22063d88ada6c9e0~AZQnaGFE_1450214502eusmtrp2k;
        Thu, 22 Oct 2020 18:49:20 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-46-5f91d43002ab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DE.7D.06017.034D19F5; Thu, 22
        Oct 2020 19:49:20 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201022184920eusmtip2329a7238bafd0a9342865955bd3ae024~AZQnOy3j22529025290eusmtip2-;
        Thu, 22 Oct 2020 18:49:20 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bart=C5=82omiej=20=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2] checkpatch: ignore generated CamelCase defines and enum
 values
Date:   Thu, 22 Oct 2020 20:49:16 +0200
Message-Id: <20201022184916.7904-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87oGVybGG3xZomvxYa2GxcYZ61kt
        Zt9/zGJx89AKRovLu+awWaw9cpfdgc1jVkMvm8eXVdeYPfq2rGL0+LxJLoAlissmJTUnsyy1
        SN8ugSuj+/sd1oLF7BVPTu9ga2D8x9rFyMkhIWAicXf+azBbSGAFo8SE3RJdjFxA9hdGibmr
        5jFCOJ8ZJRZfeMYG09G6bhk7RGI5o8S+g5PZIJznjBIvbjcxgVSxCThK9C89ATSXg0NEIFXi
        90NDkBpmgX2MEjvvTWEGqREWCJF4s20RC4jNIqAq0bHuNdgGXgEriY4FG6Duk5doX74dKi4o
        cXLmE7B6fgEtiTVN18FsZqCa5q2zmUEWSAg0s0ts23qAHaLZReL9laNQg4QlXh3fAhWXkfi/
        cz4TyHESAvUSkyeZQfT2MEpsm/ODBaLGWuLOuV9sIDXMApoS63fpQ4QdJb4eB7kBpJVP4sZb
        QYgT+CQmbZvODBHmlehoE4KoVpFY178HaqCURO+rFYwQtofEl5+/GScwKs5C8tgsJM/MQti7
        gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4mRmBKOf3v+NcdjPv+JB1iFOBgVOLhTZgw
        MV6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJ
        zU5NLUgtgskycXBKNTAy/kh6ceJu4F+eI16nZq18MmMp15W8Vx8WNRtx+72w3HVhqZ30pJyH
        xqq3xc51l8RlBBqv/TL7SUXd69DrCmcz5676PtVEufSl40HDexOW6G+4IVzCtDi0rmh9lLPe
        fEOtlIrU57LHp6dWTJn8d6qT+5zDR988ebl3a7NlUyH76rTaNe3bH/1wVWIpzkg01GIuKk4E
        AGmFU40lAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4PV2DKxPjDY7+5bf4sFbDYuOM9awW
        s+8/ZrG4eWgFo8XlXXPYLNYeucvuwOYxq6GXzePLqmvMHn1bVjF6fN4kF8ASpWdTlF9akqqQ
        kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfR/f0Oa8Fi9oonp3ew
        NTD+Y+1i5OSQEDCRaF23jL2LkYtDSGApo8T7qTuYuhg5gBJSEivnpkPUCEv8udbFBlHzlFFi
        SttXsGY2AUeJ/qUnwGwRgXSJrYvOgRUxC+xjlNh/dDE7SEJYIEhi1+J1YEUsAqoSHetes4HY
        vAJWEh0LNkBdIS/Rvnw7VFxQ4uTMJywgRzALqEusnycEEuYX0JJY03SdBcRmBipv3jqbeQKj
        wCwkHbMQOmYhqVrAyLyKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMCa2Hfu5ZQdj17vgQ4wC
        HIxKPLwJEybGC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQOxOZpUST
        84HxmlcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgVE8JZVdfgaj
        emRfrqRPS2xeQ7aHzyJbTv0iyZ1x66w3KO5e07Gt6qdv43nLQhb/7Q/+N39j2f3v99pl/SvW
        5bd86PJ4+vKqhYTMrNkGhm88XxfvvJKkbuDSl2eiH+XgnvStRXtG4MXcCxaMTV89ViuL3Fa/
        bGGh0/fHfuO5Qv3595pP6myTU2Ipzkg01GIuKk4EALNlUymfAgAA
X-CMS-MailID: 20201022184920eucas1p11fbcddc199309d9de8b57d9636d7f6fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201022184920eucas1p11fbcddc199309d9de8b57d9636d7f6fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201022184920eucas1p11fbcddc199309d9de8b57d9636d7f6fb
References: <CGME20201022184920eucas1p11fbcddc199309d9de8b57d9636d7f6fb@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore autogenerated CamelCase-like defines and enum values like
DRM_MODE_CONNECTOR_Unknown or ETHTOOL_LINK_MODE_Asym_Pause_BIT.

Syggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
Changes in v2
 - use a more general regexp suggested by Joe Perches

 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..7e67d565e903 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5295,6 +5295,8 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore some autogenerated defines and enum values
+			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
 #Ignore SI style variants like nS, mV and dB
-- 
2.26.2

