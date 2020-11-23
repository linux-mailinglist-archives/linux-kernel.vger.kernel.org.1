Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE32C0E79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbgKWPIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:08:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35652 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgKWPIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:08:38 -0500
X-Greylist: delayed 3915 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 10:08:37 EST
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANDxD9j168015
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Q2rFAOwVVzItQ341YSbZcp+mAOfSksMJLdZ/NsOt4U0=;
 b=SCtbOZfIXtyR7C4ANMjwSGhQk9bWBfUa1i0oj5rB0rAdcdPlRLU4dkxYeh9ik6mzDMfu
 0cdHEA7EBYqtWI4TbSrVMz7aDT1LuJSuo7VDCWZZsPHqQyxOJDifEsB4bNvYxnqC0k9i
 OiyCHYupCP41QBkYfKdi/WnOzf5XdFBFVslsoHx0DNS9+66wstwK81Jpwz+DLbgOojId
 LtionbqjlpJcElna+jkKPnIsFTc7/Be3N25/gTWW6VN54t6KhZVUlCpc2YwmHUF2PJb/
 VuAz35RVeCZ1QuuifxerkEQMNvzacO44PEhZqhLjUOWfssMWhr+MwMnp5BJv+yC0fDps pA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 34xtaqgs9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:03:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ANE0tkk006289
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:01:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34yctuufdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:01:21 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ANE1KtE016948
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:01:20 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Nov 2020 06:01:20 -0800
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     mihai.carabas@oracle.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re [PATCH] add support for pci in the pvpanic driver
Date:   Mon, 23 Nov 2020 15:18:44 +0200
Message-Id: <1606137524-11681-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
References: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=938 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9813 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=955 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011230096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andy:

>Hmm... It was a bit of a long time...
>Have you seen [1]?

>[1]:
>https://lore.kernel.org/lkml/20201027175806.20305-1->andriy.shevche...@linux.intel.com/

I have seen that patchset after I sent mine. Do you want me to rebase and redo
the the pvpanic patchset of adding PCI support on top of yours? Or were you
refering at the fact that I added your Rb? 


Any other feedback on this patchset?

Thank you,
Mihai Carabas
