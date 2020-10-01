Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2CF2809EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgJAWQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:16:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgJAWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:16:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091MENjD097963;
        Thu, 1 Oct 2020 22:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=rcNEhB86M+CYRIygEwZNOZ5+kd39xbKxCwIr6icS5VY=;
 b=ggt3gjtznimrAsOODjM/0OI4Fz4SMVCcQSIEMqko8mtu2pMrRybvxqblOtn7tz8S1gUx
 qkLHMJsIpns18nJYpY1bdG2AjjJsHYRkIexzhHlSFo4ivpHrWElwQyeLazWlmkCvAST9
 JicNJItpgtqYC9GmP01zWtiMPe8yL9ze5rJWc1fN5pQzbD+ylsHADxV32ffY6uPEogGR
 qs+Q1d9c+BVa+kWg59ZHzhIyhtLftEelQOfs3et2B5agqOVcf3POOs/vYUZhWxCjuLrC
 Jm5zzWZwuHglcOM9lkFQx4dgm+82FPNUIyt/Rp+zmcP9C87svrfKWD/uMe5//R2N3LQG AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33su5b8rpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 01 Oct 2020 22:16:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 091MAxtU179769;
        Thu, 1 Oct 2020 22:16:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 33uv2hgu3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Oct 2020 22:16:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 091MGJRx012687;
        Thu, 1 Oct 2020 22:16:20 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Oct 2020 15:16:19 -0700
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5cdfac2f-ca4c-3cd7-39af-ba942f483a21@oracle.com>
Date:   Thu, 1 Oct 2020 15:16:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9761 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 11:00 PM, Anshuman Khandual wrote:
> Add following new vmstat events which will track HugeTLB page migration.
> 
> 1. HUGETLB_MIGRATION_SUCCESS
> 2. HUGETLB_MIGRATION_FAILURE
> 
> It follows the existing semantics to accommodate HugeTLB subpages in total
> page migration statistics. While here, this updates current trace event
> 'mm_migrate_pages' to accommodate now available HugeTLB based statistics.
> 
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
