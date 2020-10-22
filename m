Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D2295ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509587AbgJVImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:42:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:23104 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504344AbgJVImS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:42:18 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201022084215epoutp0166c388fe482ec74c1047dcbe6d8c2952~AQ_kRrlHf1324613246epoutp01A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 08:42:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201022084215epoutp0166c388fe482ec74c1047dcbe6d8c2952~AQ_kRrlHf1324613246epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603356135;
        bh=3pRanJtqs6m1VnXTiaCCeosnmCyEa5FkI6psu20Jj4E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=umdGQtOHLOwV01JOyr9+4ToDFynomBCPcyA93TWDa8QLLMMiAAl6FGr2uyV0cac0h
         ftpu36wpt1isDRBRcXlZe1fq+Fh6sftweLTTggUXM5kQluh/6t8T3SmVqYH+iWXSaI
         DZ/II1xmg1Ul4VOymCmNKx6+pzb7g9VRqLGmIsOA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201022084215epcas1p47a3040479b934b4d6ce02b0b8b62a4f5~AQ_j-m9Sl1011510115epcas1p4S;
        Thu, 22 Oct 2020 08:42:15 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CH17p36XZzMqYkb; Thu, 22 Oct
        2020 08:42:14 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.66.09577.6E5419F5; Thu, 22 Oct 2020 17:42:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201022084214epcas1p3989473275756ebb83ad2b31dca545a51~AQ_i07zDy2025020250epcas1p3T;
        Thu, 22 Oct 2020 08:42:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201022084214epsmtrp11271ec5044dcac69c58efe0fba30b1ce~AQ_i0USmk2852528525epsmtrp1P;
        Thu, 22 Oct 2020 08:42:14 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-2e-5f9145e60c93
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.7D.08604.5E5419F5; Thu, 22 Oct 2020 17:42:14 +0900 (KST)
Received: from namjaejeon01 (unknown [10.88.104.63]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201022084213epsmtip28e9cee47908b94f03b896b9289bf34f8~AQ_irZM2K0637206372epsmtip2d;
        Thu, 22 Oct 2020 08:42:13 +0000 (GMT)
From:   "Namjae Jeon" <namjae.jeon@samsung.com>
To:     "'Linus Torvalds'" <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "'Sungjong Seo'" <sj1557.seo@samsung.com>
Subject: [GIT PULL] exfat update for 5.10-rc1
Date:   Thu, 22 Oct 2020 17:42:14 +0900
Message-ID: <020201d6a84f$3d93fdc0$b8bbf940$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdaoBoWfd14k3cn/QWmGUDdxBbSU9Q==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7bCmru4z14nxBn92iVpc3jWHzWLLvyOs
        Fo/63rI7MHucmPGbxaNvyypGj8+b5AKYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        DA0K9IoTc4tL89L1kvNzrQwNDIxMgSoTcjJWfelgLejnrTg6v4O9gfEAVxcjJ4eEgInEr0lT
        WboYuTiEBHYwSlw/do4JwvnEKPH55nEo5xujxMk9r5hgWp5M3A/VspdRon/CbnYI5yWjxI7l
        18Cq2AR0Jf792c/WxcjBISJgJvFtiSNImFnAX6Lt6mGwEmGgktnNF1lAbBYBVYlj7y8zgti8
        ApYSR1cvZYGwBSVOznzCAtErL7H97RxmiCMUJH4+XcYKYosI6ElM3n6aGaJGRGJ2ZxszyD0S
        AufYJU42rIS62kXiz8InbBC2sMSr41vYIWwpiZf9bewgd0oIVEt83A81v4NR4sV3WwjbWOLm
        +g2sICXMApoS63fpQ4QVJXb+nssIsZZP4t3XHlaIKbwSHW1CECWqEn2XDkMdIC3R1f4BaqmH
        xJXDC5kmMCrOQvLkLCRPzkLyzCyExQsYWVYxiqUWFOempxYbFpgix/UmRnAa1LLcwTj97Qe9
        Q4xMHIyHGCU4mJVEeHerT4wX4k1JrKxKLcqPLyrNSS0+xGgKDPaJzFKiyfnARJxXEm9oamRs
        bGxhYmZuZmqsJM77R7sjXkggPbEkNTs1tSC1CKaPiYNTqoGpQ+9hd7fG1lfMZYeNzaY2vrNr
        Xbcysfgn67G6NRYM2l82e4f17atIvB6stmvS0d1r996ftvFX1fwp/LfCHqdPe3ghYEdIwL0f
        3D3isae+1TNcbnkde+kGW5OS/2avSV6FHMpbreO8a71v851b9fT6JJ//qz65nm/hsW74JHY1
        QfR6eLDIJMNaSfFyTgOp+ZU5GwUZDjitlepPb/G1nLDu8EXx2foJkdH+hxkVXc8xtCzr2hQp
        l3zIK9j8p9GeOXEhAbx3n/5Zu9zqe6jBgeNvUx7Lx8X9cf77i1vI893moNqfe2V3LdzfqWHr
        8btx+ebKrDVvz+5fnSt1wl25lul/M/OdCsk7c2bO9t29dPtOJZbijERDLeai4kQAkzkJ+wwE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvO4z14nxBg9mMFpc3jWHzWLLvyOs
        Fo/63rI7MHucmPGbxaNvyypGj8+b5AKYo7hsUlJzMstSi/TtErgyVn3pYC3o5604Or+DvYHx
        AFcXIyeHhICJxJOJ+1m6GLk4hAR2M0ocnfiNGSIhLXHsxBkgmwPIFpY4fLgYouY5o8SZN9+Y
        QGrYBHQl/v3ZzwZSIyJgJvFtiSOIySzgL3H/sjtIhTBQxezmiywgNouAqsSx95cZQWxeAUuJ
        o6uXskDYghInZz5hgWjVk2jbCFbCLCAvsf3tHKhjFCR+Pl3GCmKLAJVM3n6aGaJGRGJ2Zxvz
        BEbBWUgmzUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgObC3N
        HYzbV33QO8TIxMF4iFGCg1lJhHe3+sR4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rw3ChfGCQmk
        J5akZqemFqQWwWSZODilGpjcpvAv3B482Vq+OsdgOfsmyf52w8JH6sw75y++IHOZ6d13T96j
        K7ykHLaetvg3J44xuiNudq/PnNIviruTrv3ddLTSziKziE3R7F7Qkz2bMyRZLrHWfI/4Hvbr
        cAhba4drZq3nSuepyVm7lxSbxXCfro9pvaL8pTbCuYxZsM8iak+7zbZDL3NM6qLtrDi+Tfr8
        SoCFf0nxQfl1z/UzkjbfuLpaRHnp7+OuD6Y/qT2TGfxh+d0Ff+zu77skO+t5WmaVeIDGkhMm
        miX1Qt3zjBZaL879NuFwZPWde/xhi7c78nW8KrG0eCN4YoHsz5KM3H1ZvXI8y8/+UA5QOdb3
        b++PyvDvXye2SDLMjzpRxqrEUpyRaKjFXFScCACiQLal2wIAAA==
X-CMS-MailID: 20201022084214epcas1p3989473275756ebb83ad2b31dca545a51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201022084214epcas1p3989473275756ebb83ad2b31dca545a51
References: <CGME20201022084214epcas1p3989473275756ebb83ad2b31dca545a51@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat update pull request for v5.10-rc1. I add description of
this pull request on below. Please pull exfat with following ones.

Thanks!

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.10-rc1

for you to fetch changes up to eae503f7eb0509594076a951e422e29082385c96:

  exfat: remove useless check in exfat_move_file() (2020-10-22 08:29:12 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Replace memcpy with structure assignment.
  - Remove unneeded codes and use helper function i_blocksize().
  - Fix typos found by codespell.

----------------------------------------------------------------
Namjae Jeon (1):
      exfat: fix misspellings using codespell tool

Tetsuhiro Kohada (5):
      exfat: eliminate dead code in exfat_find()
      exfat: remove useless directory scan in exfat_add_entry()
      exfat: replace memcpy with structure assignment
      exfat: remove 'rwoffset' in exfat_inode_info
      exfat: remove useless check in exfat_move_file()

Xianting Tian (1):
      exfat: use i_blocksize() to get blocksize

 fs/exfat/dir.c      |  29 ++++------
 fs/exfat/exfat_fs.h |   4 +-
 fs/exfat/file.c     |   4 +-
 fs/exfat/inode.c    |   5 +-
 fs/exfat/namei.c    | 153 +++++++++++++++++++---------------------------------
 fs/exfat/nls.c      |   2 +-
 fs/exfat/super.c    |   1 -
 7 files changed, 71 insertions(+), 127 deletions(-)

