Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EABA295D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896913AbgJVLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:01:35 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60920 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437981AbgJVLBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:01:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201022110116euoutp016289c968e40edfda74ffaea1d489db2c~AS38FaLuw0664506645euoutp01e
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:01:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201022110116euoutp016289c968e40edfda74ffaea1d489db2c~AS38FaLuw0664506645euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603364476;
        bh=WXh6KSLjfsIWCxvXkGPP8zikiSknYc4DH8BQj+F9+Fc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UXg1spMnO6ebSYbOnHa9jAhGgbfVTjd5yP4+f5E+CeBMIk0Tmkp/FuBwD/j4xlnzA
         sFaGpT0d5Ko/RIGoFYVO5xh5dKMJ/d2+vbKGu+rgl8KmpCoRaet1GtwzOwUYGufK3E
         ztq5TD04B1mmP8yL/zh5atZgjDNYJkP4dWvby5O0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201022110115eucas1p293d71c950bb5f0f6f031634f2924d569~AS37meoTo0082000820eucas1p20;
        Thu, 22 Oct 2020 11:01:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3E.DE.05997.B76619F5; Thu, 22
        Oct 2020 12:01:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201022110115eucas1p216072f5c30091771421c8c595242d3b9~AS37U-3tp3058030580eucas1p25;
        Thu, 22 Oct 2020 11:01:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201022110115eusmtrp296978df2ae6977f739916c9585dd5e4d~AS37UUYJn1928219282eusmtrp2p;
        Thu, 22 Oct 2020 11:01:15 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-9c-5f91667ba817
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.E2.06017.B76619F5; Thu, 22
        Oct 2020 12:01:15 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201022110115eusmtip15ff1dbf2b7b27ff46f8b621d457d3c14~AS37LH7Xv1088410884eusmtip1S;
        Thu, 22 Oct 2020 11:01:15 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bart=C5=82omiej=20=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] checkpatch: ignore ethtool CamelCase constants
Date:   Thu, 22 Oct 2020 13:01:13 +0200
Message-Id: <20201022110113.3505-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djPc7rVaRPjDU5v17H4sFbDYuOM9awW
        s+8/ZrG4eWgFo8XlXXPYLNYeucvuwOYxq6GXzePLqmvMHn1bVjF6fN4kF8ASxWWTkpqTWZZa
        pG+XwJVxeUlwwX+2ijUTp7I1MN5l7WLk5JAQMJGY/PwDcxcjF4eQwApGiYlTmtlBEkICXxgl
        DjTJQyQ+M0p8uHmfGabjwYFrTBCJ5YwS0090sUA4zxkl9vSuYwOpYhNwlOhfegJoBweHiECq
        xO+HhiA1zAL7GCV23psCNklYwF5ixe+9jCA2i4CqxK51d8BW8wpYSeyduBBqm7xE+/LtbBBx
        QYmTM5+wgNj8AloSa5qug9nMQDXNW2eD/SAh0M4ucXPLDyaIZheJm8d/skDYwhKvjm9hh7Bl
        JP7vnM8EcpyEQL3E5ElmEL09jBLb5vyAqreWuHPuFxtIDbOApsT6XfoQYUeJH4eeQLXySdx4
        KwhxAp/EpG3TmSHCvBIdbUIQ1SoS6/r3QA2Ukuh9tYIRwvaQ+PPyA/sERsVZSB6bheSZWQh7
        FzAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMKKf/Hf+yg3HXn6RDjAIcjEo8vB98
        JsQLsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6Ykl
        qdmpqQWpRTBZJg5OqQbGcKk2kxP7LoW+XHxh/VHX5Z9mBryfsPLCj46qXKen+9wkz0m02uxt
        tp/IEHF9vn/5pM0NN1nNcsNuWczeVuOnftt75u+DXavYzOfHT0swK9E5eZFncvIumZOsWRfz
        X25Y/i914swfM1Wk+UttmiK48px/fncz6bHYUmvWtW5/3xvHT395fNm3K7EUZyQaajEXFScC
        AMSxs1okAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Xd3qtInxBvd/Slh8WKthsXHGelaL
        2fcfs1jcPLSC0eLyrjlsFmuP3GV3YPOY1dDL5vFl1TVmj74tqxg9Pm+SC2CJ0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4vCS44D9bxZqJU9ka
        GO+ydjFyckgImEg8OHCNqYuRi0NIYCmjxLk9bxi7GDmAElISK+emQ9QIS/y51sUGUfOUUeLM
        x+fsIAk2AUeJ/qUnwAaJCKRLbF10DqyIWWAfo8T+o4vBioQF7CVW/N7LCGKzCKhK7Fp3ByzO
        K2AlsXfiQmaIDfIS7cu3s0HEBSVOznzCAnIEs4C6xPp5QiBhfgEtiTVN11lAbGag8uats5kn
        MArMQtIxC6FjFpKqBYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjYtuxn1t2MHa9Cz7E
        KMDBqMTD+8FnQrwQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAr0zkVlK
        NDkfGK15JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYYyMap5v9
        6Lxy3fxgfY9XFr+WgxjDpS+i/1fELmVzc6q4uJJ92QyBt1mr1nm92C9w1C2zPI/rLjM/bym3
        LAub+QyH+RzaV8sUP3etDyqKs5s1MYWlRfuQSOzpyO8rhVPMd/1gCD31436obr4jZ8I2z83b
        Ig4+36N/+N6jslX/g+QXbV48pahbiaU4I9FQi7moOBEAlic+D54CAAA=
X-CMS-MailID: 20201022110115eucas1p216072f5c30091771421c8c595242d3b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201022110115eucas1p216072f5c30091771421c8c595242d3b9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201022110115eucas1p216072f5c30091771421c8c595242d3b9
References: <CGME20201022110115eucas1p216072f5c30091771421c8c595242d3b9@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore CamelCase constants describing Ethernet link parameters defined
in include/uapi/linux/ethtool.h.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..31789c090140 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5295,6 +5295,10 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore constants from include/uapi/linux/ethtool.h
+			    $var !~ /^ETHTOOL_LINK_MODE_[0-9A-Za-z_]+_BIT$/ &&
+			    $var !~ /^ADVERTISED_[0-9A-Za-z_]+$/ &&
+			    $var !~ /^SUPPORTED_[0-9A-Za-z_]+$/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
 #Ignore SI style variants like nS, mV and dB
-- 
2.26.2

