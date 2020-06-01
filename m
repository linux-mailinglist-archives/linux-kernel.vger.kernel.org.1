Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FECE1E9B43
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 03:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFABZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 21:25:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgFABZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 21:25:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0511HouB057042;
        Mon, 1 Jun 2020 01:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=df8qxLo7s+iLAVcbs65NCApHg9ADlNh/I0GX/uRW+eI=;
 b=pY5x/RXVVNt/3US/CmrlZMKV/GkgG9W4bqW4XZMpyT14AitvkkbNWiN5KAkdHDj/NY6z
 EeEHCGHoRiHQYzrD8ZesWu3nSj/8dkSz2iZlVSfG1NxEly5uLX2qS8dze/bE/v7l3s1T
 DfGpwd3bijJvUV+E+uAv2fsLLJmnwspQv01mfhDbKIEViRX+4pbNL/jHxuxBU7khJMjP
 hT3em+FRE8XgkOMS3U7H0lq98S12obb5ciuUGP3rIOsliUjRB/v3fn9IjT1HIIJUwpNO
 pwAiuRNO8Dnjxhle0e8vcvtdGlZG0eN3Jm4t0WR6xTmI7CDIww6rnYoNJEGVzsPx/cCk 7Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31bewqmbst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 01:24:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0511I068053043;
        Mon, 1 Jun 2020 01:23:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25h5dmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 01:23:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0511NuWd004187;
        Mon, 1 Jun 2020 01:23:58 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 31 May 2020 18:23:56 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     nbd@other.debian.org, linux-block@vger.kernel.org
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] nbd: two cleanup
Date:   Sun, 31 May 2020 18:16:00 -0700
Message-Id: <20200601011602.29381-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=8 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=729
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=8 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=749
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006010008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just cleanup without functional change.

Thank you very much!

Dongli Zhang


