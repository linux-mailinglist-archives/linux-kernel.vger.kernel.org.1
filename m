Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E792744B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIVOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:50:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:50:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MEnQ4M073827;
        Tue, 22 Sep 2020 14:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=S9KWFNn/vRgpsXs4MtviFndlv7prp+5DufiR9UkfpMs=;
 b=xOcjyx5R94qsWEQxBnOCyar8emso4G9Zusr6Nx8jfkhWqN+e5AMeyw9grggRXJYiU5+5
 ACEWEVU7wqzVB6LfLWTAqT5NOY7OqIzT32u+yeJ5TfbLobTnXaiuU4s27Zm1Xck/Qv+v
 zX5lAk3X9d2jaxUTeG5YYGxtXxkBfPyFsEtvQ0QRlWXGbX+hxJDs0Gmd9MbDx+Lve7nL
 AKLqNZuJ5fBvn6nq6dTBJK36VOCoFbT2ltory+eYJYVqHLkAGo1yc/yzLXlKFXLt8LHi
 b7YkNl60m5e5o3c9j8dk0HUI4Vp5WdgGitXjrB0tibicnudbHXiSxkHCJbEn38jeHReN kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33q5rgbjhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 14:50:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MEjsa0082922;
        Tue, 22 Sep 2020 14:50:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33nuw43m4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 14:50:40 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08MEobui024733;
        Tue, 22 Sep 2020 14:50:38 GMT
Received: from [10.74.86.236] (/10.74.86.236)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 07:50:37 -0700
Subject: Re: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
To:     Philipp Rudo <prudo@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Dave Young <dyoung@redhat.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com> <20200922125809.66690d54@ibm>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <7ee09899-6724-e932-f73d-d49da0fb4a9d@oracle.com>
Date:   Tue, 22 Sep 2020 10:50:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200922125809.66690d54@ibm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/22/20 6:58 AM, Philipp Rudo wrote:
>
> AFAIK pstore requires UEFI to work. So what's the point to enable it on non-UEFI
> systems?


I don't think UEFI is required, ERST can specify its own backend. And that, in fact, can be quite useful in virtualization scenarios (especially in cases of direct boot, when there is no OVMF)


-boris

