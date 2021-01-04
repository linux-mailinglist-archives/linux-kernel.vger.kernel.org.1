Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78A42E9FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 23:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbhADWUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 17:20:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58098 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADWUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 17:20:21 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MImkr050419;
        Mon, 4 Jan 2021 22:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lIH/kquWfLYyDT0ExzrwgCA4EN7fnzgIWbeQ+9ozz0E=;
 b=Urk7Wz3kySADtOFVefsg+IqfDa2J2rR6pXzcaDbkIXeic2oq91KE1X5ySaOgw1FaL00/
 M0jQoOoh6l5GF38sGSi+3aMw3nLQz4LPz2eok+vgEmB8SZPu2GkIdhUo++iWD89PzogR
 twzXFZDC6UGg0fH0h+JWefDUIUk74n4Y7IE7vWaQtPEv2Ng1wYf2luERcizsmlvF22PU
 /v/YfkJAm39iznEQyIcbi0xOQPiV2PcCqi91DSsL8MhPMzsmF9yfF1oXhTFBWQrouu14
 yAwzPpib+W0CI15bjFwOeBNhQbvBba2fnKO/gahDu5QrkS0kCPdQlGrOo3rdK3M+Tyoc Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 35tebaph2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 22:19:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104M0KWS103879;
        Mon, 4 Jan 2021 22:17:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35uxnrsyj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 22:17:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104MHIev011507;
        Mon, 4 Jan 2021 22:17:18 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 14:17:18 -0800
Subject: Re: [PATCH 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210104065843.5658-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c7eb286f-a810-b91b-5ad4-82ef26b898e3@oracle.com>
Date:   Mon, 4 Jan 2021 14:17:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210104065843.5658-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040133
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 10:58 PM, Muchun Song wrote:
> If the refcount is one when it is migrated, it means that the page
> was freed from under us. So we are done and do not need to migrate.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/migrate.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
