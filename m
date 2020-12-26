Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFD2E2F4D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 23:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgLZWjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 17:39:41 -0500
Received: from mr85p00im-ztdg06011801.me.com ([17.58.23.199]:50666 "EHLO
        mr85p00im-ztdg06011801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgLZWjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 17:39:41 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Dec 2020 17:39:41 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1609021814;
        bh=Eq3D1c72GuOg2RBFHPn9NToYOGFV7SaZQRuw7v3N/RY=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=V/WX8fR4u6lD+eN5oeUj0Z5AcJRSb77MyAHZCPbFZn1rzetFel+o1V3L6Dg+yfk96
         0HSLqWV/9OuPYj9nQwO9/lvPChGG+kRa6Rpp3NxfdL+uovQU1mY+nDrBQg8Ksp7crt
         kJR/FaVarrt04T5x8R4mns/B1R4z6oJVOfIrS0F/iZh5Y2QezoccsQp1/6NQj8HBZm
         hCaRvrrmazQ6fp2XVOxJ59kQkuLcy7I6qiOKDVXEBS8T1v2W5+bwLSA23Mkqxd+dnT
         LuUb2fWmr1UFeisKSR6D6qlm7gnaifEBxomJ7i9bSP+61v1TyVe8OmgocHc7hLg0gj
         Yb4kzrAv8eIhg==
Received: from tbodt-pro.attlocal.net (99-130-36-163.lightspeed.frokca.sbcglobal.net [99.130.36.163])
        by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id 8443AC05C2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 22:30:14 +0000 (UTC)
From:   Theodore Dubois <tblodt@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: linux.git is broken on a case-insensitive filesystem
Message-Id: <080A3B31-608F-4A36-A5DE-B75670D2452E@icloud.com>
Date:   Sat, 26 Dec 2020 14:30:13 -0800
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-26_10:2020-12-24,2020-12-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=991 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2012260153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently hacking on Linux trying to run a sort of UML-style thing =
on macOS (please don't question my sanity :), and I've run into various =
issues stemming from macOS having a case-insensitive filesystem.=20

The one you run into immediately is: there are a number of files (mostly =
in netfilter) that have different uppercase and lowercase versions. =
net/netfilter/xt_DSCP.c and net/netfilter/xt_dscp.c are quite different. =
Last I checked, git would pseudo-randomly pick one of these to check =
out, and then show the other one as having unstaged changes making it =
look like the first one. This causes problems when switching branches. =
I've worked around this with a sparse checkout that excludes these =
files, but it's not great.

The gitignore also contains the pattern *.s, which excludes *.S as well =
when git is ignoring case.

Is there any interest in fixing these?

~Theodore

