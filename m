Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128861E5136
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE0Wcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 18:32:47 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19485 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0Wcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:32:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eceea340000>; Wed, 27 May 2020 15:31:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 May 2020 15:32:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 May 2020 15:32:46 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 22:32:46 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 22:32:45 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.87.74]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eceea8d0003>; Wed, 27 May 2020 15:32:45 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] mm/gup: introduce pin_user_pages_locked(), use it in frame_vector.c
Date:   Wed, 27 May 2020 15:32:41 -0700
Message-ID: <20200527223243.884385-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590618676; bh=3HVQJ69JpREzS+emj65oCEPFlHEr7iCFwnPdzvYkzb4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=cwrLkk4zDYCn1Y2kahQFb/QXzCbjO/4SwmkT300jDsKrjoc4Y3f59ST/jJawachim
         VqGbwfn8mMCDtEucu/VghkEzX0r/v1fif6l+bXkWhQUSUOGM204Z4qCXcs4IsqMuet
         mmL1JNoQrUWdD5dcwUP0O40X7nzyoUszDFWEy/wNbpIwEQCIAFZjEVSU+PrLiYPLsj
         ZhlACmsC6x/D5krHvTYJZ3MraK6IMtymnSGR4Jmmv8N8xyZiXFLgalWFA8yWIuP+yl
         QYA8Byl02HYvK3kwexZPIxL9UdFPHnD9wEy0PBmwVR9IgQavoPzLi6kjpUrg5y9Tpx
         qiHNB/LsI/fOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This applies on top of the pin_user_pages_unlocked() patch that I sent
earlier [1].

This adds yet one more pin_user_pages*() variant, and uses that to
convert mm/frame_vector.c.

With this, along with maybe 20 or 30 other recent patches in various
trees, we are close to having the relevant gup call sites
converted--with the notable exception of the bio/block layer.


[1] https://lore.kernel.org/r/20200518012157.1178336-2-jhubbard@nvidia.com

John Hubbard (2):
  mm/gup: introduce pin_user_pages_locked()
  mm/gup: frame_vector: convert get_user_pages() --> pin_user_pages()

 include/linux/mm.h |  2 ++
 mm/frame_vector.c  |  7 +++----
 mm/gup.c           | 30 ++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)


base-commit: 9cb1fd0efd195590b828b9b865421ad345a4a145
--=20
2.26.2

