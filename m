Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D01F1D57
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgFHQbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 12:31:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49212 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgFHQbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:31:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058G9MiM066579;
        Mon, 8 Jun 2020 16:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=tYYiyASbtZojC1CqxMm1OnNF5Ok/Fu5wHgNs6PBEbjI=;
 b=EBplNvgag2qURqZrox4y/jD+u/uvttDNaSmSql1f6SDchYho4FZFfDyP+lQGmQ0+hB2P
 XAHa7f+/6kHA3wolXPjC3UyU/T3EBvg2sh/+D7N/o2/2kuO/z/Pyl+2/35s3PKwn5AJa
 /KyCDz90Rp38qu/yJH8E0MHU9AQBZ2YBHIn5H0ccOJMwWS/VF1nz3mCjWChikVEZM+Wy
 cj2VIKHvImqIQ6MEz/hIVRt+UGQVf0X7ziCcIXMhzWTZS97wSxMz8jNGY3vxPQxopt6D
 wsSeaPzDJjbftNJtL4wh9+jO19R/lrT3V6LRAYa0g8WKJvEp+E/F6Q3q/FRutQMM/Y83 SQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jqyugn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 16:31:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058GDrHh012273;
        Mon, 8 Jun 2020 16:29:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn2vev4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:29:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058GSxWn012649;
        Mon, 8 Jun 2020 16:29:00 GMT
Received: from localhost.localdomain (/10.211.9.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 09:28:58 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, kbusch@kernel.org, axboe@fb.com
Subject: [PATCH 0/2] nvme: simple cleanup
Date:   Mon,  8 Jun 2020 09:20:00 -0700
Message-Id: <20200608162002.17017-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=593 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=621 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup without functional change.

Thank you very much!

Dongli Zhang


