Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D9421C7D4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 09:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGLHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 03:12:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36458 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGLHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 03:12:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06C73MtK102063
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
 b=VwVQ9Z1/H+EhaNpYZ+KmtSUvStjd9CfjSRUMqjdBIzTmjfJTxRhvNYI9zBAp6HiwnBQJ
 jK6CbjYN6spfaeYdfhee10oquReDY/efQuYe15YtVSnqI/vRtGw+dYRoIxCLucgbOjt5
 Q57FVuVxutZahAUUl/azsygW8IDYvjlWtnxNaRGKLA4njntjhtgNb0AY1tHyXEvlyF8K
 jeaP3JMz2oJ+OcyhQv9bILaY9pYkfguh5Uq7C3MEoIiVy9qnldHuGMqDYuvZivM8PulF
 /relsLtQk9cXnFgbjUQH79TwThqyaXcv/Ty5o4hNutKOysXvav4BhAl/qLuuPeNdIuwm lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32762n2mty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:12:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06C73RDw046853
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:12:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 327q6nmrgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:12:37 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06C7Caws016135
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:12:36 GMT
Received: from [10.0.0.100] (/221.221.54.15)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 Jul 2020 00:12:35 -0700
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jacob Wen <jian.w.wen@oracle.com>
Message-ID: <27b02b33-b713-1a64-c520-e8ce8905387a@oracle.com>
Date:   Sun, 12 Jul 2020 15:12:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9679 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 phishscore=0 malwarescore=0 mlxlogscore=736 bulkscore=1 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007120054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9679 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=733 lowpriorityscore=2
 bulkscore=2 suspectscore=2 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007120054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel

