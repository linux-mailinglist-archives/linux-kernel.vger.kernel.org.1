Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F742F2C48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392969AbhALKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:08:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48204 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390366AbhALKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:08:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C9tJ6j063075;
        Tue, 12 Jan 2021 10:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qke5d5/aNaSSKkThN5FT7wSxphV5md/SPNTgBKloGFo=;
 b=LKqXS39KXK3pfLIXVuq47zf+WMd80DpW7E++m/8GDK0B/jkmjAQHFPn1MT8a6zwoP+LF
 5i4NRUTgCZKWIuCdx6XuS/7sY6D3SDs+uyMi/sgvQPNt/RzTaPiNcqC5Mi6EEwEoMqGO
 F5WOIgDoR3n0bjYcpBUCdKqumTZ/s1l+lWLRnorlRhDGy0AVj6QQTihbgpmwvn8GsR72
 f6M2b6czEpm4tPKHpScyN4Lkebo5SS7aAy7RgKdlBzjTwKyE/YMSJlrRJCLt88GfkEwD
 AEAwHIKLdc/gSuuNG5OBelqsrENCfWboBrbUax8yDIu5hFJPBNGGrE7cvBIc44zf4aWf BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjwfsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 10:07:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C9pjg3181291;
        Tue, 12 Jan 2021 10:07:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360ke69p35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 10:07:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CA7JpG003574;
        Tue, 12 Jan 2021 10:07:20 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 02:07:18 -0800
Date:   Tue, 12 Jan 2021 13:07:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to
 profile_name[]
Message-ID: <20210112100706.GF5083@kadam>
References: <20210111114638.16530-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111114638.16530-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:46:38AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent change added a new BOOTUP_DEFAULT power profile mode
> to the PP_SMC_POWER_PROFILE enum but omitted updating the
> corresponding profile_name array.  Fix this by adding in the
> missing BOOTUP_DEFAULT to profile_name[].
> 

Still not enough to prevent the array overflow.  It needs POWERSAVE as
well.

regards,
dan carpenter

